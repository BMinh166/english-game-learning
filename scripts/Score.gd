extends Node
class_name Score

func calculate(relations, level):
	if relations.is_empty():
		return {
			"point": 0,
			"mult": 0,
			"score": 0
		}

	var best = relations[0]

	for r in relations:
		var current_score = r.point * r.mult
		var best_score = best.point * best.mult

		if current_score > best_score:
			best = r

	var point = best.point
	var mult = best.mult

	match level:
		"A1", "A2":
			point += 10
		"B1":
			point += 15
		"B2":
			point += 20
		"C1":
			mult += 2
		"C2":
			mult += 3

	var total = point * mult

	return {
		"point": point,
		"mult": mult,
		"score": total
	}
