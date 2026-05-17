extends Node
class_name ItemManager

var items = []
var runtime_items = []

#var intensifier_used = false
#var extra_caffeine_used = false
#var handy_shortcut_used = false
#var phantom_hand_used = false
var golden_ratio_bonus = 0
var last_relation_type = ""
#var future_debt_used = false
var valid_word_count = 0
var played_word_count = 0
var lone_word_valid = false
var lone_word_relation = ""
var treated_as_synonym = false
#var blueprint_select_mode = false
#var blueprint_item = null

# =====================
# ADD ITEM
# =====================

func add_item(item_id: String):

	if has_item(item_id):
		return

	if item_id == "blueprint":

		items.append({
			"id": "blueprint",
			"copied_item": "",
			"locked_copy": "",
		})

	else:

		var item = {
			"id": item_id,
		}

		if item_id == "over_heaven":

			item["bonus_mult"] = 2.0

		items.append(item)

	print("ADD ITEM:", item_id)

# =====================
# REMOVE ITEM
# =====================

func remove_item(item_id: String):

	for item in items:
		if item.get("id", "") == item_id:
			items.erase(item)
			return
			
func sell_item(item_instance) -> int:

	var item_id = item_instance.get("id", "")

	var data = ItemDB.ITEMS[item_id]

	var rarity = data.get("rarity", "common")

	var value = ItemDB.get_rarity_value(rarity)

	items.erase(item_instance)

	print("\n💰 ITEM SOLD")
	print("ITEM:", item_id)
	print("RARITY:", rarity)
	print("TURN GAIN:", value)

	return value

# =====================
# CHECK ITEM
# =====================

func has_item(item_id: String) -> bool:

	for item in items:
		if item.get("id", "") == item_id:
			return true

	return false

func build_runtime_items() -> Array:

	var result = []

	for inventory_item in items:

		var item_id = inventory_item.get(
			"id",
			""
		)

		# =====================
		# NORMAL ITEM
		# =====================

		result.append({
			"id": item_id,
			"source_id": item_id,

			"turn_used": false,
			"round_used": false,

			"persistent": inventory_item
		})

		# =====================
		# BLUEPRINT
		# =====================

		if item_id == "blueprint":

			var copied = inventory_item.get(
				"locked_copy",
				""
			)

			if copied != "":

				var copied_item = find_item_instance(copied)

				result.append({
					"id": copied,
					"source_id": "blueprint",

					"turn_used": false,
					"round_used": false,

					"is_blueprint_copy": true,

					"persistent": copied_item
				})

	return result
	
func get_total_rarity_value_except(
	exclude_item
) -> int:

	var total = 0

	for item in items:

		if item == exclude_item:
			continue

		var item_id = item.get(
			"id",
			""
		)

		var data = ItemDB.ITEMS.get(
			item_id,
			{}
		)

		var rarity = data.get(
			"rarity",
			"common"
		)

		total += ItemDB.get_rarity_value(
			rarity
		)

	return total

func has_effective_item(item_id: String) -> bool:

	for item in runtime_items:

		if item.get("id", "") == item_id:
			return true

	return false

func find_item_instance(item_id):

	for item in items:

		if item.get("id", "") == item_id:
			return item

	return null

# =====================
# GET PLAYER ITEMS
# =====================

func get_items() -> Array:
	return items

# =====================
# MODIFY STEP
# =====================

func modify_step(step: Dictionary) -> Dictionary:

	var result = step.duplicate()

	print("\n===== ITEM MODIFY START =====")
	print("ORIGINAL STEP:", result)

	for item in runtime_items:

		var item_id = item.get("id", "")

		#match item_id:

		print("\nCHECK ITEM:", item_id)

	return result
	
func start_turn():

	last_relation_type = ""
	valid_word_count = 0
	played_word_count = 0
	lone_word_valid = false
	lone_word_relation = ""
	treated_as_synonym = false

	# =====================
	# LOCK BLUEPRINT
	# =====================

	for item in items:

		if item.get("id", "") == "blueprint":

			item["locked_copy"] = item.get(
				"copied_item",
				""
			)

	# =====================
	# BUILD RUNTIME
	# =====================

	runtime_items = build_runtime_items()

	# =====================
	# RESET TURN STATE
	# =====================

	for item in runtime_items:

		item["turn_used"] = false
	
