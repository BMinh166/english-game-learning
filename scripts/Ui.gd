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
@onready var center_area = $MarginContainer/Main/Body/CenterArea/CenterPlayArea

var selected_indices = []
var max_select = 5
var current_state

func _ready():
	GameManager.connect("update_state_ui", update_state_ui)
	GameManager.connect("update_score_counting", update_score_couting)
	GameManager.connect("play_cards", _on_play_cards)
	GameManager.connect("clear_center_cards", _on_clear_center)
	hand_scene.connect("card_selected", _on_card_selected)

	update_state_ui(GameManager.get_state())

func update_state_ui(state):
	current_state = state
	word_label.text = state.current_word.text
	turn_label.text = "Turn: " + str(state["turn"])
	round_label.text = "Round: " + str(state["round"])
	discard_left.text = "Discard left: " + str(state["discard_left"])
	update_score_couting(state)
	score_bar.set_progress_bar(state["score"], state["target_score"])
	var hand = GameManager.hand
	hand_scene.setup(hand)
	selected_indices.clear()
	update_hand_selection()
	update_buttons()
	print("Update UI")
	
func update_score_couting(state):
	score_counting.set_score(state["result_score"], state["point"], state["mult"])
	print("UPDATE SCORE")
	
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
		if !is_instance_valid(card):
			continue
			
		card.set_selected(card.index in selected_indices)

	update_buttons()

func _on_play_cards(indices):
	var cards = hand_scene.cards
	
	var selected_cards = []

	for i in indices:
		if i >= 0 and i < cards.size():
			selected_cards.append(cards[i])

	var count = selected_cards.size()
	if count == 0:
		return

	var center_pos = get_viewport_rect().size / 2
	var spacing = 160.0

	var total_width = (count - 1) * spacing
	var start_x = center_pos.x - total_width / 2

	for i in range(count):
		var card = selected_cards[i]
		
		var start_pos = card.global_position
		
		card.get_parent().remove_child(card)
		center_area.add_child(card)

		# ✅ reset scale trước
		card.scale = Vector2.ONE
		
		card.global_position = start_pos
		
		var target = Vector2(
			start_x + i * spacing,
			center_pos.y
		) - card.size / 2
		
		var tween = create_tween()
		tween.tween_property(card, "global_position", target, 0.3)
		tween.tween_property(card, "scale", Vector2(1.2,1.2), 0.15)
		tween.tween_property(card, "scale", Vector2(1,1), 0.1) # 👈 bounce về lại
		
		play_button.disabled = true
		discard_button.disabled = true
		
		#DEBUG
		#var debug_dot = ColorRect.new()
		#debug_dot.color = Color.RED
		#debug_dot.size = Vector2(10,10)
		#debug_dot.global_position = center_pos
		#add_child(debug_dot)
		#card.modulate = Color(1,0.5,0.5)
		#print("CENTER:", center_area.global_position)
		#print("SIZE:", center_area.size)
		#print("CARD POS:", card.global_position)
		#print("CARD SIZE:", card.size)
		#print("PIVOT:", card.pivot_offset)
		
		await get_tree().create_timer(0.08).timeout
		
func _on_clear_center():
	for child in center_area.get_children():
		child.get_parent().remove_child(child)
		hand_scene.container.add_child(child)  # trả về hand



func _on_play_button_pressed() -> void:
	if selected_indices.is_empty():
		return
	
	GameManager.play_selected(selected_indices.duplicate())
	selected_indices.clear()
	update_hand_selection()


func _on_discard_button_pressed() -> void:
	if selected_indices.is_empty():
		return
	
	GameManager.discard_selected(selected_indices)
	selected_indices.clear()
	update_hand_selection()
