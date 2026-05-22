extends Node

var current_difficulty := "normal"

var DIFFICULTY_DATA = {

	"easy": {
		"max_round": 15,		#default: 15
		"base_target": 400,

		"normal_scale": 1.45,	#default: 1.4
		"spike_scale": 1.7, 	#default: 1.6
	},

	"normal": {
		"max_round": 18,		#default: 18
		"base_target": 550,

		"normal_scale": 1.6,	#default: 1.5
		"spike_scale": 1.9,		#default: 1.8
	},

	"hard": {
		"max_round": 21,	#default: 21
		"base_target": 650,

		"normal_scale": 1.7,	#default: 1.6
		"spike_scale": 2.15,		#default: 2.0
	}
}

func get_data():

	return DIFFICULTY_DATA.get(
		current_difficulty,
		DIFFICULTY_DATA["normal"]
	)

func get_base_target():

	return get_data()["base_target"]
	
func calculate_next_target(
	current_target,
	current_round
):

	var data = get_data()

	var scale = data["normal_scale"]

	# spike mỗi 3 round
	if current_round % 3 == 0:

		scale = data["spike_scale"]

	return int(current_target * scale)
	
func get_max_round():

	return get_data()["max_round"]
	
func is_victory(round):

	return round > get_max_round()
	
func is_completed(diff):

	return SaveManager.save_data[
		"completed_difficulties"
	].get(diff, false)
	
func mark_completed():

	SaveManager.save_data[
		"completed_difficulties"
	][current_difficulty] = true

	SaveManager.save_game()
