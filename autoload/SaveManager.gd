extends Node

const SAVE_PATH = "user://save.json"

var save_data = {}

func init_save():

	load_game()

	# =====================
	# LOAD LANGUAGE
	# =====================

	var lang = save_data["settings"].get(
		"language",
		"en"
	)

	Localization.set_language(lang)

	print(save_data)

func create_default_save():

	return {
		"version": 1,

		"statistics": {

			"highest_score": 0,
			"highest_round": 0,
			"highest_chain": 0,

			"total_runs": 0,
			"total_play_time": 0,

			"total_words_played": 0,
			"total_correct": 0,
			"total_wrong": 0,

			"most_used_item": "",
			"most_used_relation": "",
			"most_correct_word": "",
			"most_wrong_word": "",
			"most_seen_word": ""
		},
		
		"completed_difficulties": {

			"easy": false,
			"normal": false,
			"hard": false
		},

		"settings": {

			"language": "en",

			"master_volume": 100,
			"music_volume": 100,
			"sfx_volume": 100,

			"game_speed": 3 
		},

		"word_tracking": {},

		"collection": {
			"items": []
		},
		
		"current_run": {
			"active": false,
			"round_state": {}
		},
		
		"relation_usage": {},
		
		"item_usage": {},
	}

func save_game():

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file == null:
		print("Failed to save game")
		return

	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()
	
	print("SAVE GAME CALLED")

func load_game():

	if not FileAccess.file_exists(SAVE_PATH):

		save_data = create_default_save()
		save_game()
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if file == null:
		print("Failed to load save")
		return

	var content = file.get_as_text()
	file.close()

	var json = JSON.new()

	var result = json.parse(content)

	if result == OK and json.data.has("statistics"):

		save_data = json.data

		validate_save()

	else:

		save_data = create_default_save()
		save_game()
		
	print("LOAD GAME CALLED")

func validate_save():

	if !save_data.has("current_run"):

		save_data["current_run"] = {
			"active": false,
			"round_state": {}
		}

	if !save_data.has("collection"):

		save_data["collection"] = {
			"items": []
		}
		
	if !save_data.has("relation_usage"):

		save_data["relation_usage"] = {}

	if !save_data.has("item_usage"):

		save_data["item_usage"] = {}
		
	if !save_data.has("completed_difficulties"):

		save_data["completed_difficulties"] = {
			"easy": false,
			"normal": false,
			"hard": false
		}

	# =====================
	# STATISTICS VALIDATE
	# =====================

	if !save_data.has("statistics"):

		save_data["statistics"] = {}

	var default_stats = create_default_save()["statistics"]

	for key in default_stats.keys():

		if !save_data["statistics"].has(key):

			save_data["statistics"][key] = default_stats[key]
			
	# =====================
	# SETTINGS VALIDATE
	# =====================

	if !save_data.has("settings"):

		save_data["settings"] = {}

	var default_settings = create_default_save()["settings"]

	for key in default_settings.keys():

		if !save_data["settings"].has(key):

			save_data["settings"][key] = default_settings[key]

	save_game()

func reset_save():

	if FileAccess.file_exists(SAVE_PATH):

		DirAccess.remove_absolute(SAVE_PATH)

	save_data = create_default_save()

	save_game()
	
func unlock_item(item_id):

	var items = save_data["collection"]["items"]

	if not items.has(item_id):

		items.append(item_id)

		save_game()

func get_word_data(word):

	var tracking = save_data["word_tracking"]

	if not tracking.has(word):

		tracking[word] = {
			"seen": 0,
			"correct": 0,
			"wrong": 0
		}

	return tracking[word]
	
func save_current_run(state):

	save_data["current_run"] = {
		"active": true,
		"round_state": state
	}

	save_game()
	
func clear_current_run():

	save_data["current_run"] = {
		"active": false,
		"round_state": {}
	}

	save_game()
	
func get_statistics():

	return save_data["statistics"]
	
func get_most_seen_word():

	var tracking = save_data["word_tracking"]

	var best_word = ""
	var best_value = 0

	for word_id in tracking.keys():

		var value = tracking[word_id].get("seen", 0)

		if value > best_value:

			best_value = value
			best_word = word_id

	if best_value <= 0:
		return ""

	return best_word


func get_most_correct_word():

	var tracking = save_data["word_tracking"]

	var best_word = ""
	var best_value = 0

	for word_id in tracking.keys():

		var value = tracking[word_id].get("correct", 0)

		if value > best_value:

			best_value = value
			best_word = word_id

	if best_value <= 0:
		return ""

	return best_word

func track_relation(relation_type):

	if !save_data.has("relation_usage"):

		save_data["relation_usage"] = {}

	var tracking = save_data["relation_usage"]

	if !tracking.has(relation_type):

		tracking[relation_type] = 0

	tracking[relation_type] += 1

	update_most_used_relation()


func update_most_used_relation():

	if !save_data.has("relation_usage"):
		return

	var tracking = save_data["relation_usage"]

	var best_relation = ""
	var best_value = -1

	for relation_type in tracking.keys():

		var value = tracking[relation_type]

		if value > best_value:

			best_value = value
			best_relation = relation_type

	save_data["statistics"]["most_used_relation"] = best_relation


func track_item_use(item_id):

	if !save_data.has("item_usage"):

		save_data["item_usage"] = {}

	var tracking = save_data["item_usage"]

	if !tracking.has(item_id):

		tracking[item_id] = 0

	tracking[item_id] += 1

	update_most_used_item()


func update_most_used_item():

	if !save_data.has("item_usage"):
		return

	var tracking = save_data["item_usage"]

	var best_item = ""
	var best_value = -1

	for item_id in tracking.keys():

		var value = tracking[item_id]

		if value > best_value:

			best_value = value
			best_item = item_id

	save_data["statistics"]["most_used_item"] = best_item

func get_most_wrong_word():

	var tracking = save_data["word_tracking"]

	var best_word = ""
	var best_value = 0

	for word_id in tracking.keys():

		var value = tracking[word_id].get("wrong", 0)

		if value > best_value:

			best_value = value
			best_word = word_id

	if best_value <= 0:
		return ""

	return best_word

func has_active_run() -> bool:

	return save_data.get(
		"current_run",
		{}
	).get(
		"active",
		false
	)

func get_setting(key, default_value = null):

	return save_data["settings"].get(
		key,
		default_value
	)


func set_setting(key, value):

	save_data["settings"][key] = value

	save_game()
