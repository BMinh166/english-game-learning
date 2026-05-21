extends Control

@onready var synonym_label = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/RelationContainer/SynonymContainer/MarginContainer/HBoxContainer/SynonymLabel
@onready var antonym_label = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/RelationContainer/AntonymContainer/MarginContainer/HBoxContainer/AntonymLabel
@onready var degree_label = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/RelationContainer/DegreeContainer/MarginContainer/HBoxContainer/DegreeLabel
@onready var family_label = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/RelationContainer/FamilyContainer/MarginContainer/HBoxContainer/FamilyLabel
@onready var pos_label = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/RelationContainer/POSContainer/MarginContainer/HBoxContainer/POSLabel

@onready var back_button = $CenterContainer/MarginContainer/MenuContainer/BackButton

var pause_menu = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if get_tree().paused:
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	load_relation_info()

func load_relation_info():

	synonym_label.text = (
		Localization.tr_ui("synonym"))

	antonym_label.text = (
		Localization.tr_ui("antonym"))

	degree_label.text = (
		Localization.tr_ui("degree"))

	family_label.text = (
		Localization.tr_ui("family"))

	pos_label.text = (
		Localization.tr_ui("pos"))
		
	back_button.text = Localization.tr_ui("back")
		

func _on_back_button_pressed() -> void:

	if pause_menu != null:

		pause_menu.show()

	queue_free()
