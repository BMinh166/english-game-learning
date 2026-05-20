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
	rarity_label.text = rarity
