extends Control

signal selected(item_data)

var item_data
@onready var item = $Item
@onready var button = $Button


func setup(data):

	item_data = data
	item.setup(data)
	item.can_click = false

	item.click_area.mouse_filter = Control.MOUSE_FILTER_IGNORE
	item.sell_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	item.use_button.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_button_pressed():
	selected.emit(item_data)
