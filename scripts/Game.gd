extends Node

@onready var word_label = $Control/Main/Body/CenterArea/CenterContainer/WordLabel
@onready var score_label = $Control/Main/ScoreBar/ScoreContainer/Score
@onready var turn_label = $Control/Main/Body/VBoxContainer/VBoxContainer/TurnLabel
@onready var hand_buttons = $Control/Main/Body/CenterArea/HandContainer.get_children()
@onready var progress_bar = $Control/Main/Panel/ProgressBar
@onready var progress_score_label = $Control/Main/Panel/ProgressScore
@onready var bag_button = $Control/Main/Body/VBoxContainer/BagButton
@onready var point_label = $Control/Main/ScoreBar/ScoreContainer/PointandMult/Point
@onready var mult_label = $Control/Main/ScoreBar/ScoreContainer/PointandMult/Mult

var word_db
var relation
var score_system
var bag_popup_scene = preload("res://scenes//BagPopup.tscn")

var result_score = 0
var point = 0
var mult = 0
var target_score = 500
var progressbar_ratio = 0
var current_word
var hand = []
var bag = []
var score = 0
var turn = 5

func _ready():
	word_db = WordDB
	relation = Relation.new()
	score_system = Score.new()

	start_game()
	update_ui()
		
func start_game():
	current_word = word_db.get_random_word_exclude(current_word)
	draw_hand()

	print("Game start")
	print("Word:", current_word.text)

func draw_hand():
	hand.clear()
	bag.clear()
	generate_hand_and_bag();
		
func generate_hand_and_bag():
	var pool = WordDB.words.duplicate()
	pool.erase(current_word)

	pool.shuffle()

	var hand_size = min(5, pool.size())
	hand = pool.slice(0, hand_size)
	
	var bag_size = min(20, pool.size() - hand_size)
	bag = pool.slice(hand_size, hand_size + bag_size)

	#print("Current:", current_word.text)

	#print("Hand:")
	#for w in hand:
	#	print(w.text)

	#print("Bag:")
	#for w in bag:
	#	print(w.text)

func play_word(word):
	print("==== TURN ====")
	print("Current BEFORE:", current_word.text)
	print("Current BEFORE ID:", current_word.id)
	print("Play:", word.text)
	print("Play ID:", word.id)
	print("Play level:", word.level)

	var relations = relation.check_relation(current_word, word)
	var result = score_system.calculate(relations, word.level)
	result_score = result.score
	mult = result.mult
	point = result.point

	score += result_score
	progressbar_ratio = int(score * 100 /target_score)
	turn -= 1

	# 🔥 đổi word sau khi log
	current_word = WordDB.get_random_word_exclude(current_word)

	draw_hand()

	print("Current AFTER:", current_word.text)
	print("Current AFTER ID:", current_word.id)
	print("Relation:", relations[0].type)
	print("Point:", result.point)
	print("Mult:", result.mult)
	print("Score gained:", result_score)
	print("Score:", score)
	print("Turn:", turn)
	print("=============")

	if turn <= 0:
		end_game()
		return
		
func update_ui():
	word_label.text = current_word.text
	point_label.text = str(point)
	mult_label.text = str(mult)
	score_label.text = str(result_score)
	turn_label.text = "Turn: " + str(turn)
	progress_score_label.text = str(score) + "/" + str(target_score)
	progress_bar.value = progressbar_ratio

	for i in range(hand_buttons.size()):
		if i < hand.size():
			var w = hand[i]
			hand_buttons[i].text = w.text
			
			# clear signal cũ
			for c in hand_buttons[i].pressed.get_connections():
				hand_buttons[i].pressed.disconnect(c.callable)
			
			# gắn click mới
			hand_buttons[i].pressed.connect(func():
				play_word(w)
				update_ui()
			)
		else:
			hand_buttons[i].text = ""
func end_game():
	print("Game Over - Final Score:", score)

	# reset state
	score = 0
	turn = 5
	mult = 0
	point = 0
	progressbar_ratio = 0
	result_score = 0
	current_word = null
	hand.clear()
	bag.clear()

	# start lại game
	start_game()
	update_ui()
	


func _on_bag_button_pressed() -> void:
	var popup = bag_popup_scene.instantiate()
	add_child(popup)
	popup.setup(bag)
