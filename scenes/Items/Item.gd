extends Control

@onready var label = $MarginContainer/ColorRect/Label
@onready var sell_button = $SellButton
@onready var use_button = $UseButton
@onready var click_area = $ClickArea

var item_instance
var selected = false

signal sell_pressed(item_ref)
signal use_pressed(item_ref)
signal item_clicked(item_ref)

func _ready() -> void:
	sell_button.visible = false
	use_button.visible = false
	mouse_filter = Control.MOUSE_FILTER_STOP
	click_area.focus_mode = Control.FOCUS_NONE

func setup(instance):

	item_instance = instance

	var data = ItemDB.ITEMS[instance.id]

	label.text = data.name
	if item_instance.get("id", "") == "blueprint":

		var copied = item_instance.get(
			"copied_item",
			""
		)

		if copied != "":

			label.text += "\n[" + copied + "]"
	
			
func update_buttons():

	sell_button.visible = selected

	use_button.visible = (
		selected
		and has_use_action()
	)

	modulate = (
		Color(1.1, 1.1, 1.1)
		if selected
		else Color.WHITE
	)
	
func has_use_action() -> bool:

	match item_instance.id:

		"blueprint":
			return true

	return false
	
func activate():

	scale = Vector2.ONE

	var tween = create_tween()

	modulate = Color(1.3, 1.3, 0.7)

	tween.tween_property(
		self,
		"scale",
		Vector2(1.1,1.1),
		0.1
	)

	tween.tween_property(
		self,
		"scale",
		Vector2.ONE,
		0.1
	)

	await tween.finished

	modulate = Color.WHITE
	
func close_buttons():

	selected = false
	update_buttons()


func _on_sell_button_pressed() -> void:
	emit_signal("sell_pressed", self)


func _on_use_button_pressed() -> void:
	emit_signal("use_pressed", self)


func _on_click_area_pressed() -> void:
	emit_signal("item_clicked", self)
