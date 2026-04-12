extends Control

@onready var label = $Panel/MarginContainer/VBoxContainer/Label

signal card_clicked(index)

var data
var index = -1

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP  # 🔥 đảm bảo nhận input

func setup(word, i):
	data = word
	index = i
	label.text = word.text
	
	print("SETUP CARD: ", index," ", label.text)  # debug

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("CLICK CARD:", index, label.text)  # 🔥 debug
			emit_signal("card_clicked", index)

func set_selected(is_selected):
	if is_selected:
		modulate = Color(0.7, 1, 0.7)
	else:
		modulate = Color.WHITE
