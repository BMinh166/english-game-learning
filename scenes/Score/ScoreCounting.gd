extends Control

@onready var score = $VBoxContainer/Score
@onready var point = $VBoxContainer/HBoxContainer/Point
@onready var mult = $VBoxContainer/HBoxContainer/Mult
@onready var X = $VBoxContainer/HBoxContainer/X

func set_score(value):
	if value == 0 :
		score.text = ""
	else:
		score.text = str(value)

func set_pm_value(p_value, m_value):
	if p_value == 0 && m_value == 0 :
		point.text = ""
		mult.text = ""
		X.text = ""
	else:
		point.text = str(p_value)
		mult.text = str(m_value)
		X.text = "x"
