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
@onready var item_container = $MarginContainer/Main/Body/ItemContainer/MarginContainer/VBoxContainer

var selected_indices = []
var item_slots = {}
var max_select = 5
var current_state
var blueprint_select_mode = false
var blueprint_item = null
var floating_scene = preload("res://scenes/Card/FloatingText.tscn")
var item_scene = preload("res://scenes/Items/item.tscn")

func _ready():
	GameManager.connect("update_state_ui", update_state_ui)
	GameManager.connect("update_score_counting", update_score_couting)
	GameManager.connect("play_cards", _on_play_cards)
	GameManager.connect("clear_center_cards", _on_clear_center)
	GameManager.connect("show_floating_text", _on_show_floating_text)
	GameManager.connect("set_card_highlight", _on_set_card_highlight)
	GameManager.connect("update_item_ui", update_item_ui)
	GameManager.connect("activate_item_slot",_on_activate_item_slot)
	hand_scene.connect("card_selected", _on_card_selected)

	update_state_ui(GameManager.get_state())
	update_item_ui()

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
	
func update_item_ui():

	item_slots.clear()

	# clear cũ
	for child in item_container.get_children():
		child.queue_free()

	await get_tree().process_frame

	# lấy item player đang giữ
	var items = GameManager.item_manager.get_items()

	for item_instance in items:

		var slot = item_scene.instantiate()

		item_container.add_child(slot)

		slot.reset_size()
		slot.setup(item_instance)
		slot.connect(
			"sell_pressed",
			_on_sell_item_pressed
		)
		slot.connect(
			"use_pressed",
			_on_use_item_pressed
		)
		slot.connect(
			"item_clicked",
			_on_item_clicked
		)

		print("ITEM SIZE:", slot.size)
		print("ITEM MIN SIZE:", slot.custom_minimum_size)

		item_slots[
			item_instance.get("id", "")
		] = slot
		
func _on_item_clicked(clicked_item):

	# 👇 nhớ trạng thái cũ
	var was_selected = clicked_item.selected

	# close all
	for slot in item_container.get_children():

		if slot.has_method("close_buttons"):
			slot.close_buttons()

	# =====================
	# BLUEPRINT COPY MODE
	# =====================

	if blueprint_select_mode:

		if clicked_item.item_instance.get("id", "") == "blueprint":
			return

		var target_id = clicked_item.item_instance.get(
			"id",
			""
		)

		blueprint_item["copied_item"] = target_id

		print("BLUEPRINT COPIED:", target_id)

		update_item_ui()

		blueprint_select_mode = false
		blueprint_item = null

		return

	# 👇 nếu trước đó chưa mở thì mở lại
	if !was_selected:

		clicked_item.selected = true
		clicked_item.update_buttons()
		
func _on_use_item_pressed(item_ref):

	var item = item_ref.item_instance

	if item.get("id", "") == "blueprint":

		blueprint_select_mode = true

		blueprint_item = item

		print("SELECT ITEM TO COPY")
		
func _on_sell_item_pressed(item_ref):

	var item_instance = item_ref.item_instance

	var gain = GameManager.item_manager.sell_item(
		item_instance
	)

	GameManager.turn += gain

	print("GAIN TURN:", gain)

	update_item_ui()
	update_state_ui(GameManager.get_state())

func _on_play_cards(cards):
	var selected_cards = cards

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

		card.scale = Vector2.ONE
		card.global_position = start_pos
		
		var target = Vector2(
			start_x + i * spacing,
			center_pos.y
		) - card.size / 2
		
		var tween = create_tween()
		tween.tween_property(card, "global_position", target, 0.3)
		tween.tween_property(card, "scale", Vector2(1.2,1.2), 0.15)
		tween.tween_property(card, "scale", Vector2(1,1), 0.1)
		
		play_button.disabled = true
		discard_button.disabled = true
		
		await get_tree().create_timer(0.08).timeout
		
func _on_show_floating_text(card, data):
	if !is_instance_valid(card):
		return
	# 🔥 highlight card đang được tính
	
	print("FT_---- SPAWN ----")
	print("FT_CARD SIZE:", card.size)
	print("FT_TEXT:", data.text)
	var ft = floating_scene.instantiate()
	card.add_child(ft)

	# 🎨 màu
	var color = Color.YELLOW
	match data.type:
		"add_point":
			color = Color.GREEN

		"add_mult", "mul_mult":
			color = Color.CYAN

		"fail":
			color = Color.RED
			
		"chain":
			color = Color.ORANGE
			
		"item":
			color = Color.GOLD

	print("FT_TEXT SIZE BEFORE PLAY:", ft.size)

	# 👇 đặt center (KHÔNG trừ size ở đây nữa)
	ft.position = Vector2(
		card.size.x / 2,
		card.size.y + 10
	)
	
	print("FT_POS BEFORE PLAY:", ft.position)

	await ft.play(data.text, color)
	#await get_tree().create_timer(0.6).timeout
		
func _on_set_card_highlight(card, state, type):
	if !is_instance_valid(card):
		return

	if type == "fail":
		if card.has_method("set_fail"):
			card.set_fail(state)
	else:
		if card.has_method("set_selected"):
			card.set_selected(state)
		
func _on_clear_center():
	for child in center_area.get_children():
		child.get_parent().remove_child(child)
		hand_scene.container.add_child(child)  # trả về hand



func _on_play_button_pressed() -> void:
	if selected_indices.is_empty():
		return
	
	var selected_cards = []

	for i in selected_indices:
		selected_cards.append(hand_scene.cards[i])

	GameManager.play_selected(selected_cards)
	selected_indices.clear()
	update_hand_selection()


func _on_discard_button_pressed() -> void:
	if selected_indices.is_empty():
		return
	
	GameManager.discard_selected(selected_indices)
	selected_indices.clear()
	update_hand_selection()
	
func _on_activate_item_slot(item_id):

	if !item_slots.has(item_id):
		return

	var slot = item_slots[item_id]

	if slot.has_method("activate"):
		slot.activate()
	
func format_number(n):

	if n >= 1e12:
		return "%.2e" % n

	if n >= 1e9:
		return str(snapped(n / 1e9, 0.01)) + "B"

	return str(n)
	
func _input(event):

	if event.is_action_pressed("ui_accept"):
		GameManager.debug_add_item("over_heaven")

	if event.is_action_pressed("ui_cancel"):
		GameManager.debug_add_item("infinite_paradox")
