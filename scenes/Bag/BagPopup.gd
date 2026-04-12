extends Control

@onready var grid = $MarginContainer/Panel/MarginContainer/VBoxContainer/ScrollContainer/BagContainer

var card_scene = preload("res://scenes/Card/Card.tscn")

signal closed

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
		

func _on_close_button_pressed() -> void:
	emit_signal("closed")
	queue_free()
