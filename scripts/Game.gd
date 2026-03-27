extends Node

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

	# test auto play
	for i in range(15):
		play_word(hand.pick_random())
		
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
