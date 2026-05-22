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


func _ready() -> void:

	update_language_ui()


func update_language_ui():

	difficulty_button.text = (
		Localization.tr_ui("difficulty")
		+ ": "
		+ difficulties[current_index].capitalize()
	)

	play_button.text = Localization.tr_ui(
		"play"
	)

	back_button.text = Localization.tr_ui(
		"back"
	)

	description_label.text = Localization.tr_ui(
		difficulties[current_index]
		+ "_desc"
	)


func _on_difficulty_button_pressed() -> void:

	current_index += 1

	if current_index >= difficulties.size():
		current_index = 0

	update_language_ui()


func _on_play_button_pressed() -> void:

	# clear old run
	SaveManager.clear_current_run()

	GameManager.reset_state()

	# nếu muốn sau này:
	# GameManager.difficulty = difficulties[current_index]

	get_tree().change_scene_to_file(
		"res://scenes/Main.tscn"
	)


func _on_back_button_pressed() -> void:

	get_tree().change_scene_to_file(
		"res://scenes/Screen/main_menu.tscn"
	)
