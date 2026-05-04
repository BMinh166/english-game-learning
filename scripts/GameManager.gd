extends Node

var word_db
var relation
var score_system
var generate_words
var chain_system

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
var step_delay: float = 0.2

#SIGNALS
signal update_state_ui(state)
signal update_score_counting(state)
signal play_cards(cards)
signal clear_center_cards()
signal show_floating_text(card_ref, data)

func _ready():
	word_db = WordDB
	relation = Relation.new()
	score_system = Score.new()
	generate_words = GenerateWords.new()
	chain_system = ChainSystem.new()
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
func play_selected(cards):
	if cards.is_empty() or is_scoring:
		return
	
	print("CARDS START:", cards)
	await get_tree().create_timer(0.1).timeout
	print("CARDS AFTER WAIT:", cards)
	
	is_scoring = true
	
	var selected_words = []
	chain_system.reset()

	for card in cards:
		selected_words.append(card.data)
	
	# 👉 báo UI: đưa card ra giữa
	emit_signal("play_cards", cards)

	# 👉 chờ animation
	await get_tree().create_timer(0.5).timeout

	result_score = 0

	for i in range(cards.size()):
		var card = cards[i]
		var word = selected_words[i]

		var relations = relation.check_relation(current_word, word)
		var steps = score_system.build_steps(relations, word.level)
		
		print("\n=== NEW WORD ===")
		print("WORD:", word.text)
		print("RELATIONS:", relations.size())
		print("STEPS:", steps)

		print("CHAIN:", chain_system.get_chain_count(), " MULT:", mult)

		var is_valid = relations.size() > 0
		var score_one = await process_single_word(steps, card, is_valid)

		result_score += score_one
		
		mult = 0
		point = 0
		emit_signal("update_score_counting", get_state())
		await wait_step()

	await get_tree().create_timer(0.3).timeout

	# ===== APPLY =====
	score += result_score
	turn -= 1
	discard_left = max_discard

	print("Final Total Score: ", score)
	# 👉 FIX: loop qua nhiều round nếu đủ điểm
	var round_passed = 0

	while score >= target_score:
		score -= target_score
		round += 1
		target_score = int(target_score * 1.5)
		round_passed += 1

		print("=== NEXT ROUND ===", "Round:", round, "Score left:", score)

	# 👉 reset turn nếu có qua ít nhất 1 round
	if round_passed > 0:
		turn = max_turn
		discard_left = max_discard

	# 👉 nếu không qua round nào thì check game over
	elif turn <= 0:
		end_game()
		return

	emit_signal("clear_center_cards")

	current_word = word_db.get_random_word_exclude(current_word)
	draw_hand()

	is_scoring = false
	
func process_single_word(steps: Array, card, is_valid: bool) -> int:
	point = 0
	mult = 1

	# ===== BASE STEPS =====
	for step in steps:
		apply_step(step)

		emit_signal("show_floating_text", card, {
			"text": get_text_from_step(step),
			"type": step.type
		})

		emit_signal("update_score_counting", get_state())
		await wait_step()

	print("[BASE RESULT]")
	print("point:", point, " mult:", mult)

	# ===== CHAIN APPLY =====
	var chain_data = chain_system.apply_chain(is_valid)

	print("[CHAIN DATA]")
	print("is_valid:", is_valid)
	print("chain_count:", chain_data.chain_count)
	print("chain_mult:", chain_data.chain_mult)
	print("delta_mult:", chain_data.delta_mult)

	# 👉 tính mult cuối (CHỈ 1 LẦN)
	var final_mult = mult * chain_data.chain_mult

	print("[FINAL CALC]")
	print("base_mult:", mult)
	print("chain_mult:", chain_data.chain_mult)
	print("final_mult(before round):", final_mult)

	# 👇 floating text cho chain (x1.5)
	if chain_data.applied:
		var chain_level = chain_data.chain_count - 1  # vì chain 1 = base
		var chain_mult_str = format_float(chain_data.chain_mult)

		var text = "Chain " + str(chain_level) + " (x" + chain_mult_str + " Mult)"

		emit_signal("show_floating_text", card, {
			"text": text,
			"type": "chain"
		})

		#await get_tree().create_timer(0.3).timeout

	# 👉 áp dụng mult cuối (ROUND TẠI ĐÂY)
	mult = int(final_mult)

	#mult *= mult
	#mult *= mult
	#mult = int(mult)

	# 🔥 QUAN TRỌNG: update UI sau khi có mult cuối
	emit_signal("update_score_counting", get_state())

	await wait_step()

	var score_one = point * mult

	print("FINAL SCORE:", score_one)

	return score_one
	
func format_float(value: float) -> String:
	var s = str(value)

	# làm tròn tối đa 3 chữ số thập phân
	s = "%.3f" % value

	# bỏ số 0 dư
	s = s.rstrip("0").rstrip(".")

	# đổi . thành ,
	s = s.replace(".", ",")

	return s
	
func get_text_from_step(step):
	match step.type:

		"set_base":
			var label = step.get("relation_label", "")
			var p = step.get("point", 0)
			var m = step.get("mult", 1)

			return label + " (" + str(p) + " x" + str(m) + ")"

		"add_point":
			var value = step.value
			var source = step.get("source", "")

			if source == "level":
				return step.level + " (+" + str(value) + " Point)"
			else:
				return "+" + str(value) + " Point"

		"add_mult":
			var value = step.value
			var source = step.get("source", "")

			if source == "level":
				return step.level + " (+" + str(value) + " Mult)"
			else:
				return "+" + str(value) + " Mult"

		"mul_mult":
			return "x" + str(step.value) + " Mult"

		"chain":
			return "Chain x" + str(step.value)

		_:
			return step.type
	
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
	
func wait_step():
	return get_tree().create_timer(step_delay).timeout
	
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
