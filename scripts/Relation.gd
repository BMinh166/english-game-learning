extends Node
class_name Relation

var ANTONYM_GROUPS = {
	"size_big": "size_small",
	"speed_fast": "speed_slow"
}

func has_common(arr1, arr2):
	for a in arr1:
		if a in arr2:
			return true
	return false

func check_relation(word_a, word_b):
	var relations = []

	if has_common(word_a.groups.synonym, word_b.groups.synonym):
		relations.append({"type": "synonym", "point": 40, "mult": 2, "word" : word_b.text})
		
	if is_antonym(word_a, word_b):
		relations.append({
			"type": "antonym",
			"point": 40,
			"mult": 2,
			"word": word_b.text
		})

	if has_common(word_a.groups.degree, word_b.groups.degree):
		relations.append({"type": "degree", "point": 35, "mult": 2, "word" : word_b.text})

	if has_common(word_a.groups.family, word_b.groups.family):
		relations.append({"type": "family", "point": 30, "mult": 1, "word" : word_b.text})

	if has_common(word_a.groups.type, word_b.groups.type):
		relations.append({"type": "pos", "point": 25, "mult": 1, "word" : word_b.text})

	return relations
	
func is_antonym(word_a, word_b) -> bool:
	for group_a in word_a.groups.synonym:
		if group_a in ANTONYM_GROUPS:
			var opposite = ANTONYM_GROUPS[group_a]
			if opposite in word_b.groups.synonym:
				return true
				
		# check ngược
		for key in ANTONYM_GROUPS:
			if ANTONYM_GROUPS[key] == group_a and key in word_b.groups.synonym:
				return true

	return false
