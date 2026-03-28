extends Node

@onready var word_label = $Control/Main/WordLabel
@onready var score_label = $Control/Main/ScoreLabel
@onready var turn_label = $Control/Main/TurnLabel
@onready var hand_buttons = $Control/Main/HandContainer.get_children()

var word_db
var relation
var score_system


var current_word
var hand = []
var bag = []
var score = 0
var turn = 15

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
	
	var bag_size = min(10, pool.size() - hand_size)
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
	var gained = score_system.calculate(relations, word.level)

	score += gained
	turn -= 1

	# 🔥 đổi word sau khi log
	current_word = WordDB.get_random_word_exclude(current_word)

	draw_hand()

	print("Current AFTER:", current_word.text)
	print("Current AFTER ID:", current_word.id)
	print("Relation:", relations[0].type)
	print("Current score:", gained)
	print("Score:", score)
	print("Turn:", turn)
	print("=============")

	if turn <= 0:
		print("Game Over")
		
func update_ui():
	word_label.text = "Word: " + current_word.text
	score_label.text = "Score: " + str(score)
	turn_label.text = "Turn: " + str(turn)

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
