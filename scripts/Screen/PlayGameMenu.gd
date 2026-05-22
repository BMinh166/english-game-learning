extends Control

@onready var newgame_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/MarginContainer/ButtonContainer/NewGameButton
@onready var continue_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/MarginContainer/ButtonContainer/ContinueButton
@onready var back_button = $CenterContainer/MarginContainer/MenuContainer/BackButton


func _ready() -> void:

	update_language_ui()

	var has_run = SaveManager.save_data[
		"current_run"
	]["active"]

	continue_button.visible = has_run


func update_language_ui():

	newgame_button.text = Localization.tr_ui(
		"new_game"
	)

	continue_button.text = Localization.tr_ui(
		"continue"
	)

	back_button.text = Localization.tr_ui(
		"back"
	)


func _on_new_game_button_pressed() -> void:

	get_tree().change_scene_to_file(
		"res://scenes/Screen/new_game_menu.tscn"
	)


func _on_continue_button_pressed() -> void:

	get_tree().change_scene_to_file(
		"res://scenes/Main.tscn"
	)


func _on_back_button_pressed() -> void:

	get_tree().change_scene_to_file(
		"res://scenes/Screen/main_menu.tscn"
	)
