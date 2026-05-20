extends Control

@onready var word_label = $CenterContainer/MarginContainer/VBoxContainer/WordLabel

@onready var meaning_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/MeaningLabel
@onready var synonym_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/SynonymLabel
@onready var antonym_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/AntonymLabel
@onready var degree_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/DegreeLabel
@onready var family_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/FamilyLabel
@onready var pos_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/POSLabel

@onready var seen_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/SeenLabel
@onready var correct_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/CorrectLabel
@onready var wrong_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/WrongLabel
@onready var accuracy_label = $CenterContainer/MarginContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/LabelContainer/AccurateLabel

@onready var back_button = $CenterContainer/MarginContainer/VBoxContainer/BackButton


func _ready():

	back_button.pressed.connect(
		func():
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
		"Meaning: "
		+ word.get(
			"meaning",
			"No meaning"
		)
	)

	# =====================
	# GROUPS
	# =====================

	var groups = word.get(
		"groups",
		{}
	)

	synonym_label.text = (
		"Synonym: "
		+ array_to_text(
			groups.get("synonym", [])
		)
	)

	antonym_label.text = (
		"Antonym: "
		+ array_to_text(
			groups.get("antonym", [])
		)
	)

	degree_label.text = (
		"Degree: "
		+ array_to_text(
			groups.get("degree", [])
		)
	)

	family_label.text = (
		"Family: "
		+ array_to_text(
			groups.get("family", [])
		)
	)

	pos_label.text = (
		"POS: "
		+ array_to_text(
			groups.get("type", [])
		)
	)

	# =====================
	# TRACKING
	# =====================

	var data = SaveManager.get_word_data(word_id)

	var seen = int(data.get("seen", 0))
	var correct = int(data.get("correct", 0))
	var wrong = int(data.get("wrong", 0))

	seen_label.text = (
		"Seen: "
		+ str(seen)
	)

	correct_label.text = (
		"Correct: "
		+ str(correct)
	)

	wrong_label.text = (
		"Wrong: "
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
		"Accuracy: "
		+ str(accuracy)
		+ "%"
	)


func array_to_text(arr: Array) -> String:

	if arr.is_empty():
		return "None"

	return ", ".join(arr)
