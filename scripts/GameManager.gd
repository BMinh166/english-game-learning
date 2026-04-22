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
var center_area = []
var bag = []
var mult = 0
var point = 0
var score = 0
var result_score = 0
var target_score = 500
var turn = 5
var max_turn = 5
var is_scoring = false

signal update_state_ui(state)
signal update_score_counting(state)
signal play_cards(indices)
signal clear_center_cards()

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

func refill_hand():
	while hand.size() < hand_size and bag.size() > 0:
		var rand_index = randi() % bag.size()
		hand.append(bag[rand_index])
		bag.remove_at(rand_index)
#
func play_selected(indices):
	if indices.is_empty() or is_scoring:
		return
	
	print("INDICES START:", indices)
	await get_tree().create_timer(0.1).timeout
	print("INDICES AFTER WAIT:", indices)
	
	is_scoring = true
	
	var selected_words = []

	for i in indices:
		if i >= 0 and i < hand.size():
			selected_words.append(hand[i])
	
	# 👉 báo UI: đưa card ra giữa
	emit_signal("play_cards", indices)
	

	# 👉 chờ animation (UI xử lý)
	await get_tree().create_timer(0.5).timeout

	result_score = 0

	for word in selected_words:
		var relations = relation.check_relation(current_word, word)
		var steps = score_system.build_steps(relations, word.level)

		# chạy pipeline riêng cho từng word
		var count_step = 0
		for step in steps:
			count_step+= 1
			print("STEP " + str(count_step) + ": " + str(step.word))
		var score_one = await process_single_word(steps)

		result_score += score_one
		
		mult = 0
		point = 0
		emit_signal("update_score_counting", get_state())
		await get_tree().create_timer(0.3).timeout

	# ===== APPLY =====
	score += result_score
	turn -= 1
	discard_left = max_discard

	if score >= target_score:
		next_round()
	elif turn <= 0:
		end_game()
		return
	emit_signal("clear_center_cards")

	current_word = word_db.get_random_word_exclude(current_word)
	draw_hand()

	is_scoring = false
	
func process_single_word(steps: Array) -> int:
	
	point = 0
	mult = 1

	for step in steps:
		apply_step(step)

		emit_signal("update_score_counting", get_state())

		await get_tree().create_timer(0.3).timeout

	var score_one = point * mult

	return score_one
	
func apply_step(step: Dictionary):
	match step.type:
		"set_base":
			point = step.point
			mult = step.mult

		"add_point":
			point += step.value
			print("UPDATE SCORE: Add point")

		"add_mult":
			mult += step.value
			print("UPDATE SCORE: Add mult")

		"mul_mult":
			mult *= step.value
			print("UPDATE SCORE: Mul mult")
	
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
