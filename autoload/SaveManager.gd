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
			"total_runs": 0,
			"total_words_played": 0
		},

		"settings": {
			"music_volume": 100,
			"sfx_volume": 100
		},

		"word_tracking": {},

		"collection": {
			"items": [],
			"words": []
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

	else:

		save_data = create_default_save()
		save_game()
		
	print("LOAD GAME CALLED")

func reset_save():

	save_data = create_default_save()
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
