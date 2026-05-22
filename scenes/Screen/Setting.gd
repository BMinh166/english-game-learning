extends Control

@onready var language_button = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Language/LanguageButton
@onready var master_slider = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/MasterVolume/MasterSlider
@onready var music_slider = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/MusicVolume/MusicSlider
@onready var sfx_slider = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/SFXVolume/SFXSlider
@onready var game_speed_slider = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/GameSpeed/GameSpeedSlider
@onready var back_button = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/BackButton

@onready var master_value_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/MasterVolume/MasterValueLabel
@onready var music_value_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/MusicVolume/MusicValueLabel
@onready var sfx_value_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/SFXVolume/SFXValueLabel
@onready var game_speed_value_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/GameSpeed/GameSpeedValueLabel

@onready var setting_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/SettingLabel
@onready var language_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Language/LanguageLabel
@onready var master_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/MasterVolume/MasterLabel
@onready var music_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/MusicVolume/MusicLabel
@onready var sfx_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/SFXVolume/SFXLabel
@onready var game_speed_label = $SettingLayer/CenterContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/GameSpeed/GameSpeed

var pause_menu = null
var loading_settings := false


func _ready():

	if get_tree().paused:
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	load_settings()


func load_settings():

	loading_settings = true

	var settings = SaveManager.save_data["settings"]

	# =====================
	# LANGUAGE
	# =====================

	var lang = settings.get("language", "en")

	Localization.set_language(lang)

	language_button.text = (
		"English"
		if lang == "en"
		else "Tiếng Việt"
	)

	# =====================
	# VOLUME
	# =====================

	master_slider.value = settings.get(
		"master_volume",
		100
	)

	music_slider.value = settings.get(
		"music_volume",
		100
	)

	sfx_slider.value = settings.get(
		"sfx_volume",
		100
	)

	game_speed_slider.value = (
		settings.get("game_speed", 1) - 1
	)
	
	loading_settings = false
	
	update_value_labels()
	apply_settings()
	
func update_value_labels():

	master_value_label.text = (
		str(int(master_slider.value))
	)

	music_value_label.text = (
		str(int(music_slider.value))
	)

	sfx_value_label.text = (
		str(int(sfx_slider.value))
	)

	game_speed_value_label.text = (
		str(int(game_speed_slider.value) + 1)
	)
	
func apply_settings():

	# =====================
	# LANGUAGE
	# =====================

	Localization.set_language(
		SaveManager.get_setting(
			"language",
			"en"
		)
	)

	# =====================
	# UI TEXT
	# =====================

	update_language_ui()
	
func update_language_ui():

	setting_label.text = Localization.tr_ui(
		"settings"
	)

	language_label.text = Localization.tr_ui("language")
	master_label.text = Localization.tr_ui("master_volume")
	music_label.text = Localization.tr_ui("music_volume")
	sfx_label.text = Localization.tr_ui("sfx_volume")
	game_speed_label.text = Localization.tr_ui("game_speed")
	
	back_button.text = Localization.tr_ui("back")

func _on_back_button_pressed() -> void:

	print("PREVIOUS:", GameManager.previous_scene_path)

	# =====================
	# OPENED FROM PAUSE
	# =====================

	if pause_menu != null:

		if pause_menu.has_method(
			"update_language_ui"
		):
			pause_menu.update_language_ui()

		pause_menu.show()

		queue_free()

		return

	# =====================
	# OPENED FROM MAIN MENU
	# =====================

	if GameManager.previous_scene_path != "":

		get_tree().change_scene_to_file(
			GameManager.previous_scene_path
		)
		
		

func _on_language_button_pressed() -> void:
	if Localization.current_language == "en":

		SaveManager.set_setting(
			"language",
			"vi"
		)

	else:

		SaveManager.set_setting(
			"language",
			"en"
		)

	load_settings()


func _on_master_slider_value_changed(value: float) -> void:
	if loading_settings:
		return
	
	SaveManager.set_setting(
		"master_volume",
		int(master_slider.value)
	)

	update_value_labels()


func _on_music_slider_value_changed(value: float) -> void:
	if loading_settings:
		return
	
	SaveManager.set_setting(
		"music_volume",
		int(music_slider.value)
	)

	update_value_labels()


func _on_sfx_slider_value_changed(value: float) -> void:
	if loading_settings:
		return
	
	SaveManager.set_setting(
		"sfx_volume",
		int(sfx_slider.value)
	)

	update_value_labels()


func _on_game_speed_slider_value_changed(value: float) -> void:
	if loading_settings:
		return
	
	var game_speed_value = int(game_speed_slider.value) + 1
	
	SaveManager.set_setting(
		"game_speed",
		game_speed_value
	)
	
	GameManager.apply_game_speed()

	update_value_labels()

	apply_settings()
