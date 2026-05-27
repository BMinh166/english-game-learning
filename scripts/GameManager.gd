extends Node

var word_db
var relation
var score_system
var generate_words
var chain_system
var item_manager

var max_discard = 5
var discard_left = 5
@warning_ignore("shadowed_global_identifier")
var round = 1
var max_select = 5
var current_word
var hand_size = 5
var bag_size = 40
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
var reward_popup_open := false
var pending_turn_bonus := 0
var max_reward_reroll := 5
var reward_reroll_left := 5
var run_used_items := {}
const MAX_SCORE = 1e15

var step_delay: float = 0.2
var previous_scene_path = ""
var play_time_accumulator := 0.0
var auto_save_timer := 0.0

#SIGNALS
signal update_state_ui(state)
signal update_score_counting(state)
signal play_cards(cards)
signal clear_center_cards()
signal show_floating_text(card_ref, data)
signal set_card_highlight(card, state, type)
signal update_item_ui()
signal activate_item_slot(item_id)

func _ready():
	word_db = WordDB
	relation = Relation.new()
	score_system = Score.new()
	generate_words = GenerateWords.new()
	chain_system = ChainSystem.new()
	item_manager = ItemManager.new()
	randomize()
	SaveManager.init_save()

	apply_game_speed()

	#if !load_current_run():
		#start_game()
		#
		

func _process(delta):

	if get_tree().paused:
		return

	# =====================
	# PLAY TIME TRACKING
	# =====================

	play_time_accumulator += delta

	var seconds_to_add = int(play_time_accumulator)

	if seconds_to_add > 0:

		SaveManager.save_data["statistics"]["total_play_time"] += seconds_to_add

		play_time_accumulator -= seconds_to_add

	# =====================
	# AUTO SAVE
	# =====================

	auto_save_timer += delta

	if auto_save_timer >= 30.0:

		auto_save_timer = 0.0

		SaveManager.save_game()
		
func start_game():
	reset_state()
	
	target_score = DifficultyManager.get_base_target()
	
	setup_round()
	current_word = word_db.get_random_word_exclude(current_word)
	
	#discard_left = max_discard
	
	draw_hand()

	print("Game start")
	print("Word:", current_word["text"])
	
	SaveManager.save_data["statistics"]["total_runs"] += 1
	
	SaveManager.save_current_run(
		build_round_save()
	)
#
func draw_hand():
	var result = generate_words.generate(
		word_db,
		current_word,
		hand_size,
		bag_size,
		DifficultyManager.current_difficulty
	)
	
	hand = result.hand
	print("Hand size: " + str(hand_size))
	print("First word: " + str(hand[0]["text"]))
	bag = result.bag
	emit_signal("update_state_ui", get_state())

func refill_hand():
	while hand.size() < hand_size and bag.size() > 0:
		var rand_index = randi() % bag.size()
		hand.append(bag[rand_index])
		bag.remove_at(rand_index)
		
#func start_new_run():
#
	#reset_state()
#
	#start_game()
#
func play_selected(cards):
	if cards.is_empty() or is_scoring:
		return
	item_manager.start_turn()
	
	print("CARDS START:", cards)
	await get_tree().create_timer(0.1).timeout
	print("CARDS AFTER WAIT:", cards)
	
	is_scoring = true
	
	var selected_words = []
	if !item_manager.has_effective_item(
		"infinite_paradox"
	):
		chain_system.reset()

	else:

		print("\n♾️ INFINITE PARADOX")
		print("CHAIN PERSISTED")
		print(
			"CHAIN:",
			chain_system.chain_count
		)

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
		var steps = score_system.build_steps(relations,	word["level"])
		
		print("\n=== NEW WORD ===")
		print("WORD:", word["text"])
		print("RELATIONS:", relations.size())
		print("STEPS:", steps)

		print("CHAIN:", chain_system.get_chain_count(), " MULT:", mult)

		var is_valid = relations.size() > 0
		var score_one = await process_single_word(steps, relations, card, is_valid)

		result_score += score_one
		result_score = min(result_score, MAX_SCORE)
		
		mult = 0
		point = 0
		emit_signal("update_score_counting", get_state())
		await wait_step()

	await get_tree().create_timer(0.3).timeout

	# ===== APPLY =====
	score += result_score
	score = min(score, MAX_SCORE)
	
	if score > SaveManager.save_data["statistics"]["highest_score"]:

		SaveManager.save_data["statistics"]["highest_score"] = score
	
	turn -= 1

	# clamp turn
	turn = max(turn, 0)

	discard_left = max_discard

	emit_signal("update_state_ui", get_state())

	# =====================
	# ROUND CLEAR
	# =====================

	if score >= target_score:

		clear_round()

		return

	# =====================
	# GAME OVER
	# =====================

	if turn <= 0:

		end_game()

		return

	# =====================
	# CONTINUE
	# =====================

	emit_signal("clear_center_cards")

	current_word = word_db.get_random_word_exclude(current_word)

	draw_hand()

	is_scoring = false
	
