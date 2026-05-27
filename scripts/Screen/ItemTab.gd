extends Control

@onready var grid = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/Panel/ScrollContainer/MarginContainer/GridContainer
@onready var item_tooltip = $TooltipLayer/ItemTooltip

@onready var back_button = $CenterContainer/MarginContainer/VBoxContainer/BackButton

var item_scene = preload(
	"res://scenes/Items/item.tscn"
)


func _ready():

	update_language_ui()
	load_items()


func load_items():

	for child in grid.get_children():
		child.queue_free()

	var item_ids = ItemDB.ITEMS.keys()

	item_ids.sort_custom(
		func(a, b):
			return ItemDB.ITEMS[a]["num"] < ItemDB.ITEMS[b]["num"]
	)

	for item_id in item_ids:

		var slot = item_scene.instantiate()

		grid.add_child(slot)
		
		slot.connect(
			"hover_started",
			_on_item_hover_started
		)

		slot.connect(
			"hover_ended",
			_on_item_hover_ended
		)

		var discovered = SaveManager.save_data["collection"]["items"].has(item_id)

		if discovered:

			slot.setup({
				"id": item_id
			})

		else:

			slot.label.text = "???"

			slot.disable_interaction()
			
func update_language_ui():

	back_button.text = Localization.tr_ui(
		"back"
	)

func _on_item_hover_started(item_ref):

	var item_instance = item_ref.item_instance

	# =====================
	# UNDISCOVERED
	# =====================

	if item_instance == null:

		item_tooltip.setup(
			"???",
			Localization.tr_ui(
				"undiscovered_item"
			),
			"",
			""
		)
		item_tooltip.visible = true

		item_tooltip.position = (
			get_viewport().get_mouse_position()
			+ Vector2(24, 24)
		)

		return

	var item_id = item_instance.get("id", "")

	if !ItemDB.ITEMS.has(item_id):
		return

	var data = ItemDB.ITEMS[item_id]
	
	var description = Localization.tr_item(
		item_id + "_desc"
	)

	item_tooltip.setup(
		data.get("name", ""),
		description,
		"",
		data.get("rarity", "")
	)

	item_tooltip.visible = true

	#item_tooltip.position = (
		#get_viewport().get_mouse_position()
		#+ Vector2(24, 24)
	#)
	
func _process(_delta):

	if item_tooltip.visible:

		item_tooltip.position = (
			get_viewport().get_mouse_position()
			+ Vector2(24, 24)
		)
	
func _on_item_hover_ended():

	item_tooltip.visible = false

func _on_back_button_pressed() -> void:
	AudioManager.play_button_click()
	get_tree().change_scene_to_file(
		"res://scenes/Screen/collection_menu.tscn"
	)
