extends Control

@onready var difficulty_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/VBoxContainer/DifficultyButton
@onready var play_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/VBoxContainer/PlayButton
@onready var back_button = $CenterContainer/MarginContainer/MenuContainer/BackButton
@onready var description_label = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/VBoxContainer/MarginContainer/MarginContainer/DescriptionLabel

var difficulties = [
	"easy",
	"normal",
	"hard"
]

var current_index := 1

var pause_menu = null


func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	update_language_ui()


func update_language_ui():

	difficulty_button.text = (
		Localization.tr_ui("difficulty")
		+ ": "
		+ Localization.tr_ui(
			difficulties[current_index]
		)
	)

	play_button.text = Localization.tr_ui(
		"play"
	)

	back_button.text = Localization.tr_ui(
		"back"
	)

	var diff = difficulties[current_index]

	var completed = DifficultyManager.is_completed(
		diff
	)

	var status_text = ""

	if completed:

		status_text = Localization.tr_ui(
			"completed"
		)

	else:

		status_text = Localization.tr_ui(
			"not_completed"
		)

	description_label.text = (
		Localization.tr_ui(diff + "_desc")
		+ "\n\n"
		+ status_text
	)


func _on_difficulty_button_pressed() -> void:
	AudioManager.play_button_click()

	current_index += 1

	if current_index >= difficulties.size():
		current_index = 0

	update_language_ui()


func _on_play_button_pressed() -> void:
	AudioManager.play_button_click()
	
	if get_tree().paused:
		get_tree().paused = false

	# clear old run
	SaveManager.clear_current_run()

	GameManager.reset_state()

	# nếu muốn sau này:
	DifficultyManager.current_difficulty =	difficulties[current_index]

	get_tree().change_scene_to_file(
		"res://scenes/Main.tscn"
	)


func _on_back_button_pressed() -> void:
	AudioManager.play_button_click()

	if pause_menu != null:

		pause_menu.show()
		queue_free()
		
	else:
		get_tree().change_scene_to_file( "res://scenes/Screen/main_menu.tscn" )

	