func process_single_word(steps: Array, relations: Array, card, is_valid: bool) -> int:
	point = 0
	mult = 0
	
	# =====================
	# FULL COMBO TRACK
	# =====================
	item_manager.played_word_count +=1
	
	# 🔥 bật highlight 1 lần duy nhất
	emit_signal(
		"set_card_highlight",
		card,
		true,
		"success" if is_valid else "fail"
	)
	
	# ===== BASE STEPS =====
	for step in steps:

		# ITEM MODIFY
		step = item_manager.modify_step(step)
		apply_step(step)

		emit_signal("show_floating_text", card, {
			"text": get_text_from_step(step),
			"type": step.type
		})

		emit_signal("update_score_counting", get_state())
		await wait_step()

	print("[BASE RESULT]")
	print("point:", point, " mult:", mult)
	
	# =====================
	# FULL COMBO TRACK
	# =====================
	
	if is_valid:
		item_manager.valid_word_count += 1
		
	SaveManager.save_data["statistics"]["total_words_played"] += 1
	
	# =====================
	# WORD TRACKING
	# =====================
	
	var word_data = SaveManager.get_word_data(card.data["text"])

	word_data["seen"] += 1

	if is_valid:
		word_data["correct"] += 1
		SaveManager.save_data["statistics"]["total_correct"] += 1
	else:
		word_data["wrong"] += 1
		SaveManager.save_data["statistics"]["total_wrong"] += 1
		
	# ❌ FAIL
	if !is_valid:
		emit_signal("show_floating_text", card, {
			"text": "Fail",
			"type": "fail"
		})

	# ===== CHAIN APPLY =====
	# =====================
	# PHANTOM HAND
	# =====================

	var chain_data

	if !is_valid:

		if chain_system.chain_count > 0:

			if item_manager.has_item("phantom_hand"):

				if !item_manager.phantom_hand_used:

					item_manager.phantom_hand_used = true

					print("\n👻 PHANTOM HAND ACTIVATED")
					print("FIRST FAIL DOES NOT RESET CHAIN")

					emit_signal("activate_item_slot", "phantom_hand")

					chain_data = {
						"applied": false,
						"chain_count": chain_system.chain_count,
						"chain_mult": chain_system.chain_mult,
						"delta_mult": 1.0
					}

				else:
					chain_data = chain_system.apply_chain(false)

			else:
				chain_data = chain_system.apply_chain(false)

		else:
			chain_data = chain_system.apply_chain(false)

	else:

		if item_manager.has_effective_item(
			"infinite_paradox"
		):

			print("\n♾️ INFINITE PARADOX ACTIVATED")
			print("CHAIN DOES NOT RESET")

			emit_signal(
				"activate_item_slot",
				"infinite_paradox"
			)

		chain_data = chain_system.apply_chain(true)

	print("[CHAIN DATA]")
	print("is_valid:", is_valid)
	print("chain_count:", chain_data.chain_count)
	print("chain_mult:", chain_data.chain_mult)
	print("delta_mult:", chain_data.delta_mult)
	

	# 👉 tính mult cuối (CHỈ 1 LẦN)
	var chain_mult_value = chain_data.chain_mult

	# =====================
	# HANDY SHORTCUT
	# =====================

	if item_manager.has_item("handy_shortcut"):

		if !item_manager.handy_shortcut_used:

			if chain_data.chain_count == 1:

				item_manager.handy_shortcut_used = true

				print("\n⚡ HANDY SHORTCUT ACTIVATED")
				print("CHAIN BEFORE:", chain_mult_value)

				emit_signal("activate_item_slot", "handy_shortcut")

				# 👇 skip chain 0
				chain_data.chain_count += 1

				chain_mult_value = pow(
					1.5,
					chain_data.chain_count - 1
				)

				chain_data.chain_mult = chain_mult_value

				# 👇 QUAN TRỌNG
				chain_system.chain_count += 1
				chain_system.chain_mult = chain_mult_value
				

				print("CHAIN AFTER:", chain_mult_value)
				
	var display_chain = max(
		chain_data["chain_count"] - 1,
		0
	)

	if display_chain > SaveManager.save_data["statistics"]["highest_chain"]:

		SaveManager.save_data["statistics"]["highest_chain"] = display_chain

	var final_mult = mult * chain_mult_value

	print("[FINAL CALC]")
	print("base_mult:", mult)
	print("chain_mult:", chain_mult_value)
	print("final_mult(before round):", final_mult)

	# 👇 floating text cho chain (x1.5)
	if chain_mult_value > 1.0 and is_valid:

		var chain_level = chain_data.chain_count - 1

		var chain_mult_str = format_float(chain_mult_value)

		var text = "Chain " + str(chain_level) + " (x" + chain_mult_str + " Mult)"

		emit_signal("show_floating_text", card, {
			"text": text,
			"type": "chain"
		})
		await wait_step()
		#await get_tree().create_timer(0.3).timeout

	var original_base_mult = mult

	# 👉 áp dụng mult cuối (ROUND TẠI ĐÂY)
	mult = int(round(final_mult))
	
	#mult *= int(round(final_mult))
	#mult *= int(round(final_mult))
	#mult *= int(round(final_mult))
	#mult *= int(round(final_mult))
	# =====================
	# FINAL ITEM MODIFY
	# =====================

	var relation_type = ""

	if !relations.is_empty():

		relation_type = relations[0].get("type", "")

	if is_valid and relation_type != "":
		SaveManager.track_relation(relation_type)

	item_manager.lone_word_valid = is_valid
	item_manager.lone_word_relation = relation_type

	# =====================
	# GOLDEN RATIO STACK FIRST
	# =====================

	if is_valid:

		if item_manager.has_item("golden_ratio"):

			item_manager.golden_ratio_bonus += 2

			print("\n⭐ GOLDEN RATIO STACK")
			print("NEW BONUS:", item_manager.golden_ratio_bonus)

	var final_data = item_manager.modify_final(
		point,
		mult,
		{
			"is_valid": is_valid,
			"card": card,
			"relation_type": relation_type,
			"word_level": card.data["level"],
			"is_synonym_glitch": false,
			"discard_used": max_discard - discard_left,
		}
	)

	point = final_data.point
	mult = final_data.mult
	
	for effect in final_data.effects:

		emit_signal("show_floating_text", card, {
			"text": get_item_effect_text(effect),
			"type": effect.type
		})

		var activate_id = effect.item_id

		# 👇 nếu là blueprint copy
		if effect.get("is_blueprint_copy", false):

			activate_id = "blueprint"

		emit_signal(
			"activate_item_slot",
			activate_id
		)
		await wait_step()
		
	# =====================
	# OVER HEAVEN STACK
	# =====================

	if is_valid and item_manager.treated_as_synonym:

		for inventory_item in item_manager.items:

			if inventory_item.get(
				"id",
				""
			) != "over_heaven":
				continue

			inventory_item["bonus_mult"] += 0.5

			print("\n🌌 OVER HEAVEN STACK")
			print(
				"NEW BONUS:",
				inventory_item["bonus_mult"]
			)

	#mult *= mult
	#mult *= mult
	#mult = int(mult)

	# 🔥 QUAN TRỌNG: update UI sau khi có mult cuối
	emit_signal("update_score_counting", get_state())

	await wait_step()

	var score_one = min(
		point * mult,
		MAX_SCORE
	)

	print("FINAL SCORE:", score_one)

	# =====================
	# FULL COMBO
	# =====================

	if (
		item_manager.has_item("full_combo")
		and item_manager.played_word_count == 5
		and item_manager.valid_word_count == 5
		and is_valid
	):

		print("\n✅ FULL COMBO ACTIVATED")

		for i in range(2):

			var extra_chain = chain_system.apply_chain(true)

			var extra_chain_mult = extra_chain.chain_mult

			var extra_final_mult = original_base_mult * extra_chain_mult

			var extra_mult = int(round(extra_final_mult))

			var extra_score = min(
				point * extra_mult,
				MAX_SCORE
			)

			print("\n🔥 FULL COMBO EXTRA HIT")
			print("CHAIN:", extra_chain.chain_count)
			print("MULT:", extra_chain_mult)
			print("EXTRA SCORE:", extra_score)

			emit_signal("show_floating_text", card, {
				"text": "Chain " + str(extra_chain.chain_count - 1)
					+ " (x" + format_float(extra_chain_mult) + " Mult)",
				"type": "chain"
			})

			emit_signal("activate_item_slot", "full_combo")

			await wait_step()

			result_score += extra_score

			emit_signal("update_score_counting", get_state())

			await wait_step()

	# =====================
	# MAGNETIC FORCE TRACK
	# =====================

	if is_valid:
		item_manager.last_relation_type = relation_type
	else:
		item_manager.last_relation_type = ""
			
	# =====================
	# LONE WORD
	# =====================

	if (
		item_manager.has_item("lone_word")
		and item_manager.played_word_count == 1
		and is_valid
		and 
		(
			relation_type == "synonym"
			or 
			item_manager.treated_as_synonym
		)
	):

		print("\n✅ LONE WORD ACTIVATED")
		print("TURN REFUNDED")

		add_turn(1)

		emit_signal("show_floating_text", card, {
			"text": "Refunded",
			"type": "special"
		})

		emit_signal("activate_item_slot", "lone_word")

		await wait_step()
	
	emit_signal("set_card_highlight", card, false, "")

	return score_one
	
