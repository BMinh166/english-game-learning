extends Control

@onready var word_label = $MarginContainer/Main/Body/CenterArea/CenterContainer/WordLabel
@onready var score_counting = $MarginContainer/Main/Body/CenterArea/ScoreCounting
@onready var score_bar = $MarginContainer/Main/ScoreBar
@onready var turn_label = $MarginContainer/Main/Body/RightContainer/RoundContainer/TurnLabel
@onready var round_label = $MarginContainer/Main/Body/RightContainer/RoundContainer/RoundLabel
@onready var discard_left = $MarginContainer/Main/Body/RightContainer/PlayButtonContainer/DiscardLeft
@onready var hand_scene = $MarginContainer/Main/Body/CenterArea/CardContainer
@onready var play_button = $MarginContainer/Main/Body/RightContainer/PlayButtonContainer/PlayButton
@onready var discard_button = $MarginContainer/Main/Body/RightContainer/PlayButtonContainer/DiscardButton

var selected_indices = []
var max_select = 5
var current_state

func _ready():
	GameManager.connect("update_state_ui", update_state_ui)
	hand_scene.connect("card_selected", _on_card_selected)

	# 🔥 THÊM DÒNG NÀY
	update_state_ui(GameManager.get_state())

func update_state_ui(state):
	current_state = state
	word_label.text = state.current_word.text
	turn_label.text = "Turn: " + str(state["turn"])
	round_label.text = "Round: " + str(state["round"])
	discard_left.text = "Discard left: " + str(state["discard_left"])
	score_counting.set_score(state["result_score"])
	score_counting.set_pm_value(state["point"], state["mult"])
	score_bar.set_progress_bar(state["score"], state["target_score"])
	var hand = GameManager.hand
	hand_scene.setup(hand)
	selected_indices.clear()
	update_hand_selection()
	update_buttons()
	print("Update UI")
	
func update_score_couting_pm(state):
	score_counting.set_pm_value(state["point"], state["mult"])
	
func update_score_couting(state):
	score_counting.set_score(state["result_score"])
	
func update_buttons():
	play_button.disabled = selected_indices.is_empty()
	discard_button.disabled = selected_indices.is_empty() or current_state["discard_left"] <= 0
	
func _on_card_selected(index):
	if index in selected_indices:
		selected_indices.erase(index)
	else:
		if selected_indices.size() < max_select:
			selected_indices.append(index)
	
	update_hand_selection()
	
func update_hand_selection():
	for card in hand_scene.cards:
		card.set_selected(card.index in selected_indices)
	print("CARDS: ", hand_scene.cards.size())
	update_buttons()


func _on_play_button_pressed() -> void:
	if selected_indices.is_empty():
		return
	
	GameManager.play_selected(selected_indices)
	selected_indices.clear()
	update_hand_selection()


func _on_discard_button_pressed() -> void:
	if selected_indices.is_empty():
		return
	
	GameManager.discard_selected(selected_indices)
	selected_indices.clear()
	update_hand_selection()
