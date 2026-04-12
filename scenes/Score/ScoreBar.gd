extends Control

@onready var progress_bar = $MarginContainer/ProgressBar
@onready var progress_score = $MarginContainer/ProgressScore

func set_progress_bar(numerator,denominator):
	if denominator == 0:
		return
	elif denominator != 0:
		var value = 100.0 * numerator / denominator
		progress_bar.value = value
		progress_score.text = str(numerator) + "/" + str(denominator)
	