func get_item_effect_text(effect):

	match effect.type:

		"add_point":
			return "+" + str(effect.value) + " Point"

		"add_mult":
			return "+" + str(effect.value) + " Mult"

		"mul_mult":
			return "x" + str(effect.value) + " Mult"

	return effect.type
	
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
			AudioManager.play_floating_text_score()

			return label + " (" + str(p) + " x" + str(m) + ")"

		"add_point":
			var value = step.value
			var source = step.get("source", "")

			if source == "level":
				return step["level"] + " (+" + str(value) + " Point)"
			else:
				return "+" + str(value) + " Point"

		"add_mult":
			var value = step.value
			var source = step.get("source", "")

			if source == "level":
				return step["level"] + " (+" + str(value) + " Mult)"
			else:
				return "+" + str(value) + " Mult"

		"mul_mult":
			return "x" + str(step.value) + " Mult"

		"chain":
			return "Chain x" + str(step.value)

		_:
			AudioManager.play_floating_text_score()
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
	
func add_turn(value: int):

	if reward_popup_open:

		pending_turn_bonus += value

		print(
			"[PENDING TURN BONUS]",
			pending_turn_bonus
		)

	else:

		turn += value

		print(
			"[INSTANT TURN BONUS]",
			turn
		)

	emit_signal("update_state_ui", get_state())	

