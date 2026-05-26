extends Control

@onready var label = $Panel/MarginContainer/VBoxContainer/Label

signal card_clicked(index)

var data
var index = -1

var hovered := false
var selected := false
var failed := false
var locked := false

var base_position := Vector2.ZERO
var visual_base_y := 0.0
var move_tween: Tween

const HOVER_OFFSET := -5
const SELECT_OFFSET := -22

func _ready():

	mouse_filter = Control.MOUSE_FILTER_STOP

	await get_tree().process_frame

	pivot_offset = size / 2

	base_position = position

	mouse_entered.connect(_on_hover_enter)
	mouse_exited.connect(_on_hover_exit)

func setup(word, i):

	data = word
	index = i

	label.text = word.text

func _gui_input(event):

	if event is InputEventMouseButton and event.pressed:

		if event.button_index == MOUSE_BUTTON_LEFT:

			print("CLICK CARD:", index, label.text)

			emit_signal("card_clicked", index)

func _on_hover_enter():

	if locked:
		return

	hovered = true

	update_visual()

func _on_hover_exit():

	if locked:
		return

	hovered = false

	update_visual()

func set_selected(is_selected):

	selected = is_selected

	update_visual()

func set_fail(is_fail):

	failed = is_fail

	update_visual()

func update_visual():

	# =====================
	# COLOR
	# =====================

	if failed:
		modulate = Color(1, 0.5, 0.5)
	else:
		modulate = Color.WHITE

	# lock only movement
	if locked:
		return

	var target_y = 0.0

	if selected:
		target_y = SELECT_OFFSET

	elif hovered:
		target_y = HOVER_OFFSET

	if move_tween:
		move_tween.kill()

	move_tween = create_tween()

	move_tween.set_trans(Tween.TRANS_CUBIC)
	move_tween.set_ease(Tween.EASE_OUT)

	move_tween.tween_property(
		self,
		"position:y",
		visual_base_y + target_y,
		0.10
	)
