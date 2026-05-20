extends Control

signal selected(item_data)

var item_data
@onready var item = $Item
@onready var button = $Button

signal hover_started(item_ref)
signal hover_ended

func _ready():

	button.mouse_entered.connect(
		_on_button_mouse_entered
	)

	button.mouse_exited.connect(
		_on_button_mouse_exited
	)

	print("REWARD SLOT READY")

func setup(data):

	item_data = data
	item.setup(data)
	item.can_click = false

	item.click_area.mouse_filter = Control.MOUSE_FILTER_IGNORE
	item.sell_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	item.use_button.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_button_pressed():
	selected.emit(item_data)


func _on_button_mouse_entered() -> void:
	print("========")
	print("BUTTON HOVER ENTER")
	print("ITEM:", item_data)
	print("========")
	
	print("EMIT HOVER SIGNAL")

	emit_signal(
		"hover_started",
		item
	)


func _on_button_mouse_exited() -> void:
	print("REWARD HOVER EXIT")

	emit_signal("hover_ended")
