extends Node

var words = []

var WORDS := {}

func _ready():
	load_words()

func load_words():

	var file = FileAccess.open(
		"res://data/words.json",
		FileAccess.READ
	)

	if file == null:
		push_error("Cannot open words.json")
		return

	var text = file.get_as_text()

	var parsed = JSON.parse_string(text)
	
	if parsed == null:
		push_error("Invalid JSON")
		return

	if parsed == null:
		push_error("Invalid words.json")
		return

	words = parsed

	WORDS.clear()

	for word in words:

		if word.has("text"):

			WORDS[word["text"]] = word

func get_random_word():
	if words.is_empty():
		print("ERROR: words empty")
		return null
	return words.pick_random()

func get_random_word_exclude(exclude_word):
	var filtered = []

	for w in words:
		if exclude_word == null or w["text"] != exclude_word["text"]:
			filtered.append(w)

	if filtered.is_empty():
		print("ERROR: no word after exclude")
		return null

	return filtered.pick_random()
