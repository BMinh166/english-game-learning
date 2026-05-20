extends Control

@onready var score = $VBoxContainer/Score
@onready var point = $VBoxContainer/HBoxContainer/Point
@onready var mult = $VBoxContainer/HBoxContainer/Mult
@onready var X = $VBoxContainer/HBoxContainer/X

func set_score(value, p_value, m_value):
	if value == 0 :
		score.text = "0"
	else:
		score.text = format_number(value)
	if p_value == 0 && m_value == 0 :
		point.text = "0"
		mult.text = "0"
		X.text = "x"
	else:
		point.text = str(p_value)
		mult.text = format_number(m_value)
		X.text = "x"
	
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