func setup_round():

	item_manager.start_round()

	turn = max_turn + item_manager.get_round_turn_bonus()

	if pending_turn_bonus > 0:

		print(
			"\n[APPLY PENDING TURN BONUS]",
			pending_turn_bonus
		)

		turn += pending_turn_bonus

		pending_turn_bonus = 0

	print("\n🎯 FINAL TURN:", turn)

	discard_left = max_discard
	
func next_round():
	round += 1
	score -= target_score
	
	target_score = DifficultyManager.calculate_next_target(
		target_score,
		round
	)
	
	setup_round()
	SaveManager.save_current_run(
		build_round_save()
	)
	print("=== NEXT ROUND ===")
	
func continue_next_round():

	is_scoring = false

	result_score = 0

	score -= target_score

	round += 1
	
	AudioManager.play_next_round()
	
	if check_victory():
		return
	
	SaveManager.save_data["statistics"]["highest_round"] = max(
		SaveManager.save_data["statistics"]["highest_round"],
		round
	)


	target_score = DifficultyManager.calculate_next_target(
		target_score,
		round
	)
	
	setup_round()

	print("=== NEXT ROUND ===")

	emit_signal("clear_center_cards")

	current_word = word_db.get_random_word_exclude(current_word)

	draw_hand()
	
	SaveManager.save_current_run(
		build_round_save()
	)
	

	
