extends Node
class_name Score

func build_steps(relations, level) -> Array:
	var steps = []

	if relations.is_empty():
		return steps

	# 1. Tìm best relation
	var best = relations[0]

	for r in relations:
		var current_score = r.point * r.mult
		var best_score = best.point * best.mult

		if current_score > best_score:
			best = r

	# 2. Base step (rất quan trọng)
	steps.append({
		"type": "set_base",
		"point": best.point,
		"mult": best.mult,
		"desc": "Best hand",
		"word": best.word
	})

	# 3. Level bonus -> convert thành step
	match level:
		"A1", "A2":
			steps.append({
				"type": "add_point",
				"value": 10,
				"desc": "Level bonus +10",
				"word": best.word
			})
		"B1":
			steps.append({
				"type": "add_point",
				"value": 15,
				"desc": "Level bonus +15",
				"word": best.word
			})
		"B2":
			steps.append({
				"type": "add_point",
				"value": 20,
				"desc": "Level bonus +20",
				"word": best.word
			})
		"C1":
			steps.append({
				"type": "add_mult",
				"value": 2,
				"desc": "Level bonus +2 mult",
				"word": best.word
			})
		"C2":
			steps.append({
				"type": "add_mult",
				"value": 3,
				"desc": "Level bonus +3 mult",
				"word": best.word
			})

	return steps
