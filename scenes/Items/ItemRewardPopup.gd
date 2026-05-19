extends Control

signal reward_selected(item_data)
signal reward_skipped
signal reward_rerolled

@onready var slots = $HBoxContainer/CenterContainer/RewardBG/PopupContainer/MarginContainer/RewardContainer.get_children()
@onready var reroll_button = $HBoxContainer/CenterContainer/RewardBG/PopupContainer/ButtonContainer/Reroll

var current_rewards = []

func setup(
	items,
	reroll_left := 0,
):
	
	current_rewards = items

	reroll_button.text = "Reroll (" + str(reroll_left) + ")"

	reroll_button.disabled = reroll_left <= 0

	for i in range(slots.size()):
		var slot = slots[i]

		if i < items.size():
			slot.visible = true
			slot.setup(items[i])
			if !slot.selected.is_connected(_on_slot_selected):
				slot.selected.connect(_on_slot_selected)
		else:
			slot.visible = false

func _on_slot_selected(item_data):

	if GameManager.item_manager.get_items().size() >= 5:

		print("ITEM INVENTORY FULL")

		return

	reward_selected.emit(item_data)

	queue_free()


func _on_reroll_pressed() -> void:

	reward_rerolled.emit()

func _on_skip_pressed() -> void:
	reward_skipped.emit()

	queue_free()
