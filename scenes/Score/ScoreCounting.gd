extends Control

@onready var score = $VBoxContainer/Score
@onready var point = $VBoxContainer/HBoxContainer/Point
@onready var mult = $VBoxContainer/HBoxContainer/Mult

func set_score(value):
	score.text = value

func set_pm_value(p_value, m_value):
	point.text = p_value
	mult.text = m_value
