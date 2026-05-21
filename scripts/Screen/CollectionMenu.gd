extends Control

@onready var word_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/WordButton
@onready var items_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/ItemsButton
@onready var relation_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/RelationsButton
@onready var stats_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/StatsButton
@onready var delete_data = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/DeleteDataButton

@onready var back_button = $CenterContainer/MarginContainer/MenuContainer/BackButton

var notify_scene = preload(
	"res://scenes/Screen/notify_popup.tscn"
)
var relation_scene = preload(
	"res://scenes/Screen/relation_info_menu.tscn"
)


func _ready():
	#await get_tree().process_frame

	word_button.pressed.connect(
		_on_word_button_pressed
	)

	items_button.pressed.connect(
		_on_items_button_pressed
	)

	back_button.pressed.connect(
		_on_back_button_pressed
	)

	update_language_ui()
	update_progress()


func update_progress():

	var total_words = WordDB.WORDS.size()

	var discovered_words = 0

	for word_id in WordDB.WORDS.keys():

		var data = SaveManager.get_word_data(word_id)

		if data["seen"] > 0:
			discovered_words += 1

	word_button.text = (
		Localization.tr_ui("words")
		+ " ("
		+ str(discovered_words)
		+ "/"
		+ str(total_words)
		+ ")"
	)

	var total_items = ItemDB.ITEMS.size()

	var discovered_items = 0

	for item_id in ItemDB.ITEMS.keys():

		if SaveManager.save_data["collection"]["items"].has(item_id):
			discovered_items += 1

	items_button.text = (
		Localization.tr_ui("items")
		+ " ("
		+ str(discovered_items)
		+ "/"
		+ str(total_items)
		+ ")"
	)

func update_language_ui():

	stats_button.text = Localization.tr_ui(
		"stats"
	)

	delete_data.text = Localization.tr_ui(
		"delete_data"
	)

	relation_button.text = Localization.tr_ui(
		"relations"
	)

	back_button.text = Localization.tr_ui(
		"back"
	)


func _on_word_button_pressed():

	get_tree().change_scene_to_file(
		"res://scenes/Screen/word_tab.tscn"
	)


func _on_items_button_pressed():

	get_tree().change_scene_to_file(
		"res://scenes/Screen/item_tab.tscn"
	)


func _on_back_button_pressed():

	get_tree().change_scene_to_file(
		"res://scenes/Screen/main_menu.tscn"
	)


func _on_stats_button_pressed() -> void:
	get_tree().change_scene_to_file(
		"res://scenes/Screen/stats_menu.tscn"
	)


func _on_delete_data_button_pressed() -> void:

	var popup = notify_scene.instantiate()

	add_child(popup)

	popup.confirmed.connect(
		func():

			SaveManager.reset_save()

			GameManager.reset_state()

			get_tree().change_scene_to_file(
				"res://scenes/Screen/main_menu.tscn"
			)
	)

	popup.cancelled.connect(
		func():
			print("DELETE CANCELLED")
	)


func _on_relations_button_pressed() -> void:

	var popup = relation_scene.instantiate()

	add_child(popup)
