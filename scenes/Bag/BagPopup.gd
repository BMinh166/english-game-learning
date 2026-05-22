extends Control

@onready var grid = $CenterContainer/MarginContainer/VBoxContainer/Panel/MarginContainer/ScrollContainer/BagContainer
@onready var back_button = $CenterContainer/MarginContainer/VBoxContainer/BackButton

var card_scene = preload("res://scenes/Card/Card.tscn")

signal closed

func _ready() -> void:
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

func update_language_ui():

	back_button.text = Localization.tr_ui(
		"back"
	)

func _on_back_button_pressed() -> void:
	emit_signal("closed")
	queue_free()
