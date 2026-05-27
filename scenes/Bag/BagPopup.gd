extends Control

@onready var grid = $CenterContainer/MarginContainer/VBoxContainer/Panel/MarginContainer/ScrollContainer/BagContainer
@onready var back_button = $CenterContainer/MarginContainer/VBoxContainer/BackButton
@onready var blocker = $CenterContainer/MarginContainer/VBoxContainer/Panel/MarginContainer/ScrollContainer/Blocker

var card_scene = preload("res://scenes/Card/Card.tscn")

signal closed

func _ready() -> void:
	add_to_group("bag_popup")
	update_language_ui()

func setup(cards):
	show_cards(cards)
func show_cards(cards):
	for c in grid.get_children():
		c.queue_free()

	for i in range(cards.size()):
		var card_data = cards[i]
		
		var card = card_scene.instantiate()
		grid.add_child(card)
		
		card.setup(card_data, i)  # ✅ đúng
		
	# 👇 chờ layout update
	await get_tree().process_frame

	# 👇 update blocker
	blocker.custom_minimum_size.y = grid.size.y
	
func update_language_ui():

	back_button.text = Localization.tr_ui(
		"back"
	)
	
func close_popup():
	emit_signal("closed")
	queue_free()

func _on_back_button_pressed() -> void:
	AudioManager.play_button_click()
	emit_signal("closed")
	queue_free()
