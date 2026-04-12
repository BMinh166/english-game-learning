extends Node
class_name GenerateWords



static func generate(word_db, current_word, hand_size: int, bag_size: int) -> Dictionary:
	var pool = word_db.words.duplicate()
	
	# loại current word
	pool.erase(current_word)
	
	pool.shuffle()
	
	var actual_hand_size = min(hand_size, pool.size())
	var hand = pool.slice(0, actual_hand_size)
	
	var remaining = pool.size() - actual_hand_size
	var actual_bag_size = min(bag_size, remaining)
	var bag = pool.slice(actual_hand_size, actual_hand_size + actual_bag_size)
	
	return {
		"hand": hand,
		"bag": bag
	}
