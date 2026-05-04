extends Node
class_name Score

func build_steps(relations, level) -> Array:
	var steps = []

	if relations.is_empty():
		return steps

	# 1. chọn best relation
	var best = relations[0]

	for r in relations:
		var current_score = r.point * r.mult
		var best_score = best.point * best.mult

		if current_score > best_score:
			best = r

	# 2. base step
	steps.append({
		"type": "set_base",
		"point": best.point,
		"mult": best.mult,

		"relation_type": best.type,
		"relation_label": get_relation_label(best.type),

		"word": best.word
	})

	# 3. level bonus
	match level:
		"A1", "A2":
			steps.append(_create_level_step("add_point", 10, level, best.word))
		"B1":
			steps.append(_create_level_step("add_point", 15, level, best.word))
		"B2":
			steps.append(_create_level_step("add_point", 20, level, best.word))
		"C1":
			steps.append(_create_level_step("add_mult", 2, level, best.word))
		"C2":
			steps.append(_create_level_step("add_mult", 3, level, best.word))

	return steps


func _create_level_step(type, value, level, word):
	return {
		"type": type,
		"value": value,
		"source": "level",
		"level": level,
		"label": "Level " + level,
		"word": word
	}


func get_relation_label(type: String) -> String:
	match type:
		"synonym": return "Đồng nghĩa"
		"antonym": return "Trái nghĩa"
		"degree": return "Mức độ"
		"family": return "Gia đình từ"
		"pos": return "Cùng loại"
		_: return type
