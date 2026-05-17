extends Node
class_name Relation

static var ANTONYM_GROUPS = {
	"size_big": "size_small",
	"speed_fast": "speed_slow",
	"temperature_hot": "temperature_cold",
	"quantity_many": "quantity_few",
	"weight_heavy": "weight_light",
	"strength_strong": "strength_weak",
	"length_long": "length_short",
	"width_wide": "width_narrow",
	"hardness_hard": "hardness_soft",
	"cleanliness_clean": "cleanliness_dirty",
	"fullness_full": "fullness_empty",
	"moisture_wet": "moisture_dry",
	"flexibility_rigid": "flexibility_flexible",
	"safety_safe": "safety_danger",
	"sound_loud": "sound_quiet",
	"light_bright": "light_dark",
	"density_dense": "density_sparse",
	"height_tall": "height_short",
	"depth_deep": "depth_shallow",
	"age_new": "age_old",
	"frequency_frequent": "frequency_rare",
	"complexity_complex": "complexity_simple",
	"quality_good": "quality_poor",
	"emotion_positive": "emotion_negative",
	"intelligence_high": "intelligence_low",
	"intensity_high": "intensity_low"
}

static func has_common(arr1, arr2):
	for a in arr1:
		if a in arr2:
			return true
	return false

static func check_relation(word_a, word_b):
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
	
static func is_antonym(word_a, word_b) -> bool:
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
	
static func get_relation_words(current_word, relation_type, pool):

	var result = []

	for word in pool:

		var relations = check_relation(current_word, word)

		for r in relations:

			if r["type"] == relation_type:
				result.append(word)
				break

	return result
