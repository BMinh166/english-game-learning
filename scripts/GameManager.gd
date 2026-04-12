extends Node

var word_db
var relation
var score_system
var generate_words

var max_discard = 3
var discard_left = 3
@warning_ignore("shadowed_global_identifier")
var round = 1
var max_select = 5
var current_word
var hand_size = 5
var bag_size = 20
var hand = []
var bag = []
var mult = 0
var point = 0
var score = 0
var result_score = 0
var target_score = 500
var turn = 5
var max_turn = 5

signal update_state_ui(state)

func _ready():
	word_db = WordDB
	relation = Relation.new()
	score_system = Score.new()
	generate_words = GenerateWords.new()
#
	start_game()
		#
func start_game():
	current_word = word_db.get_random_word_exclude(current_word)
	discard_left = max_discard
	draw_hand()
	print("Game start")
	print("Word:", current_word.text)
#
func draw_hand():
	var result = generate_words.generate(word_db, current_word, hand_size, bag_size)
	
	hand = result.hand
	print("Hand size: " + str(hand_size))
	print("First word: " + str(hand[0].text))
	bag = result.bag
	emit_signal("update_state_ui", get_state())

#
func play_selected(indices):
	if indices.is_empty():
		return
	
	var total_score = 0
	var total_point = 0
	var total_mult = 0
	
	# ===== CALCULATE =====
	for i in indices:
		if i < 0 or i >= hand.size():
			continue
		
		var word = hand[i]
		
		var relations = relation.check_relation(current_word, word)
		var result = score_system.calculate(relations, word.level)
		
		total_score += result.score
		total_point += result.point
		total_mult += result.mult
	
	# ===== APPLY =====
	point = total_point
	mult = total_mult
	result_score = total_score
	
	score += total_score
	turn -= 1
	discard_left = max_discard
	
	# ===== ROUND / GAME OVER =====
	if score >= target_score:
		next_round()
	elif turn <= 0:
		end_game()
		return
	
	# ===== NEXT TURN =====
	current_word = word_db.get_random_word_exclude(current_word)
	draw_hand()
	
	
	# ===== UPDATE UI =====
	emit_signal("update_state_ui", get_state())
	
func next_round():
	round += 1
	score -= target_score
	target_score = int(target_score * 1.5)
	
	turn = max_turn
	discard_left = max_discard
	
	print("=== NEXT ROUND ===")
	
func end_game():
	print("Game Over - Final Score:", score)
	#reset lại state 
	reset_state()
	# start lại game
	start_game()
	#update_ui()
	
func reset_state():
		# reset state
	score = 0
	round = 1
	target_score = 500
	turn = 5
	max_turn = 5
	mult = 0
	point = 0
	result_score = 0
	current_word = null
	discard_left = max_discard
	hand.clear()
	bag.clear()
	
func discard_selected(indices):
	if indices.is_empty():
		return
	
	if discard_left <= 0:
		return
	
	discard_left -= 1
	
	var sorted = indices.duplicate()
	sorted.sort()
	sorted.reverse()
	
	for i in sorted:
		if i >= 0 and i < hand.size():
			hand.remove_at(i)
	
	# rút từ bag
	while hand.size() < hand_size and bag.size() > 0:
		var rand_index = randi() % bag.size()
		hand.append(bag[rand_index])
		bag.remove_at(rand_index)
	
	emit_signal("update_state_ui", get_state())
	
func get_state():
	return {
		"current_word": current_word,
		"score": score,
		"result_score": result_score,
		"target_score": target_score,
		"turn": turn,
		"round": round,
		"mult": mult,
		"point": point,
		"max_discard": max_discard,
		"max_select": max_select,
		"max_turn": max_turn,
		"discard_left":discard_left,
	}
