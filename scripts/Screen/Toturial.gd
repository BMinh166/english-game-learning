extends Control

@onready var image = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer/ImagePanel/Image
@onready var description_rtl = $CenterContainer/MarginContainer/VBoxContainer/MarginContainer2/RichTextPanel/DescriptionRTL
@onready var back_button = $CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/BackButton
@onready var current_step_label = $CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/CurrentStepLabel
@onready var toturial_label = $CenterContainer/MarginContainer/VBoxContainer/ToturialLabel
@onready var nextdone_button = $CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/NextDoneButton

var tutorial_steps = []

var current_step := 0

func _ready():

	tutorial_steps = [

		{
			"image": preload("res://assets/toturial/step_1.png"),
		},

		{
			"image": preload("res://assets/toturial/step_2.png"),
		},

		{
			"image": preload("res://assets/toturial/step_3.png"),
		},

		{
			"image": preload("res://assets/toturial/step_4.png"),
		},

		{
			"image": preload("res://assets/toturial/step_5.png"),
		}
	]
	update_language_ui()
	update_step()
	
func update_step():

	var data = tutorial_steps[current_step]

	# =====================
	# IMAGE
	# =====================

	image.texture = data["image"]

	# =====================
	# TEXT
	# =====================

	description_rtl.text = Localization.tr_ui(
		"tutorial_step_" + str(current_step + 1)
	)

	# =====================
	# STEP LABEL
	# =====================

	current_step_label.text = (
		str(current_step + 1)
		+ " / "
		+ str(tutorial_steps.size())
	)

	# =====================
	# BACK BUTTON
	# =====================

	back_button.disabled = current_step == 0

	# =====================
	# NEXT / DONE BUTTON
	# =====================

	var is_last = (
		current_step == tutorial_steps.size() - 1
	)

	if is_last:
		nextdone_button.text = Localization.tr_ui("done")
	else:
		nextdone_button.text = Localization.tr_ui("next")

func update_language_ui():

	back_button.text = Localization.tr_ui(
		"back"
	)
	
	toturial_label.text = Localization.tr_ui("toturial")


func _on_back_button_pressed() -> void:

	if current_step <= 0:
		return

	current_step -= 1

	update_step()


func _on_next_done_button_pressed() -> void:

	var is_last = (
		current_step == tutorial_steps.size() - 1
	)

	# =====================
	# DONE
	# =====================

	if is_last:

		SaveManager.set_setting(
			"tutorial_completed",
			true
		)

		get_tree().change_scene_to_file(
			"res://scenes/Main.tscn"
		)

		return

	# =====================
	# NEXT
	# =====================

	current_step += 1

	update_step()
