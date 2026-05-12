extends Control

@onready var label = $MarginContainer/ColorRect/Label

var item_data

func setup(data):
	item_data = data

	label.text = data.name
	
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
