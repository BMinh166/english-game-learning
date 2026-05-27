extends Control

@onready var back_button = $CenterContainer/MarginContainer/MenuContainer/BackButton
@onready var new_game_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/NewGameButton
@onready var setting_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/SettingButton
@onready var main_menu_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/MainMenuButton
@onready var relations_button = $CenterContainer/MarginContainer/MenuContainer/MarginContainer/ButtonContainer/RelationsButton

var relation_scene = preload(
	"res://scenes/Screen/relation_info_menu.tscn"
)

var new_game_scene = preload(
	"res://scenes/Screen/new_game_menu.tscn"
)

func _ready():
	hide()
	update_language_ui()

	#back_button.pressed.connect(_on_back_button_pressed)
	#new_game_button.pressed.connect(_on_new_game_button_pressed)
	#setting_button.pressed.connect(_on_setting_button_pressed)
	#main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	#relations_button.pressed.connect(_on_relations_button_pressed)

func update_language_ui():

	back_button.text = Localization.tr_ui(
		"back"
	)

	new_game_button.text = Localization.tr_ui(
		"new_game"
	)

	setting_button.text = Localization.tr_ui(
		"settings"
	)

	main_menu_button.text = Localization.tr_ui(
		"main_menu"
	)

	relations_button.text = Localization.tr_ui(
		"relations"
	)

func open():

	if GameManager.is_scoring:
		return

	if GameManager.reward_popup_open:
		return
		
	var ui = get_tree().get_first_node_in_group("ui")

	if ui:
		ui.hide_tooltip()

	show()
	get_tree().paused = true


func close():
	get_tree().paused = false
	hide()


func _on_new_game_button_pressed() -> void:
	AudioManager.play_button_click()
	
	if get_tree().current_scene.has_node("NewGameMenu"):
		return

	hide()

	var popup = new_game_scene.instantiate()

	popup.pause_menu = self

	get_tree().current_scene.add_child(popup)


func _on_setting_button_pressed() -> void:
	print("Open setting")
	AudioManager.play_button_click()
	if get_tree().current_scene.has_node("Setting"):
		return
	
	hide()

	var setting_scene = preload(
		"res://scenes/Screen/setting.tscn"
	)

	var setting = setting_scene.instantiate()

	setting.pause_menu = self

	get_tree().current_scene.add_child(setting)


func _on_main_menu_button_pressed() -> void:
	AudioManager.play_button_click()
	get_tree().paused = false

	GameManager.reset_state()

	get_tree().change_scene_to_file(
		"res://scenes/Screen/main_menu.tscn"
	)


func _on_back_button_pressed() -> void:
	AudioManager.play_button_click()
	close()


func _on_relations_button_pressed() -> void:
	hide()
	AudioManager.play_button_click()
	
	var popup = relation_scene.instantiate()

	popup.pause_menu = self

	get_tree().current_scene.add_child(popup)
