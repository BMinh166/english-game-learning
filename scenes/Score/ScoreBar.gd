extends Control

@onready var progress_bar = $MarginContainer/ProgressBar
@onready var progress_score = $MarginContainer/ProgressScore

func set_progress_bar(value):
	progress_bar.value = value
	
func set_progress_score(numerator,denominator):
	progress_score.text = numerator + "/" + denominator
