extends Control

@onready var grid = $MarginContainer/Panel/MarginContainer/VBoxContainer/ScrollContainer/BagContainer

var card_scene = preload("res://scenes/Card.tscn")

func setup(cards):
	show_cards(cards)
func show_cards(cards):
	for c in grid.get_children():
		c.queue_free()

	for card_data in cards:
		var card = card_scene.instantiate()
		grid.add_child(card)
		card.setup(card_data)
		

func _on_close_button_pressed() -> void:
	queue_free()
