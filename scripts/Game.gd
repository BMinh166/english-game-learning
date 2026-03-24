extends Node

var word_db
var relation
var score_system

var current_word
var hand = []
var score = 0
var turn = 5

func _ready():
	word_db = WordDB
	relation = Relation.new()
	score_system = Score.new()

	start_game()

	# test auto play
	for i in range(5):
		play_word(hand.pick_random())
		
func start_game():
	current_word = word_db.get_random_word_exclude(current_word)
	draw_hand()

	print("Game start")
	print("Word:", current_word.text)

func draw_hand():
	hand.clear()
	for i in range(5):
		hand.append(word_db.get_random_word_exclude(current_word))

func play_word(word):
	print("==== TURN ====")
	print("Current BEFORE:", current_word.text)
	print("Play:", word.text)

	var relations = relation.check_relation(current_word, word)
	var gained = score_system.calculate(relations, word.level)

	score += gained
	turn -= 1

	# 🔥 đổi word sau khi log
	current_word = WordDB.get_random_word_exclude(current_word)

	draw_hand()

	print("Current AFTER:", current_word.text)
	print("Score:", score)
	print("Turn:", turn)
	print("=============")

	if turn <= 0:
		print("Game Over")
