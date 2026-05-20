extends Control

@onready var score_label = $GameOver/CenterContainer/MenuContainer/ButtonContainer/ScoreLabel
@onready var round_label = $GameOver/CenterContainer/MenuContainer/ButtonContainer/RoundLabel

func _ready():
	pass
	#var data = SaveManager.save_data["last_run"]
#
	#score_label.text = (
		#"Score: " + str(data["score"])
	#)
#
	#round_label.text = (
		#"Round: " + str(data["round"])
	#)

func _on_new_game_button_pressed() -> void:
		get_tree().change_scene_to_file(
		"res://scenes/Main.tscn"
	)


func _on_main_menu_button_pressed() -> void:
		get_tree().change_scene_to_file(
		"res://scenes/Screen/main_menu.tscn"
	)
