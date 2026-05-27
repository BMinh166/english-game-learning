extends Control

@onready var search_bar = $CenterContainer/MarginContainer/VBoxContainer/SearchBar

@onready var word_container = $CenterContainer/MarginContainer/VBoxContainer/Panel/MarginContainer/ScrollContainer/WordContainer

@onready var back_button = $CenterContainer/MarginContainer/VBoxContainer/BackButton

var popup_scene = preload(
	"res://scenes/Screen/word_detail_popup.tscn"
)


func _ready():
	
	search_bar.text_changed.connect(
		_on_search_text_changed
	)
	
	update_language_ui()
	load_words()


func load_words():

	for child in word_container.get_children():
		child.queue_free()

	var discovered_words = []
	var undiscovered_words = []

	for word_id in WordDB.WORDS.keys():

		var data = SaveManager.get_word_data(word_id)

		var discovered = data.get("seen", 0) > 0

		if discovered:
			discovered_words.append(word_id)
		else:
			undiscovered_words.append(word_id)

	discovered_words.sort()
	undiscovered_words.sort()

	var word_ids = discovered_words + undiscovered_words

	for word_id in word_ids:

		var button = Button.new()

		button.custom_minimum_size = Vector2(0, 40)

		button.focus_mode = Control.FOCUS_NONE
		#button.flat = true

		var data = SaveManager.get_word_data(word_id)

		var discovered = data.get("seen", 0) > 0

		if discovered:
			button.text = word_id
		else:
			button.text = "???"

		var current_word_id = word_id
		var current_discovered = discovered

		button.pressed.connect(
			func():
				AudioManager.play_button_click()
				if current_discovered:
					open_word_detail(current_word_id)
		)

		word_container.add_child(button)


func open_word_detail(word_id):

	var popup = popup_scene.instantiate()

	add_child(popup)

	popup.setup(word_id)


func update_language_ui():

	back_button.text = Localization.tr_ui(
		"back"
	)
	

func _on_search_text_changed(text):

	text = text.to_lower()

	for child in word_container.get_children():

		if child.text == "???":
			child.visible = text == ""
			continue

		child.visible = (
			text == ""
			or child.text.to_lower().contains(text)
		)


func _on_back_button_pressed() -> void:
	AudioManager.play_button_click()
	get_tree().change_scene_to_file(
		"res://scenes/Screen/collection_menu.tscn"
	)
