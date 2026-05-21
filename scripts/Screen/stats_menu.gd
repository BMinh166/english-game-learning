extends Control

@onready var highest_score_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer1/HightScoreLabel
@onready var highest_round_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer1/HighestRoundLabel
@onready var highest_chain_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer1/HighestChainLabel
@onready var total_runs_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer1/TotalRunsLabel
@onready var play_time_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer1/PlayTimeLabel
@onready var total_words_played_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer1/TotalWordsPlayedLabel
@onready var total_correct_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer1/TotalCorrectLabel
@onready var total_wrong_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer1/TotalWrongLabel
@onready var most_used_item_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer2/MostUsedItemLabel
@onready var most_used_relation_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer2/MostUsedRelationLabel
@onready var most_correct_word_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer2/MostCorrectWordLabel
@onready var most_wrong_word_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer2/MostWrongWordLabel2
@onready var accuracy_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer2/AccuracyLabel
@onready var most_seen_word_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer2/MostSeenWordLabel
@onready var items_discovered_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer2/ItemsDiscoveredLabel
@onready var words_discovered_label = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/LabelContainer2/WordsDiscoveredLabel
@onready var back_button = $CenterContainer/MarginContainer/VBoxContainer/BackButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	update_language_ui()


func load_stats():

	var stats = SaveManager.get_statistics()

	# =====================
	# BASIC STATS
	# =====================

	highest_score_label.text = (
		Localization.tr_ui("highest_score")
		+ ": "
		+ safe_number(stats.get("highest_score"))
	)

	highest_round_label.text = (
		Localization.tr_ui("highest_round")
		+ ": "
		+ safe_number(stats.get("highest_round"))
	)

	highest_chain_label.text = (
		Localization.tr_ui("highest_chain")
		+ ": "
		+ safe_number(stats.get("highest_chain"))
	)

	total_runs_label.text = (
		Localization.tr_ui("total_runs")
		+ ": "
		+ safe_number(stats.get("total_runs"))
	)

	play_time_label.text = (
		Localization.tr_ui("play_time")
		+ ": "
		+ format_time(
			stats.get("total_play_time", 0)
		)
	)

	total_words_played_label.text = (
		Localization.tr_ui("words_played")
		+ ": "
		+ safe_number(stats.get("total_words_played"))
	)

	total_correct_label.text = (
		Localization.tr_ui("correct")
		+ ": "
		+ safe_number(stats.get("total_correct"))
	)

	total_wrong_label.text = (
		Localization.tr_ui("wrong")
		+ ": "
		+ safe_number(stats.get("total_wrong"))
	)

	# =====================
	# MOST WORDS
	# =====================

	most_seen_word_label.text = (
		Localization.tr_ui("most_seen_word")
		+ ": "
		+ safe_text(
			SaveManager.get_most_seen_word()
		)
	)

	most_correct_word_label.text = (
		Localization.tr_ui("most_correct_word")
		+ ": "
		+ safe_text(
			SaveManager.get_most_correct_word()
		)
	)

	most_wrong_word_label.text = (
		Localization.tr_ui("most_wrong_word")
		+ ": "
		+ safe_text(
			SaveManager.get_most_wrong_word()
		)
	)

	# =====================
	# MOST USED
	# =====================

	var relation_id = safe_text(
		stats.get("most_used_relation")
	)

	if relation_id == "None":

		most_used_relation_label.text = (
			Localization.tr_ui("most_used_relation")
			+ ": "
			+ Localization.tr_ui("none")
		)

	else:

		most_used_relation_label.text = (
			Localization.tr_ui("most_used_relation")
			+ ": "
			+ Localization.tr_relation(
				relation_id
			)
		)

	most_used_item_label.text = (
		Localization.tr_ui("most_used_item")
		+ ": "
		+ get_item_name(
			stats.get("most_used_item")
		)
	)

	# =====================
	# ACCURACY
	# =====================

	var accuracy = 0.0

	var total_correct = stats.get(
		"total_correct",
		0
	)

	var total_wrong = stats.get(
		"total_wrong",
		0
	)

	var total_answered = (
		total_correct
		+ total_wrong
	)

	if total_answered > 0:

		accuracy = (
			float(total_correct)
			/ total_answered
		) * 100.0

	accuracy_label.text = (
		Localization.tr_ui("accuracy")
		+ ": "
		+ str(snapped(accuracy, 0.1))
		+ "%"
	)

	# =====================
	# COLLECTION
	# =====================

	var item_discovered = (
		SaveManager.save_data["collection"]["items"].size()
	)

	var total_items = ItemDB.ITEMS.size()

	items_discovered_label.text = (
		Localization.tr_ui("items_discovered")
		+ ": "
		+ safe_number(item_discovered)
		+ "/"
		+ safe_number(total_items)
	)

	var discovered_words = 0

	for word_id in WordDB.WORDS.keys():

		var data = SaveManager.get_word_data(word_id)

		if data.get("seen", 0) > 0:

			discovered_words += 1

	words_discovered_label.text = (
		Localization.tr_ui("words_discovered")
		+ ": "
		+ safe_number(discovered_words)
		+ "/"
		+ safe_number(WordDB.WORDS.size())
	)
	
func update_language_ui():

	load_stats()

	back_button.text = Localization.tr_ui(
		"back"
	)

func safe_text(value):

	if value == null:
		return "None"

	if str(value).strip_edges() == "":
		return "None"

	return str(value)

func get_item_name(item_id):

	if item_id == null:
		return Localization.tr_ui("none")

	item_id = str(item_id)

	if item_id.strip_edges() == "":
		return Localization.tr_ui("none")

	if !ItemDB.ITEMS.has(item_id):
		return item_id

	return ItemDB.ITEMS[item_id].get(
		"name",
		item_id
	)

func safe_number(value):

	if value == null:
		return "0"

	return str(int(value))
	
func format_time(seconds):

	var hours = int(seconds / 3600)
	@warning_ignore("integer_division")
	var minutes = int((int(seconds) % 3600) / 60)
	var secs = int(int(seconds) % 60)

	return (
		str(hours).pad_zeros(2)
		+ ":"
		+ str(minutes).pad_zeros(2)
		+ ":"
		+ str(secs).pad_zeros(2)
	)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(
		"res://scenes/Screen/collection_menu.tscn"
	)
