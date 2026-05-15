extends Node
class_name ItemManager

var items = []
var intensifier_used = false
var extra_caffeine_used = false
var handy_shortcut_used = false
var phantom_hand_used = false
var golden_ratio_bonus = 0
var last_relation_type = ""
var future_debt_used = false
var valid_word_count = 0
var played_word_count = 0
var lone_word_valid = false
var lone_word_relation = ""
var treated_as_synonym = false

# =====================
# ADD ITEM
# =====================

func add_item(item_id: String):
	if item_id in items:
		return

	items.append(item_id)

	print("ADD ITEM:", item_id)

# =====================
# REMOVE ITEM
# =====================

func remove_item(item_id: String):
	items.erase(item_id)

# =====================
# CHECK ITEM
# =====================

func has_item(item_id: String) -> bool:
	return item_id in items

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

	for item in items:

		print("\nCHECK ITEM:", item)

		#match item:

	return result
	
func start_turn():
	intensifier_used = false
	handy_shortcut_used = false
	extra_caffeine_used = false
	phantom_hand_used = false
	future_debt_used = false
	last_relation_type = ""
	valid_word_count = 0
	played_word_count = 0
	lone_word_valid = false
	lone_word_relation = ""
	treated_as_synonym = false
	
func start_round():
	pass

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
			"type": "GLITCHED",
			"item_id": "language_glitch"
		})
		
		treated_as_synonym = true

	for item in items:

		match item:
			
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
						"item_id": "synonym_codex"
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
					"item_id": "wildcard"
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
						"item_id": "cappuccino"
					})
					
			# =====================
			# INTENSIFIER
			# =====================

			"intensifier":

				if !data.is_valid:
					continue

				if intensifier_used:
					continue

				if data.get("relation_type", "") == "degree":

					intensifier_used = true

					print("✅ INTENSIFIER ACTIVATED")
					print("RELATION:", data.get("relation_type", ""))
					print("MULT BEFORE:", result.mult)
					print("ADD FINAL MULT: +3")

					result.mult += 3

					effects.append({
						"type": "add_mult",
						"value": 3,
						"item_id": "intensifier"
					})
					
			# =====================
			# EXTRA CAFFEINE
			# =====================

			"extra_caffeine":

				if !data.is_valid:
					continue

				if extra_caffeine_used:
					continue

				print("\n☕ EXTRA CAFFEINE ACTIVATED")
				print("FIRST VALID WORD THIS ROUND")
				print("POINT BEFORE:", result.point)
				print("ADD: +25 POINT")

				extra_caffeine_used = true

				result.point += 25

				print("POINT AFTER:", result.point)

				effects.append({
					"type": "add_point",
					"value": 25,
					"item_id": "extra_caffeine"
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
						"item_id": "family_guide"
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
					"item_id": "golden_ratio"
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
						"item_id": "scholars_thesis"
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
						"item_id": "yin_yang"
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
						"item_id": "magnetic_force"
					})
					
			# =====================
			# FUTURE DEBT
			# =====================

			"future_debt":

				if !data.is_valid:
					continue

				if future_debt_used:
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

				future_debt_used = true

				effects.append({
					"type": "add_point",
					"value": bonus,
					"item_id": "future_debt"
				})

	result["effects"] = effects

	return result
