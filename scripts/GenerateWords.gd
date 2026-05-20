extends Node
class_name GenerateWords

const DIFFICULTY_PRESET = {
	"easy": {
		"relation_cap": 30,
		"tracking_cap": 35
	},

	"normal": {
		"relation_cap": 24,
		"tracking_cap": 30
	},

	"hard": {
		"relation_cap": 18,
		"tracking_cap": 20
	}
}

const LEVEL_SCORE = {
	"A1": 1,
	"A2": 2,
	"B1": 3,
	"B2": 4,
	"C1": 5,
	"C2": 6
}

static func generate(
	word_db,
	current_word,
	hand_size: int,
	bag_size: int,
	difficulty := "normal"
) -> Dictionary:

	var preset = DIFFICULTY_PRESET[difficulty]

	var relation_cap = preset["relation_cap"]
	var tracking_cap = preset["tracking_cap"]

	# =====================
	# MASTER POOL
	# =====================

	var master_pool = word_db.words.duplicate()
	master_pool.erase(current_word)

	var candidate_pool = []

	# =====================
	# RELATION WORDS
	# =====================

	var relation_types = [
		"synonym",
		"antonym",
		"degree",
		"family",
		"pos"
	]

	var relation_count = 0

	for type in relation_types:

		if relation_count >= relation_cap:
			break

		var related_words = Relation.get_relation_words(
			current_word,
			type,
			master_pool
		)

		related_words.shuffle()

		var take_count = min(
			5,
			related_words.size(),
			relation_cap - relation_count
		)

		for i in range(take_count):

			var word = related_words[i]

			candidate_pool.append(word)
			
			print(
				"[RELATION]",
				type,
				": ",
				word.text
			)
			
			master_pool.erase(word)

			relation_count += 1

	# =====================
	# TRACKING WORDS
	# =====================

	var tracking_words = []

	for word in master_pool:

		var data = SaveManager.get_word_data(word.text)

		var score = 0

		# wrong bonus
		score += data["wrong"] * 3

		# correct penalty
		score -= data["correct"]

		# unseen bonus
		if data["seen"] == 0:
			score += 2

		# level bonus
		score += LEVEL_SCORE.get(word.level, 0)

		if score <= 0:
			continue

		tracking_words.append({
			"word": word,
			"score": score
		})

	# sort high score first
	tracking_words.sort_custom(
		func(a, b):
			return a["score"] > b["score"]
	)

	# take top 40%
	var tracking_window_size = max(
		1,
		int(tracking_words.size() * 0.4)
	)

	var tracking_window = tracking_words.slice(
		0,
		tracking_window_size
	)

	# randomize inside window
	tracking_window.shuffle()

	# add random tracking words
	var tracking_added = 0

	for entry in tracking_window:

		if tracking_added >= tracking_cap:
			break

		candidate_pool.append(entry["word"])

		print(
			"[TRACKING]",
			entry["word"].text,
			" SCORE:",
			entry["score"]
		)

		tracking_added += 1

	# remove duplicate
	for word in candidate_pool:
		master_pool.erase(word)

	# =====================
	# RANDOM FILL
	# =====================

	master_pool.shuffle()

	var remain = 100 - candidate_pool.size()

	candidate_pool.append_array(
		master_pool.slice(0, remain)
	)

	# =====================
	# FINAL RNG
	# =====================

	print("")
	print("========== GENERATE DEBUG ==========")
	print("Difficulty: ", difficulty)

	print("")
	print("Current Word: ", current_word.text)

	print("")
	print("Relation Count: ", relation_count)
	print("Tracking Count: ", tracking_added)

	print("")
	print("Candidate Pool Size: ", candidate_pool.size())

	print("")
	print("Hand Size: ", hand_size)
	print("Bag Size: ", bag_size)

	print("====================================")
	print("")

	candidate_pool.shuffle()

	var total_needed = hand_size + bag_size

	var final_pool = candidate_pool.slice(
		0,
		min(total_needed, candidate_pool.size())
	)

	var hand = final_pool.slice(0, hand_size)
	
	print("")
	print("FINAL HAND:")

	for word in hand:
		print(word.text)

	var bag = final_pool.slice(
		hand_size,
		final_pool.size()
	)
	
	print("")
	print("BAG SAMPLE:")

	for i in range(min(10, bag.size())):
		print(bag[i].text)

	return {
		"hand": hand,
		"bag": bag
	}
