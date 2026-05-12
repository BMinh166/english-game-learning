extends Node
class_name ItemManager

var items = []

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

func modify_final(point, mult, data) -> Dictionary:

	var result = {
		"point": point,
		"mult": mult
	}

	var effects = []

	for item in items:

		match item:

			# =====================
			# SYNONYM BOOK
			# =====================

			"synonym_book":
				if !data.is_valid:
					continue
					
				if data.get("relation_type", "") == "synonym":

					print("✅ SYNONYM BOOK ACTIVATED")
					result.point += 10

					effects.append({
						"type": "add_point",
						"value": 10,
						"item_id": "synonym_book"
					})

			# =====================
			# LUCKY PEN
			# =====================

			"lucky_pen":
				if !data.is_valid:
					continue
				result.mult += 1
				print("✅ LUCKY PEN ACTIVATED")
				effects.append({
					"type": "add_mult",
					"value": 1,
					"item_id": "lucky_pen"
				})

	result["effects"] = effects

	return result
