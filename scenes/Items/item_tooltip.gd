extends PanelContainer

@onready var name_label = $MarginContainer/MasterContainer/NameLabel
@onready var description_label = $MarginContainer/MasterContainer/DescriptionContainer/DescriptionLabel
@onready var status_label = $MarginContainer/MasterContainer/StatusLabel
@onready var rarity_label = $MarginContainer/MasterContainer/RarityLabel


func _ready():

	mouse_filter = Control.MOUSE_FILTER_IGNORE

	top_level = true

	z_index = 9999


func setup(title, description, status, rarity):

	name_label.text = title
	description_label.text = description
	status_label.text = status

	rarity_label.text = (
		Localization.tr_rarity(rarity)
	)

	rarity_label.modulate = get_rarity_color(
		rarity
	)


func get_rarity_color(rarity: String) -> Color:

	match rarity:

		"common":
			return Color("B8B8B8")

		"uncommon":
			return Color("7FFF6A")

		"rare":
			return Color("3DA5FF")

		"legendary":
			return Color("FFC14D")

	return Color.WHITE
