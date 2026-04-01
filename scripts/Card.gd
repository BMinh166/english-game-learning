extends Control

@onready var label = $Panel/MarginContainer/VBoxContainer/Label

var data

func setup(card_data):
	data = card_data
	label.text = card_data.text
