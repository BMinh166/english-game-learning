extends Node
class_name Relation

func has_common(arr1, arr2):
	for a in arr1:
		if a in arr2:
			return true
	return false

func check_relation(word_a, word_b):
	var relations = []

	if has_common(word_a.groups.synonym, word_b.groups.synonym):
		relations.append({"type": "synonym", "point": 40, "mult": 2, "word" : word_b.text})

	if has_common(word_a.groups.degree, word_b.groups.degree):
		relations.append({"type": "degree", "point": 35, "mult": 2, "word" : word_b.text})

	if has_common(word_a.groups.family, word_b.groups.family):
		relations.append({"type": "family", "point": 30, "mult": 1, "word" : word_b.text})

	if has_common(word_a.groups.type, word_b.groups.type):
		relations.append({"type": "type", "point": 25, "mult": 1, "word" : word_b.text})

	return relations
