extends Node

var words = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_words()

func load_words():
	var file = FileAccess.open("res://data/words.json", FileAccess.READ)
	var text = file.get_as_text()
	words = JSON.parse_string(text)

func get_random_word():
	if words.is_empty():
		print("ERROR: words empty")
		return null
	return words.pick_random()

func get_random_word_exclude(exclude_word):
	var filtered = []

	for w in words:
		if exclude_word == null or w.text != exclude_word.text:
			filtered.append(w)

	if filtered.is_empty():
		print("ERROR: no word after exclude")
		return null

	return filtered.pick_random()
