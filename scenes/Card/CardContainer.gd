extends Control

signal card_selected(index)

var cards = []

@onready var container = $MarginContainer/HBoxContainer

func _ready():
	cards = container.get_children()  # hoặc get_children()

func setup(hand_data):
	for i in range(cards.size()):
		var card = cards[i]
		
		if i < hand_data.size():
			card.visible = true
			card.setup(hand_data[i], i)
			
			if not card.card_clicked.is_connected(_on_card_clicked):
				card.card_clicked.connect(_on_card_clicked)
		else:
			card.visible = false

func _on_card_clicked(index):
	emit_signal("card_selected", index)
