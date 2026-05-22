extends Control

@onready var yes_button = $CenterContainer/MarginContainer/MenuContainer/ButtonContainer/YesButton
@onready var cancel_button = $CenterContainer/MarginContainer/MenuContainer/ButtonContainer/CancelButton

@onready var notify_label = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/MarginContainer/NotifyLabel

signal confirmed
signal cancelled

func _ready() -> void:

	yes_button.pressed.connect(
		_on_yes_pressed
	)

	cancel_button.pressed.connect(
		_on_cancel_pressed
	)

	notify_label.text = Localization.tr_ui(
		"delete_confirm"
	)

	yes_button.text = Localization.tr_ui(
		"yes"
	)

	cancel_button.text = Localization.tr_ui(
		"cancel"
	)


func _on_yes_pressed():

	emit_signal("confirmed")

	queue_free()


func _on_cancel_pressed():

	emit_signal("cancelled")

	queue_free()
