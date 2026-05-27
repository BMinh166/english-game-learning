extends Control

@onready var progress_bar = $MarginContainer/TextureProgressBarFill
@onready var progress_score = $MarginContainer/ProgressScore

var numer = 0
var denomin = 0

func set_progress_bar(numerator,denominator):
	if denominator == 0:
		return
	elif denominator != 0:
		var value = 100.0 * numerator / denominator
		progress_bar.value = value
		progress_score.text = format_number(numerator) + "/" + format_number(denominator)
		if numerator != numer or (numerator == numer and denomin != denomin):
			AudioManager.play_bar_increase()
			numer = numerator
			denomin = denominator
	
func format_number(n):

	if n >= GameManager.MAX_SCORE:
		return "Naneinf"

	if n >= 1e12:

		var exponent = int(
			floor(
				log(n) / log(10)
			)
		)

		var mantissa = n / pow(
			10,
			exponent
		)

		return (
			str(snapped(mantissa, 0.01))
			+ "e"
			+ str(exponent)
		)

	if n >= 1e9:

		return (
			str(snapped(n / 1e9, 0.01))
			+ "B"
		)

	return str(int(n))
