extends Node

var word_db
var relation
var score_system
var generate_words
var bag_popup_scene = preload("res://scenes//Bag//BagPopup.tscn")

var max_discard = 3
var discard_left = 3
var result_score = 0
var round = 1
var target_score = 500
var max_select = 5
var current_word
var hand_size = 5
var bag_size = 20
var hand = []
var bag = []
var score = 0
var turn = 5
var selected_indices = []

var bag_popup = null

signal update_state_ui(state)

func _ready():
	word_db = WordDB
	relation = Relation.new()
	score_system = Score.new()
	generate_words = GenerateWords.new()
#
	start_game()
	emit_signal("update_state_ui", get_state())
		#
func start_game():
	current_word = word_db.get_random_word_exclude(current_word)
	discard_left = max_discard
	draw_hand()
	print("Game start")
	print("Word:", current_word.text)
#
func draw_hand():
	hand.clear()
	bag.clear()
	generate_words.generate(word_db, current_word, hand_size, bag_size)

#
#func play_word(word):
	#print("==== TURN ====")
	#print("Current BEFORE:", current_word.text)
	#print("Current BEFORE ID:", current_word.id)
	#print("Play:", word.text)
	#print("Play ID:", word.id)
	#print("Play level:", word.level)
#
	#var relations = relation.check_relation(current_word, word)
	#var result = score_system.calculate(relations, word.level)
	#result_score = result.score
	#mult = result.mult
	#point = result.point
#
	#score += result_score
	#turn -= 1
#
	## 🔥 đổi word sau khi log
	#current_word = WordDB.get_random_word_exclude(current_word)
#
	#draw_hand()
#
	#print("Current AFTER:", current_word.text)
	#print("Current AFTER ID:", current_word.id)
	#print("Relation:", relations[0].type)
	#print("Point:", result.point)
	#print("Mult:", result.mult)
	#print("Score gained:", result_score)
	#print("Score:", score)
	#print("Turn:", turn)
	#print("=============")
#
	#if turn <= 0:
		#end_game()
		#return
		#
#func update_ui():
	#word_label.text = current_word.text
	#point_label.text = str(point)
	#mult_label.text = str(mult)
	#score_label.text = str(result_score)
	#turn_label.text = "Turn: " + str(turn)
	#progress_score_label.text = str(score) + "/" + str(target_score)
	#progress_bar.value = float(score) / target_score * 100
#
	#for i in range(hand_buttons.size()):
		#if i < hand.size():
			#var w = hand[i]
			#hand_buttons[i].text = w.text
			#
			## reset style (tránh bị giữ highlight cũ)
			#hand_buttons[i].modulate = Color.WHITE
			#
			#if i in selected_indices:
				#hand_buttons[i].modulate = Color(0.7, 1, 0.7) # xanh nhẹ
			#
			## clear signal cũ
			#for c in hand_buttons[i].pressed.get_connections():
				#hand_buttons[i].pressed.disconnect(c.callable)
			#
			## click = select/deselect
			#hand_buttons[i].pressed.connect(func():
				#toggle_select(i)
			#)
		#else:
			#hand_buttons[i].text = ""
			#
	#play_button.disabled = selected_indices.is_empty()
	#discard_button.disabled = selected_indices.is_empty() or discard_left <= 0
	#discardleft_label.text = "Discard: " + str(discard_left)
	#round_label.text = "Round: " + str(round)
	#
#func next_round():
	#round += 1
	#score -= target_score
	#target_score = int(target_score * 1.5)
	#
	#turn = 5
	#discard_left = max_discard
	#
	#print("=== NEXT ROUND ===")
	#
#func end_game():
	#print("Game Over - Final Score:", score)
#
	## reset state
	#score = 0
	#round = 0
	#target_score = 500
	#turn = 5
	#mult = 0
	#point = 0
	#result_score = 0
	#current_word = null
	#discard_left = max_discard
	#hand.clear()
	#bag.clear()
	#selected_indices.clear()
#
	## start lại game
	#start_game()
	##update_ui()
	#
#
#
#
#func toggle_select(index):
	#if index in selected_indices:
		#selected_indices.erase(index)
	#else:
		#if selected_indices.size() < max_select:
			#selected_indices.append(index)
	#
	##update_ui()
#
#func _on_bag_button_pressed() -> void:
	#if bag_popup == null or !is_instance_valid(bag_popup):
		#bag_popup = bag_popup_scene.instantiate()
		#add_child(bag_popup)
		#bag_popup.setup(bag)
	#else:
		#bag_popup.queue_free()
		#bag_popup = null
#
#
#func _on_play_button_pressed():
	#if selected_indices.is_empty():
		#return
	#
	#var total_score = 0
	#var total_point = 0
	#var total_mult = 0
	#
	#for i in selected_indices:
		#var word = hand[i]
		#
		#var relations = relation.check_relation(current_word, word)
		#var result = score_system.calculate(relations, word.level)
		#
		#total_score += result.score
		#total_point += result.point
		#total_mult += result.mult
	#
	## apply tổng
	#result_score = total_score
	#point = total_point
	#mult = total_mult
	#
	#score += total_score
	#turn -= 1
	#discard_left = max_discard
#
	## ✅ check round TRƯỚC
	#if score >= target_score:
		#next_round()
#
	## ✅ check game over
	#elif turn <= 0:
		#end_game()
		#return
#
	## update state sau cùng
	#current_word = WordDB.get_random_word_exclude(current_word)
	#draw_hand()
	#selected_indices.clear()
	##update_ui()
#
#
#
#func _on_discard_button_pressed():
	#if selected_indices.is_empty():
		#return
	#
	#if discard_left <= 0:
		#return
	#
	#discard_left -= 1
	#
	#selected_indices.sort()
	#selected_indices.reverse()
	#
	#for i in selected_indices:
		#hand.remove_at(i)
	#
	## rút random từ bag
	#while hand.size() < 5 and bag.size() > 0:
		#var rand_index = randi() % bag.size()
		#hand.append(bag[rand_index])
		#bag.remove_at(rand_index)
	#
	#selected_indices.clear()
	##update_ui()
##########################################################

func get_state():
	return {
		"current_word": current_word,
		"score": score,
		"target_score": target_score,
		"turn": turn,
		"round": round,
		"max_discard": max_discard,
		"max_select": max_select,
		"discard_left":discard_left,
		"selected_indices":selected_indices
	}
