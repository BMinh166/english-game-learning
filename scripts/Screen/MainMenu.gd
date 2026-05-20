extends Control


func _on_play_button_pressed() -> void:
	GameManager.reset_state()

	get_tree().change_scene_to_file(
		"res://scenes/Main.tscn"
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
