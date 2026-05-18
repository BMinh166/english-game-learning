extends Control

signal reward_selected(item_data)

@onready var slots = $HBoxContainer/CenterContainer/MarginContainer/RewardContainer.get_children()

func setup(items):

	for i in range(slots.size()):
		var slot = slots[i]

		if i < items.size():
			slot.visible = true
			slot.setup(items[i])
			slot.selected.connect(_on_slot_selected)
		else:
			slot.visible = false

func _on_slot_selected(item_data):

	reward_selected.emit(item_data)
	queue_free()
