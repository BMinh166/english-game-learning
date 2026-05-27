extends Node

@onready var main_menu_bgm = $BGM/MainMenuBGM
@onready var main_game_bgm = $BGM/MainGameBGM

@onready var bar_increase = $SFX/BarIncrease
@onready var button_click = $SFX/ButtonClick
@onready var card_click = $SFX/CardClick
@onready var card_fly = $SFX/CardFly
@onready var card_hover = $SFX/CardHover
@onready var floating_text_score = $SFX/FloatingTextScore
@onready var item_activate = $SFX/ItemActivate
@onready var item_choose = $SFX/ItemChoose
@onready var lose_run = $SFX/LoseRun
@onready var next_round = $SFX/NextRound
@onready var score_fail = $SFX/ScoreFail
@onready var win_run = $SFX/WinRun

func _ready():

	apply_volume_settings()

# =========================
# BGM
# =========================

func play_main_menu_bgm():
	if main_game_bgm.playing:
		main_game_bgm.stop()

	if !main_menu_bgm.playing:
		main_menu_bgm.play()


func play_main_game_bgm():
	if main_menu_bgm.playing:
		main_menu_bgm.stop()

	if !main_game_bgm.playing:
		main_game_bgm.play()


func stop_bgm():
	main_menu_bgm.stop()
	main_game_bgm.stop()


# =========================
# SFX
# =========================

func play_button_click():
	button_click.pitch_scale = randf_range(0.98, 1.02)
	button_click.play()


func play_card_hover():
	if !card_hover.playing:
		card_hover.pitch_scale = randf_range(0.98, 1.02)
		card_hover.play()


func play_card_click():
	card_click.pitch_scale = randf_range(0.98, 1.02)
	card_click.play()


func play_card_fly():
	card_fly.pitch_scale = randf_range(0.98, 1.02)
	card_fly.play()


func play_floating_text_score():
	floating_text_score.pitch_scale = randf_range(0.98, 1.02)
	floating_text_score.play()


func play_score_fail():
	score_fail.play()


func play_item_activate():
	item_activate.play()


func play_item_choose():
	item_choose.play()


func play_bar_increase():
	bar_increase.pitch_scale = randf_range(0.98, 1.02)
	bar_increase.play()


func play_next_round():
	next_round.play()


func play_win_run():
	win_run.play()


func play_lose_run():
	lose_run.play()


# =========================
# VOLUME
# =========================

func volume_to_db(volume_percent: float) -> float:

	if volume_percent <= 0:
		return -80.0

	return lerp(
		-30.0,
		0.0,
		volume_percent / 100.0
	)


func apply_volume_settings():

	var master_volume = SaveManager.get_setting(
		"master_volume",
		100
	)

	var music_volume = SaveManager.get_setting(
		"music_volume",
		100
	)

	var sfx_volume = SaveManager.get_setting(
		"sfx_volume",
		100
	)

	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		volume_to_db(master_volume)
	)

	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		volume_to_db(music_volume)
	)

	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		volume_to_db(sfx_volume)
	)
