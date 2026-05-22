extends Control

@onready var play_button = $MainMenu/CenterContainer/VBoxContainer/MarginContainer/ButtonContainer/PlayButton
@onready var setting_button = $MainMenu/CenterContainer/VBoxContainer/MarginContainer/ButtonContainer/SettingButton
@onready var collection_button = $MainMenu/CenterContainer/VBoxContainer/MarginContainer/ButtonContainer/CollectionButton
@onready var quit_button = $MainMenu/CenterContainer/VBoxContainer/MarginContainer/ButtonContainer/QuitButton

func _ready():
	update_language_ui()
	
	
func update_language_ui():

	play_button.text = Localization.tr_ui(
		"play"
	)

	setting_button.text = Localization.tr_ui(
		"settings"
	)

	collection_button.text = Localization.tr_ui(
		"collection"
	)

	quit_button.text = Localization.tr_ui(
		"quit"
	)
	
	

func _on_play_button_pressed() -> void:

	var has_run = SaveManager.save_data[
		"current_run"
	]["active"]

	# =====================
	# CONTINUE AVAILABLE
	# =====================

	if has_run:

		get_tree().change_scene_to_file(
			"res://scenes/Screen/play_game_menu.tscn"
		)

		return

	# =====================
	# NO RUN
	# =====================

	get_tree().change_scene_to_file(
		"res://scenes/Screen/new_game_menu.tscn"
	)

func _on_setting_button_pressed() -> void:
	GameManager.previous_scene_path = (
		"res://scenes/Screen/main_menu.tscn"
	)

	get_tree().change_scene_to_file(
		"res://scenes/Screen/setting.tscn"
	)
	
	print("PREVIOUS:", GameManager.previous_scene_path)

func _on_quit_button_pressed() -> void:
		get_tree().quit()


func _on_collection_button_pressed() -> void:
	get_tree().change_scene_to_file(
		"res://scenes/Screen/collection_menu.tscn"
	)
