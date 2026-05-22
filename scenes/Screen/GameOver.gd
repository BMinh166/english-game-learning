extends Control

@onready var game_over_label = $GameOver/CenterContainer/MarginContainer/MenuContainer/GameOverLabel
@onready var score_label = $GameOver/CenterContainer/MarginContainer/MenuContainer/ButtonContainer/ScoreLabel
@onready var round_label = $GameOver/CenterContainer/MarginContainer/MenuContainer/ButtonContainer/RoundLabel
@onready var new_game_button = $GameOver/CenterContainer/MarginContainer/MenuContainer/ButtonContainer/NewGameButton
@onready var main_menu_button = $GameOver/CenterContainer/MarginContainer/MenuContainer/ButtonContainer/MainMenuButton

var is_victory := false
var final_score := 0
var final_round := 0

func _ready():

	update_language_ui()

func setup(
	victory: bool,
	score_value: int,
	round_value: int
):

	is_victory = victory

	final_score = score_value
	final_round = round_value
	
func update_language_ui():

	if is_victory:

		game_over_label.text = Localization.tr_ui(
			"victory"
		)

	else:

		game_over_label.text = Localization.tr_ui(
			"game_over"
		)

	score_label.text = (
		Localization.tr_ui("score")
		+ ": "
		+ str(final_score)
	)

	round_label.text = (
		Localization.tr_ui("round")
		+ ": "
		+ str(final_round)
	)

	new_game_button.text = Localization.tr_ui(
		"new_game"
	)

	main_menu_button.text = Localization.tr_ui(
		"main_menu"
	)

func _on_new_game_button_pressed() -> void:

	get_tree().change_scene_to_file(
		"res://scenes/Screen/new_game_menu.tscn"
	)


func _on_main_menu_button_pressed() -> void:
		get_tree().change_scene_to_file(
		"res://scenes/Screen/main_menu.tscn"
	)
