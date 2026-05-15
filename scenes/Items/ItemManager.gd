extends Node
class_name ItemManager

var items = []
var intensifier_used = false
var extra_caffeine_used = false
var handy_shortcut_used = false

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
	
func start_round():
	pass

func modify_final(point, mult, data) -> Dictionary:

	var result = {
		"point": point,
		"mult": mult
	}

	var effects = []

	for item in items:

		match item:

			# =====================
			# SYNONYM CODEX
			# =====================

			"synonym_codex":
				if !data.is_valid:
					continue
					
				if data.get("relation_type", "") == "synonym":

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

	result["effects"] = effects

	return result
