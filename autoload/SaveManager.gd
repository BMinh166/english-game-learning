extends Node

const SAVE_PATH = "user://save.json"

var save_data = {}

func init_save():
	load_game()
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

		"settings": {
			"music_volume": 100,
			"sfx_volume": 100
		},

		"word_tracking": {},

		"collection": {
			"items": [],
			"words": []
		},
		
		"current_run": {
			"active": false,
			"round_state": {}
		}
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
			"items": [],
			"words": []
		}

	save_game()

func reset_save():

	save_data = create_default_save()
	save_game()
	
func unlock_item(item_id):

	var items = save_data["collection"]["items"]

	if not items.has(item_id):

		items.append(item_id)

		save_game()
		
func unlock_word(word_id):

	var words = save_data["collection"]["words"]

	if not words.has(word_id):

		words.append(word_id)

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
