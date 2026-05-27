extends Control

@onready var word_label = $CenterContainer/MarginContainer/VBoxContainer/WordLabel

@onready var meaning_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/MeaningLabel
@onready var synonym_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/SynonymLabel
@onready var antonym_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/AntonymLabel
@onready var degree_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/DegreeLabel
@onready var family_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/FamilyLabel
@onready var pos_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/POSLabel

@onready var level_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/LevelLabel

@onready var seen_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/SeenLabel
@onready var correct_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/CorrectLabel
@onready var wrong_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/WrongLabel
@onready var accuracy_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/AccurateLabel

@onready var back_button = $CenterContainer/MarginContainer/VBoxContainer/BackButton


func _ready():

	back_button.pressed.connect(
		func():
			AudioManager.play_button_click()
			queue_free()
	)


func setup(word_id):

	if !WordDB.WORDS.has(word_id):
		return

	var word = WordDB.WORDS[word_id]

	word_label.text = word.get(
		"text",
		"Unknown"
	)

	# =====================
	# MEANING
	# =====================

	meaning_label.text = (
		Localization.tr_ui("meaning") + ": "
		+ Localization.tr_meaning(
			word.get("text", "")
		)
	)

	# =====================
	# GROUPS
	# =====================

	var groups = word.get(
		"groups",
		{}
	)
	
	var level = word.get(
		"level", {}
	)

	synonym_label.text = (
		Localization.tr_ui("synonym") + ": "
		+ array_to_group_text(
			groups.get("synonym", [])
		)
	)

	antonym_label.text = (
		Localization.tr_ui("antonym") + ": "
		+ get_antonym_text(
			groups.get("synonym", [])
		)
	)

	degree_label.text = (
		Localization.tr_ui("degree") + ": "
		+ array_to_group_text(
			groups.get("degree", [])
		)
	)

	family_label.text = (
		Localization.tr_ui("family") + ": "
		+ array_to_family_text(
			groups.get("family", [])
		)
	)

	pos_label.text = (
		Localization.tr_ui("pos") + ": "
		+ array_to_pos_text(
			groups.get("type", [])
		)
	)
	
	level_label.text = (
		Localization.tr_ui("level") + ": "
		+ str(level)
	)
	
	back_button.text = Localization.tr_ui("back")

	# =====================
	# TRACKING
	# =====================

	var data = SaveManager.get_word_data(word_id)

	var seen = int(data.get("seen", 0))
	var correct = int(data.get("correct", 0))
	var wrong = int(data.get("wrong", 0))

	seen_label.text = (
		Localization.tr_ui("seen") + ": "
		+ str(seen)
	)

	correct_label.text = (
		Localization.tr_ui("correct") + ": "
		+ str(correct)
	)

	wrong_label.text = (
		Localization.tr_ui("wrong") + ": "
		+ str(wrong)
	)

	# =====================
	# ACCURACY
	# =====================

	var accuracy = 0

	if seen > 0:
		accuracy = int(
			(float(correct) / seen) * 100
		)

	accuracy_label.text = (
		Localization.tr_ui("accuracy") + ": "
		+ str(accuracy)
		+ "%"
	)
	
func get_antonym_text(
	synonym_groups: Array
) -> String:

	var result = []

	for group in synonym_groups:

		# =====================
		# FORWARD
		# =====================

		if Relation.ANTONYM_GROUPS.has(group):

			result.append(
				Relation.ANTONYM_GROUPS[group]
			)

		# =====================
		# REVERSE
		# =====================

		for key in Relation.ANTONYM_GROUPS.keys():

			if Relation.ANTONYM_GROUPS[key] == group:

				result.append(key)

	# remove duplicate
	result = Array(result).duplicate()
	result = result.filter(
		func(x):
			return x != null
	)

	if result.is_empty():
		return Localization.tr_ui("none")

	return array_to_group_text(result)


func array_to_group_text(arr: Array) -> String:

	if arr.is_empty():

		return Localization.tr_ui("none")

	var result = []

	for value in arr:

		result.append(
			Localization.tr_group(value)
		)

	return ", ".join(result)


func array_to_family_text(arr: Array) -> String:

	if arr.is_empty():

		return Localization.tr_ui("none")

	var result = []

	for value in arr:

		result.append(
			Localization.auto_format(value)
		)

	return ", ".join(result)


func array_to_pos_text(arr: Array) -> String:

	if arr.is_empty():

		return Localization.tr_ui("none")

	var result = []

	for value in arr:

		result.append(
			Localization.tr_pos(value)
		)

	return ", ".join(result)