func start_round():
	
	

	runtime_items = build_runtime_items()

	for item in runtime_items:

		item["round_used"] = false
		item["turn_used"] = false

func modify_final(point, mult, data) -> Dictionary:

	var result = {
		"point": point,
		"mult": mult
	}

	var effects = []
	
	treated_as_synonym = (
		data.get("relation_type", "") == "synonym"
	)

	if (
		has_item("language_glitch")
		and data.get("relation_type", "") == "antonym"
	):

		print("✅ LANGUAGE GLITCH ACTIVATED")
		print("ANTONYM TREATED AS SYNONYM")
		
		effects.append({
			"type": "Glitched",
			"item_id": "language_glitch"
		})
		
		treated_as_synonym = true

	for item in runtime_items:

		var item_id = item.get("id", "")

		match item_id:
			
			# =====================
			# SYNONYM CODEX
			# =====================

			"synonym_codex":
				if !data.is_valid:
					continue
				
				print("RELATION:", data.get("relation_type", ""))
				print("GLITCH:", data.get("is_synonym_glitch", false))	
				
				if treated_as_synonym:

					print("✅ SYNONYM CODEX ACTIVATED")
					result.point += 10

					effects.append({
						"type": "add_point",
						"value": 10,
						"item_id": "synonym_codex",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
					})

			# =====================
			# WILDCARD
			# =====================

			"wildcard":
				if !data.is_valid:
					continue
				result.mult += 1
				print("✅ WILDCARD ACTIVATED")
				effects.append({
					"type": "add_mult",
					"value": 1,
					"item_id": "wildcard",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
				})
				
			# =====================
			# CAPPUCCINO
			# =====================

			"cappuccino":

				if !data.is_valid:
					continue

				var level = data.get("word_level", "")

				if level == "B1" or level == "B2":

					print("✅ CAPPUCCINO ACTIVATED")
					print("WORD LEVEL:", level)
					print("POINT BEFORE:", result.point)
					print("ADD: +15 POINT")

					result.point += 15

					effects.append({
						"type": "add_point",
						"value": 15,
						"item_id": "cappuccino",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
					})
					
			# =====================
			# INTENSIFIER
			# =====================

			"intensifier":

				if !data.is_valid:
					continue

				if item.get("turn_used", false):
					continue

				if data.get("relation_type", "") == "degree":

					item["turn_used"] = true

					print("✅ INTENSIFIER ACTIVATED")
					print("RELATION:", data.get("relation_type", ""))
					print("MULT BEFORE:", result.mult)
					print("ADD FINAL MULT: +3")

					result.mult += 3

					effects.append({
						"type": "add_mult",
						"value": 3,
						"item_id": "intensifier",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
					})
					
			# =====================
			# EXTRA CAFFEINE
			# =====================

			"extra_caffeine":

				if !data.is_valid:
					continue

				if item.get("turn_used", false):
					continue

				print("\n☕ EXTRA CAFFEINE ACTIVATED")
				print("FIRST VALID WORD THIS ROUND")
				print("POINT BEFORE:", result.point)
				print("ADD: +25 POINT")

				item["turn_used"] = true

				result.point += 25

				print("POINT AFTER:", result.point)

				effects.append({
					"type": "add_point",
					"value": 25,
					"item_id": "extra_caffeine",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
				})
				
			# =====================
			# FAMILY GUIDE
			# =====================

			"family_guide":

				if !data.is_valid:
					continue

				if data.get("relation_type", "") == "family":

					print("✅ FAMILY GUIDE ACTIVATED")
					print("RELATION:", data.get("relation_type", ""))
					print("POINT BEFORE:", result.point)
					print("ADD: +20 POINT")

					result.point += 20

					print("POINT AFTER:", result.point)

					effects.append({
						"type": "add_point",
						"value": 20,
						"item_id": "family_guide",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
					})
					
			# =====================
			# GOLDEN RATIO
			# =====================

			"golden_ratio":

				if !data.is_valid:
					continue

				print("✅ GOLDEN RATIO ACTIVATED")
				print("PERMANENT BONUS:", golden_ratio_bonus)

				result.point += golden_ratio_bonus

				print("POINT AFTER BONUS:", result.point)

				effects.append({
					"type": "add_point",
					"value": golden_ratio_bonus,
					"item_id": "golden_ratio",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
				})
				
			# =====================
			# SCHOLAR'S THESIS
			# =====================

			"scholars_thesis":

				if !data.is_valid:
					continue

				var level = data.get("word_level", "")

				if level == "C1" or level == "C2":

					print("✅ SCHOLAR'S THESIS ACTIVATED")
					print("WORD LEVEL:", level)
					print("MULT BEFORE:", result.mult)
					print("ADD: +2 MULT")

					result.mult += 2

					print("MULT AFTER:", result.mult)

					effects.append({
						"type": "add_mult",
						"value": 2,
						"item_id": "scholars_thesis",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
					})
					
			# =====================
			# YIN AND YANG
			# =====================

			"yin_yang":

				if !data.is_valid:
					continue

				if data.get("relation_type", "") == "antonym":

					print("✅ YIN AND YANG ACTIVATED")
					print("RELATION:", data.get("relation_type", ""))
					print("FINAL MULT BEFORE:", result.mult)
					print("ADD FINAL MULT: +3")

					result.mult += 3

					print("FINAL MULT AFTER:", result.mult)

					effects.append({
						"type": "add_mult",
						"value": 3,
						"item_id": "yin_yang",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
					})
					
			# =====================
			# MAGNETIC FORCE
			# =====================

			"magnetic_force":

				if !data.is_valid:
					continue

				var current_relation = data.get("relation_type", "")

				if (
					last_relation_type != ""
					and current_relation == last_relation_type
				):

					print("✅ MAGNETIC FORCE ACTIVATED")
					print("LAST RELATION:", last_relation_type)
					print("CURRENT RELATION:", current_relation)
					print("POINT BEFORE:", result.point)
					print("ADD: +40 POINT")

					result.point += 40

					print("POINT AFTER:", result.point)

					effects.append({
						"type": "add_point",
						"value": 40,
						"item_id": "magnetic_force",
						"is_blueprint_copy":
							item.get("is_blueprint_copy", false)
					})
					
			# =====================
			# FUTURE DEBT
			# =====================

			"future_debt":

				if !data.is_valid:
					continue

				if item.get("turn_used", false):
					continue

				var discard_used = data.get("discard_used", 0)

				if discard_used <= 0:
					continue

				var bonus = discard_used * 15

				print("✅ FUTURE DEBT ACTIVATED")
				print("DISCARD USED:", discard_used)
				print("BONUS:", bonus)
				print("POINT BEFORE:", result.point)

				result.point += bonus

				print("POINT AFTER:", result.point)

				item["turn_used"] = true

				effects.append({
					"type": "add_point",
					"value": bonus,
					"item_id": "future_debt",
					"is_blueprint_copy":
						item.get("is_blueprint_copy", false)
				})
				
			# =====================
			# OVER HEAVEN
			# =====================

			"over_heaven":

				if !data.is_valid:
					continue

				if !treated_as_synonym:
					continue

				var persistent = item.get(
					"persistent",
					null
				)

				if persistent == null:
					continue

				var bonus_mult = persistent.get(
					"bonus_mult",
					2.0
				)

				print("\n🌌 OVER HEAVEN ACTIVATED")
				print("BONUS MULT:", bonus_mult)

				result.mult *= bonus_mult

				effects.append({
					"type": "mul_mult",
					"value": bonus_mult,
					"item_id": "over_heaven",
					"is_blueprint_copy":
						item.get("is_blueprint_copy", false)
				})

	result["effects"] = effects

	return result
