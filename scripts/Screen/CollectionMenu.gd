extends Control

@onready var word_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/WordButton

@onready var items_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/ItemsButton

@onready var back_button = $CenterContainer/MarginContainer/MenuContainer/BackButton


func _ready():
	await get_tree().process_frame

	word_button.pressed.connect(
		_on_word_button_pressed
	)

	items_button.pressed.connect(
		_on_items_button_pressed
	)

	back_button.pressed.connect(
		_on_back_button_pressed
	)


	update_progress()


func update_progress():

	var total_words = WordDB.WORDS.size()

	var discovered_words = 0

	for word_id in WordDB.WORDS.keys():

		var data = SaveManager.get_word_data(word_id)

		if data["seen"] > 0:
			discovered_words += 1

	word_button.text = (
		"WORDS ("
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
		"ITEMS ("
		+ str(discovered_items)
		+ "/"
		+ str(total_items)
		+ ")"
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