func show_reward_popup():

	reward_popup_open = true
	is_scoring = true

	var popup_scene = preload(
		"res://scenes/Items/item_reward_popup.tscn"
	)

	var popup = popup_scene.instantiate()

	var ui = get_tree().current_scene.get_node_or_null("UI")

	if ui == null:
		ui = get_tree().current_scene

	ui.add_child(popup)

	var owned_ids := []

	for item in item_manager.get_items():

		owned_ids.append(
			item.get("id", "")
		)

	var rewards = ItemDB.get_random_rewards(
		3,
		owned_ids
	)

	popup.setup(
		rewards,
		reward_reroll_left,
	)

	popup.reward_selected.connect(
		_on_reward_selected
	)

	popup.reward_skipped.connect(
		_on_reward_skipped
	)

	popup.reward_rerolled.connect(
		func():

			if reward_reroll_left <= 0:
				return

			reward_reroll_left -= 1

			print("\n🔄 REROLL USED")
			print("LEFT:", reward_reroll_left)

			# =====================
			# BUILD EXCLUDED
			# =====================

			var excluded = owned_ids.duplicate()

			for item in popup.current_rewards:

				excluded.append(
					item.get("id", "")
				)

			# =====================
			# NEW REWARDS
			# =====================

			var new_rewards = ItemDB.get_random_rewards(
				3,
				excluded
			)

			# =====================
			# REFRESH POPUP
			# =====================

			popup.setup(
				new_rewards,
				reward_reroll_left
			)
	)
	
func _on_reward_selected(item_data):

	reward_popup_open = false

	var item_id = item_data["id"]

	# =====================
	# TRACK ONLY ONCE PER RUN
	# =====================

	if !run_used_items.has(item_id):

		run_used_items[item_id] = true

		SaveManager.track_item_pick(item_id)

	if item_manager.get_items().size() < 5:

		item_manager.add_item(item_id)

		SaveManager.unlock_item(item_id)

		emit_signal("update_item_ui")

	else:
		print("ITEM INVENTORY FULL - reward skipped")

	consume_reward_round()
	
func _on_reward_skipped():

	print("\n⏭️ REWARD SKIPPED")

	reward_popup_open = false

	consume_reward_round()
	
func consume_reward_round():

	score -= target_score
	round += 1
	
	SaveManager.save_data["statistics"]["highest_round"] = max(
		SaveManager.save_data["statistics"]["highest_round"],
		round
	)


	target_score = DifficultyManager.calculate_next_target(
		target_score,
		round
	)

	setup_round()

	emit_signal("update_state_ui", get_state())

	if score >= target_score:
		show_reward_popup()
		return

	current_word = word_db.get_random_word_exclude(current_word)
	draw_hand()
	
	SaveManager.save_current_run(
		build_round_save()
	)

	is_scoring = false
	
func end_game():

	print("Game Over - Final Score:", score)

	SaveManager.clear_current_run()

	show_end_screen(false)
	
func show_end_screen(victory: bool):

	var final_score = int(score)
	var final_round = int(round)

	var scene = preload(
		"res://scenes/Screen/game_over.tscn"
	)

	var result = scene.instantiate()

	result.setup(
		victory,
		final_score,
		final_round
	)

	var old_scene = get_tree().current_scene

	get_tree().root.add_child(result)

	get_tree().current_scene = result

	reset_state()

	old_scene.call_deferred("queue_free")
	
func reset_state():

	score = 0
	round = 1
	target_score = DifficultyManager.get_base_target()
	turn = 5
	max_turn = 5
	mult = 0
	point = 0
	result_score = 0
	run_used_items.clear()

	current_word = null

	discard_left = max_discard

	reward_reroll_left = max_reward_reroll

	is_scoring = false
	reward_popup_open = false
	pending_turn_bonus = 0

	item_manager.reset_items()

	hand.clear()
	bag.clear()
	
	emit_signal("update_item_ui")

	emit_signal(
		"update_state_ui",
		get_state()
	)
	
