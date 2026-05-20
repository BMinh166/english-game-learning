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
	load_stats()


func load_stats():

	var stats = SaveManager.get_statistics()

	highest_score_label.text = (
		"Highest Score: "
		+ safe_number(stats.get("highest_score"))
	)

	highest_round_label.text = (
		"Highest Round: "
		+ safe_number(stats.get("highest_round"))
	)

	highest_chain_label.text = (
		"Highest Chain: "
		+ safe_number(stats.get("highest_chain"))
	)

	total_runs_label.text = (
		"Total Runs: "
		+ safe_number(stats.get("total_runs"))
	)

	play_time_label.text = (
		"Play Time: "
		+ safe_number(stats.get("total_play_time"))
	)

	total_words_played_label.text = (
		"Words Played: "
		+ safe_number(stats.get("total_words_played"))
	)

	total_correct_label.text = (
		"Correct: "
		+ safe_number(stats.get("total_correct"))
	)

	total_wrong_label.text = (
		"Wrong: "
		+ safe_number(stats.get("total_wrong"))
	)

	# =====================
	# ACCURACY
	# =====================

	var accuracy = 0.0

	var total_correct = stats.get("total_correct", 0)
	var total_wrong = stats.get("total_wrong", 0)

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
		"Accuracy: "
		+ str(snapped(accuracy, 0.1))
		+ "%"
	)

	# =====================
	# COLLECTION
	# =====================

	var item_discovered = SaveManager.save_data["collection"]["items"].size()

	var total_items = ItemDB.ITEMS.size()

	items_discovered_label.text = (
		"Items: "
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
		"Words: "
		+ safe_number(discovered_words)
		+ "/"
		+ safe_number(WordDB.WORDS.size())
	)

func safe_text(value):

	if value == null:
		return "None"

	if str(value).strip_edges() == "":
		return "None"

	return str(value)


func safe_number(value):

	if value == null:
		return "0"

	return str(int(value))

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(
		"res://scenes/Screen/collection_menu.tscn"
	)
