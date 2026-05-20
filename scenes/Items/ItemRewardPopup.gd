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
			
			print("SETUP REWARD SLOT:", i)
			print("SLOT NODE:", slot)
			
			slot.setup(items[i])
			
			if !slot.hover_started.is_connected(
				_on_reward_hover_started
			):
				slot.hover_started.connect(
					_on_reward_hover_started
				)

			if !slot.hover_ended.is_connected(
				_on_reward_hover_ended
			):
				slot.hover_ended.connect(
					_on_reward_hover_ended
				)
				
			print(
				slot.hover_started.is_connected(
					_on_reward_hover_started
				)
			)
				
			if !slot.selected.is_connected(_on_slot_selected):
				slot.selected.connect(_on_slot_selected)
		else:
			slot.visible = false

func _get_ui():
	var ui = get_tree().current_scene.get_node_or_null("UI")
	if ui == null:
		ui = get_tree().get_first_node_in_group("ui")
	return ui

func _on_reward_hover_started(item_ref):
	print("================")
	print("REWARD TOOLTIP START")
	print("ITEM REF:", item_ref)
	print("================")

	var item_instance = item_ref.item_instance
	var item_id = item_instance.get("id", "")

	if !ItemDB.ITEMS.has(item_id):
		return

	var data = ItemDB.ITEMS[item_id]
	var title = data.get("name", "")
	var description = data.get("description", "")
	var status = GameManager.item_manager.get_item_status_text(item_instance)
	var rarity = data.get("rarity", "")

	var ui = _get_ui()
	if ui == null:
		print("UI NOT FOUND")
		return

	ui.show_tooltip(
		title,
		description,
		status,
		rarity,
		get_viewport().get_mouse_position() + Vector2(24, 24)
	)


func _on_reward_hover_ended():
	var ui = _get_ui()
	if ui:
		ui.hide_tooltip()

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