func apply_game_speed():

	var speed = SaveManager.get_setting(
		"game_speed",
		5
	)

	speed = clamp(speed, 1, 5)

	step_delay = 0.6 - (speed * 0.1)

	print(
		"[GAME SPEED]",
		speed,
		" STEP DELAY:",
		step_delay
	)
	
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
	
func build_round_save():

	var hand_words = []

	for word in hand:
		hand_words.append(word["text"])

	var bag_words = []

	for word in bag:
		bag_words.append(word["text"])

	var item_data = []

	for item in item_manager.get_items():

		item_data.append(item.duplicate(true))

	return {
		"round": round,
		"score": score,
		"target_score": target_score,
		"turn": turn,
		"max_turn": max_turn,

		"discard_left": discard_left,

		"reward_reroll_left":
			reward_reroll_left,

		"pending_turn_bonus":
			pending_turn_bonus,

		"current_word":
			current_word["text"],

		"hand":
			hand_words,

		"bag":
			bag_words,

		"items":
			item_data,

		"run_used_items":
			run_used_items.duplicate(true),
			
		"difficulty":
			DifficultyManager.current_difficulty,
	}
	
func clear_round():

	# round kế tiếp
	var next_round_number = round + 1

	# =====================
	# VICTORY CHECK
	# =====================

	if DifficultyManager.is_victory(
		next_round_number
	):

		print("VICTORY")

		DifficultyManager.mark_completed()

		SaveManager.clear_current_run()

		show_end_screen(true)

		return

	# =====================
	# NORMAL REWARD
	# =====================

	emit_signal("clear_center_cards")

	show_reward_popup()
	
func load_current_run():

	var run = SaveManager.save_data[
		"current_run"
	]

	if !run["active"]:
		return false

	var data = run["round_state"]
	
	DifficultyManager.current_difficulty = data.get(
		"difficulty",
		"normal"
	)

	round = data.get("round", 1)

	score = data.get("score", 0)

	target_score = data.get(
		"target_score",
		500
	)

	turn = data.get("turn", 5)
	
	max_turn = data.get(
		"max_turn",
		5
	)

	discard_left = data.get(
		"discard_left",
		max_discard
	)

	reward_reroll_left = data.get(
		"reward_reroll_left",
		max_reward_reroll
	)

	pending_turn_bonus = data.get(
		"pending_turn_bonus",
		0
	)

	# =====================
	# CURRENT WORD
	# =====================

	var current_word_id = data.get(
		"current_word",
		""
	)

	if WordDB.WORDS.has(current_word_id):

		current_word = WordDB.WORDS[
			current_word_id
		]

	# =====================
	# HAND
	# =====================

	hand.clear()

	for word_id in data.get("hand", []):

		if WordDB.WORDS.has(word_id):

			hand.append(
				WordDB.WORDS[word_id]
			)

	# =====================
	# BAG
	# =====================

	bag.clear()

	for word_id in data.get("bag", []):

		if WordDB.WORDS.has(word_id):

			bag.append(
				WordDB.WORDS[word_id]
			)

	# =====================
	# ITEMS
	# =====================

	item_manager.reset_items()

	for item_data in data.get("items", []):

		item_manager.items.append(
			item_data.duplicate(true)
		)

	# =====================
	# RUN USED ITEMS
	# =====================

	run_used_items = data.get(
		"run_used_items",
		{}
	).duplicate(true)

	# =====================
	# IMPORTANT
	# =====================

	is_scoring = false

	reward_popup_open = false

	# =====================
	# UI REFRESH
	# =====================

	emit_signal("update_item_ui")

	emit_signal(
		"update_state_ui",
		get_state()
	)

	print("RUN LOADED")
	print("ROUND:", round)
	print("HAND:", hand)
	print("CURRENT:", current_word)

	return true
	
func check_victory():

	if DifficultyManager.is_victory(round):

		print("VICTORY")

		DifficultyManager.mark_completed()

		SaveManager.clear_current_run()

		show_end_screen(true)

		return true

	return false
	
func debug_add_item(item_id: String):

	if item_manager.get_items().size() >= 5:
		print("ITEM INVENTORY FULL")
		return

	item_manager.add_item(item_id)

	emit_signal("update_item_ui")
	
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
