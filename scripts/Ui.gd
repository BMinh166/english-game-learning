extends Control

@onready var word_label = $UI/MarginContainer/Main/Body/CenterArea/CenterContainer/WordLabel
@onready var score_counting = $UI/MarginContainer/Main/Body/CenterArea/ScoreCounting
@onready var turn_label = $UI/MarginContainer/Main/Body/RightContainer/RoundContainer/TurnLabel
@onready var round_label = $UI/MarginContainer/Main/Body/RightContainer/RoundContainer/RoundLabel
@onready var discard_left = $UI/MarginContainer/Main/Body/RightContainer/PlayButtonContainer/DiscardLeft

func update_state_ui(state):
	word_label.text = state.current_word.text
	turn_label.text = str(state.turn)
	round_label.text = str(state.round)
	discard_left.text = str(state.discard_left)
	
func update_score_couting_pm(point, mult):
	score_counting.set_pm_value(point, mult)
	
func update_score_couting(score):
	score_counting.set_score(score)
