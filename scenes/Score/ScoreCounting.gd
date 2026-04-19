extends Control

@onready var score = $VBoxContainer/Score
@onready var point = $VBoxContainer/HBoxContainer/Point
@onready var mult = $VBoxContainer/HBoxContainer/Mult
@onready var X = $VBoxContainer/HBoxContainer/X

func set_score(value, p_value, m_value):
	if value == 0 :
		score.text = "0"
	else:
		score.text = str(value)
	if p_value == 0 && m_value == 0 :
		point.text = "0"
		mult.text = "0"
		X.text = "x"
	else:
		point.text = str(p_value)
		mult.text = str(m_value)
		X.text = "x"
	
