extends Node

var current_language := "en"

# =====================
# UI TEXT
# =====================

var UI_TEXT = {

	"en": {

		"meaning": "Meaning",
		"synonym": "Synonym",
		"antonym": "Antonym",
		"degree": "Degree",
		"family": "Family",
		"pos": "Part of Speech",

		"level": "Level",

		"seen": "Seen",
		"correct": "Correct",
		"wrong": "Wrong",
		"accuracy": "Accuracy",

		"none": "None",
		
		"language": "Language",
		"master_volume": "Master Volume",
		"music_volume": "Music Volume",
		"sfx_volume": "SFX Volume",
		"game_speed": "Game Speed",
		
		"collection": "Collection",
		"words": "Words",
		"items": "Items",
		"stats": "Stats",
		"delete_data": "Delete Data",
		"relations": "Relations",
		
		"back": "Back",
		"yes": "Yes",
		"cancel": "Cancel",
		
		"delete_confirm": "All save data will be permanently deleted.\nThis action cannot be undone.\n\nAre you sure?",
		
		"play": "Play",
		"settings": "Settings",
		"quit": "Quit",
		
		"highest_score": "Highest Score",
		"highest_round": "Highest Round",
		"highest_chain": "Highest Chain",

		"total_runs": "Total Runs",
		"play_time": "Play Time",

		"words_played": "Words Played",

		"most_seen_word": "Most Seen Word",
		"most_correct_word": "Most Correct Word",
		"most_wrong_word": "Most Wrong Word",

		"most_used_relation": "Most Used Relation",
		"most_used_item": "Most Used Item",

		"items_discovered": "Items",
		"words_discovered": "Words",
		
		"new_game": "New Game",
		"main_menu": "Main Menu",
		
		"turn": "Turn",
		"round": "Round",
		"discard_left": "Discard Left",
		"discard": "Discard",
		
		"undiscovered_item": "Undiscovered Item",
		
		"bag": "Bag",
		
		"continue": "Continue",
		"difficulty": "Difficulty",

		"easy_desc": "Relaxed gameplay",
		"normal_desc": "Standard gameplay",
		"hard_desc": "More challenging gameplay",
		
	},

	"vi": {

		"meaning": "Nghĩa",
		"synonym": "Đồng nghĩa",
		"antonym": "Trái nghĩa",
		"degree": "Mức độ",
		"family": "Họ",
		"pos": "Loại từ",

		"level": "Cấp độ",

		"seen": "Đã gặp",
		"correct": "Đúng",
		"wrong": "Sai",
		"accuracy": "Tỉ lệ đúng",

		"none": "Không có",
		
		"language": "Ngôn ngữ",
		"master_volume": "Âm lượng tổng",
		"music_volume": "Âm nhạc",
		"sfx_volume": "Hiệu ứng âm thanh",
		"game_speed": "Tốc độ game",
		
		"collection": "Bộ sưu tập",
		"words": "Từ vựng",
		"items": "Vật phẩm",
		"stats": "Thống kê",
		"delete_data": "Xóa dữ liệu",
		"relations": "Quan hệ từ",
		
		"back": "Quay lại",
		"yes": "Có",
		"cancel": "Hủy",
		
		"delete_confirm": "Tất cả dữ liệu sẽ bị xóa vĩnh viễn.\nKhông thể hoàn tác thao tác này.\n\nBạn có chắn chắn không?",
		
		"play": "Chơi",
		"settings": "Cài đặt",
		"quit": "Thoát",
		
		"highest_score": "Điểm cao nhất",
		"highest_round": "Round cao nhất",
		"highest_chain": "Chain cao nhất",

		"total_runs": "Tổng lượt chơi",
		"play_time": "Thời gian chơi",

		"words_played": "Từ đã chơi",

		"most_seen_word": "Từ gặp nhiều nhất",
		"most_correct_word": "Từ đúng nhiều nhất",
		"most_wrong_word": "Từ sai nhiều nhất",

		"most_used_relation": "Relation dùng nhiều nhất",
		"most_used_item": "Item dùng nhiều nhất",

		"items_discovered": "Vật phẩm",
		"words_discovered": "Từ vựng",
		
		"new_game": "Chơi mới",
		"main_menu": "Màn hình chính",
		
		"turn": "Lượt",
		"round": "Vòng",
		"discard_left": "Lượt bỏ",
		"discard": "Bỏ",
		
		"undiscovered_item": "Vật phẩm chưa khám phá",
		
		"bag": "Túi đồ",
		
		"continue": "Tiếp tục",
		"difficulty": "Độ khó",

		"easy_desc": "Lối chơi thư giãn",
		"normal_desc": "Lối chơi tiêu chuẩn",
		"hard_desc": "Thử thách hơn",
	}
}

# =====================
# RELATION TEXT
# =====================

var RELATION_TEXT = {

	"en": {

		"synonym": "Synonym",
		"antonym": "Antonym",
		"degree": "Degree",
		"family": "Family",
		"pos": "Part of Speech"
	},

	"vi": {

		"synonym": "Đồng nghĩa",
		"antonym": "Trái nghĩa",
		"degree": "Mức độ",
		"family": "Họ",
		"pos": "Loại từ"
	}
}

# =====================
# POS TEXT
# =====================

var POS_TEXT = {

	"en": {

		"noun": "Noun",
		"verb": "Verb",
		"adj": "Adjective",
		"adv": "Adverb"
	},

	"vi": {

		"noun": "Danh từ",
		"verb": "Động từ",
		"adj": "Tính từ",
		"adv": "Trạng từ"
	}
}

# =====================
# RARITY TEXT
# =====================

var RARITY_TEXT = {

	"en": {

		"common": "Common",
		"uncommon": "Uncommon",
		"rare": "Rare",
		"legendary": "Legendary"
	},

	"vi": {

		"common": "Thường",
		"uncommon": "Hiếm",
		"rare": "Quý",
		"legendary": "Huyền thoại"
	}
}

# =====================
# ITEM TEXT
# =====================

var ITEM_TEXT = {

	"en": {

		"synonym_codex_desc":
			"Synonym relations gain +10 Point",

		"wildcard_desc":
			"Gain +1 Mult each word",

		"cappuccino_desc":
			"B1/B2 level words gain +15 Point",

		"intensifier_desc":
			"First Degree relation each turn gains +3 Mult",

		"extra_caffeine_desc":
			"First valid word each turn gains +25 Point",

		"handy_shortcut_desc":
			"First chain bonus applies instantly",

		"family_guide_desc":
			"Family relations gain +20 Point",

		"phantom_hand_desc":
			"First fail each turn does not reset chain",

		"language_glitch_desc":
			"Antonym also counts as Synonym",

		"golden_ratio_desc":
			"Valid words permanently gain +2 Point",

		"scholars_thesis_desc":
			"C1/C2 level words gain +2 Mult",

		"yin_yang_desc":
			"Antonym relations gain +3 Mult",

		"magnetic_force_desc":
			"Same consecutive relation gains +40 Point",

		"future_debt_desc":
			"First valid word gains +45 Point per Discard used",

		"full_combo_desc":
			"If all 5 played words are valid, the final word continues the chain two more",

		"lone_word_desc":
			"Playing single Synonym word costs no Turn",

		"blueprint_desc":
			"Click this item, then choose another item to copy its effect",

		"yojigen_pocket_desc":
			"Gain bonus Turns each round equal to half total rarity value of your other items",

		"over_heaven_desc":
			"Each Synonym gain x2 Final Mult and permanently increases it by +0.5",

		"infinite_paradox_desc":
			"Chain never ends unless you fail"
	},

	"vi": {

		"synonym_codex_desc":
			"Từ Đồng Nghĩa nhận +10 Điểm",

		"wildcard_desc":
			"Mỗi từ nhận +1 Số nhân",

		"cappuccino_desc":
			"Từ cấp độ B1/B2 nhận +15 Điểm",

		"intensifier_desc":
			"Từ Mức Độ đầu tiên mỗi lượt nhận +3 Số nhân",

		"extra_caffeine_desc":
			"Từ hợp lệ đầu tiên mỗi lượt nhận +25 Điểm",

		"handy_shortcut_desc":
			"Chain đầu tiên kích hoạt ngay lập tức",

		"family_guide_desc":
			"Từ Quan hệ Họ từ nhận +20 Điểm",

		"phantom_hand_desc":
			"Fail đầu tiên mỗi lượt sẽ không mất Chain",

		"language_glitch_desc":
			"Trái Nghĩa cũng được tính là Đồng Nghĩa",

		"golden_ratio_desc":
			"Từ hợp lệ nhận vĩnh viễn +2 Điểm",

		"scholars_thesis_desc":
			"Từ cấp độ C1/C2 nhận +2 Mult",

		"yin_yang_desc":
			"Từ Trái Nghĩa nhận +3 Mult",

		"magnetic_force_desc":
			"Hai từ có Quan hệ liên tiếp giống nhau nhận +40 Điểm",

		"future_debt_desc":
			"Từ hợp lệ đầu tiên nhận +45 Điểm cho mỗi Lượt Bỏ đã dùng",

		"full_combo_desc":
			"Nếu cả 5 từ hợp lệ, từ cuối cùng sẽ tiếp tục Chain thêm 2 lần nữa",

		"lone_word_desc":
			"Chơi 1 từ Đồng Nghĩa sẽ không tốn Lượt",

		"blueprint_desc":
			"Sử dụng vật phẩm này, chọn vào vật phẩm khác để sao chép hiệu ứng của nó",

		"yojigen_pocket_desc":
			"Nhận thêm Lượt bằng một nửa giả trị bán của các item khác",

		"over_heaven_desc":
			"Từ Đồng Nghĩa nhận x2 Số nhân và sẽ tăng vĩnh viễn giá trị đó lên +0.5",

		"infinite_paradox_desc":
			"Chain không bao giờ kết thúc nếu không Fail"
	}
}

# =====================
# STATUS TEXT
# =====================

var STATUS_TEXT = {

	"en": {

		"ready": "Ready",

		"used_turn": "Used",

		"no_copy": "No Copy",

		"copying": "Copying",

		"bonus_point": "Bonus",

		"bonus_turn": "Turns",

		"bonus_mult": "Mult"
	},

	"vi": {

		"ready": "Sẵn sàng",

		"used_turn": "Đã dùng",

		"no_copy": "Chưa copy",

		"copying": "Đang copy",

		"bonus_point": "Điểm",

		"bonus_turn": "Lượt",

		"bonus_mult": "Số nhân"
	}
}

# =====================
# GROUP TEXT
# =====================

var GROUP_TEXT = {

	"en": {

		"age_current": "Current Age",
		"age_new": "New Age",
		"age_old": "Old Age",

		"cleanliness_clean": "Clean",
		"cleanliness_dirty": "Dirty",
		"cleanliness_normal": "Normal Cleanliness",

		"complexity_complex": "Complex",
		"complexity_simple": "Simple",

		"density_dense": "Dense",
		"density_medium": "Medium Density",
		"density_sparse": "Sparse",

		"depth_deep": "Deep",
		"depth_medium": "Medium Depth",
		"depth_shallow": "Shallow",

		"emotion_general": "Neutral Emotion",
		"emotion_negative": "Negative Emotion",
		"emotion_positive": "Positive Emotion",

		"flexibility_balanced": "Balanced Flexibility",
		"flexibility_flexible": "Flexible",
		"flexibility_rigid": "Rigid",

		"frequency_frequent": "Frequent",
		"frequency_medium": "Moderate Frequency",
		"frequency_rare": "Rare",

		"fullness_empty": "Empty",
		"fullness_full": "Full",
		"fullness_partial": "Partially Full",

		"hardness_hard": "Hard",
		"hardness_medium": "Medium Hardness",
		"hardness_soft": "Soft",

		"height_medium": "Medium Height",
		"height_short": "Short",
		"height_tall": "Tall",

		"intelligence_high": "High Intelligence",
		"intelligence_low": "Low Intelligence",

		"intensity_high": "High Intensity",
		"intensity_low": "Low Intensity",

		"length_long": "Long",
		"length_medium": "Medium Length",
		"length_short": "Short",

		"light_bright": "Bright",
		"light_dark": "Dark",
		"light_medium": "Moderate Light",

		"moisture_damp": "Damp",
		"moisture_dry": "Dry",
		"moisture_wet": "Wet",

		"quality_general": "General Quality",
		"quality_good": "Good Quality",
		"quality_poor": "Poor Quality",

		"quantity_few": "Few",
		"quantity_many": "Many",
		"quantity_some": "Some Quantity",

		"safety_danger": "Dangerous",
		"safety_risky": "Risky",
		"safety_safe": "Safe",

		"size_big": "Large Size",
		"size_medium": "Medium Size",
		"size_small": "Small Size",

		"sound_loud": "Loud",
		"sound_medium": "Moderate Sound",
		"sound_quiet": "Quiet",

		"speed_fast": "Fast Speed",
		"speed_medium": "Medium Speed",
		"speed_slow": "Slow Speed",

		"strength_normal": "Normal Strength",
		"strength_strong": "Strong",
		"strength_weak": "Weak",

		"temperature_cold": "Cold",
		"temperature_hot": "Hot",
		"temperature_warm": "Warm",

		"weight_heavy": "Heavy",
		"weight_light": "Light",
		"weight_medium": "Medium Weight",

		"width_medium": "Medium Width",
		"width_narrow": "Narrow",
		"width_wide": "Wide"
	},

	"vi": {

		"age_current": "Tuổi hiện tại",
		"age_new": "Mới",
		"age_old": "Cũ",

		"cleanliness_clean": "Sạch sẽ",
		"cleanliness_dirty": "Bẩn",
		"cleanliness_normal": "Bình thường",

		"complexity_complex": "Phức tạp",
		"complexity_simple": "Đơn giản",

		"density_dense": "Dày đặc",
		"density_medium": "Mật độ trung bình",
		"density_sparse": "Thưa thớt",

		"depth_deep": "Sâu",
		"depth_medium": "Độ sâu trung bình",
		"depth_shallow": "Nông",

		"emotion_general": "Cảm xúc trung tính",
		"emotion_negative": "Cảm xúc tiêu cực",
		"emotion_positive": "Cảm xúc tích cực",

		"flexibility_balanced": "Độ linh hoạt cân bằng",
		"flexibility_flexible": "Linh hoạt",
		"flexibility_rigid": "Cứng nhắc",

		"frequency_frequent": "Thường xuyên",
		"frequency_medium": "Tần suất trung bình",
		"frequency_rare": "Hiếm",

		"fullness_empty": "Rỗng",
		"fullness_full": "Đầy",
		"fullness_partial": "Một phần",

		"hardness_hard": "Cứng",
		"hardness_medium": "Độ cứng trung bình",
		"hardness_soft": "Mềm",

		"height_medium": "Chiều cao trung bình",
		"height_short": "Thấp",
		"height_tall": "Cao",

		"intelligence_high": "Trí tuệ cao",
		"intelligence_low": "Trí tuệ thấp",

		"intensity_high": "Cường độ cao",
		"intensity_low": "Cường độ thấp",

		"length_long": "Dài",
		"length_medium": "Chiều dài trung bình",
		"length_short": "Ngắn",

		"light_bright": "Sáng",
		"light_dark": "Tối",
		"light_medium": "Ánh sáng trung bình",

		"moisture_damp": "Ẩm nhẹ",
		"moisture_dry": "Khô",
		"moisture_wet": "Ướt",

		"quality_general": "Chất lượng chung",
		"quality_good": "Chất lượng tốt",
		"quality_poor": "Chất lượng kém",

		"quantity_few": "Ít",
		"quantity_many": "Nhiều",
		"quantity_some": "Một vài",

		"safety_danger": "Nguy hiểm",
		"safety_risky": "Rủi ro",
		"safety_safe": "An toàn",

		"size_big": "Kích thước lớn",
		"size_medium": "Kích thước trung bình",
		"size_small": "Kích thước nhỏ",

		"sound_loud": "Âm thanh lớn",
		"sound_medium": "Âm thanh vừa",
		"sound_quiet": "Yên tĩnh",

		"speed_fast": "Tốc độ nhanh",
		"speed_medium": "Tốc độ trung bình",
		"speed_slow": "Tốc độ chậm",

		"strength_normal": "Sức mạnh bình thường",
		"strength_strong": "Mạnh",
		"strength_weak": "Yếu",

		"temperature_cold": "Lạnh",
		"temperature_hot": "Nóng",
		"temperature_warm": "Ấm",

		"weight_heavy": "Nặng",
		"weight_light": "Nhẹ",
		"weight_medium": "Trọng lượng trung bình",

		"width_medium": "Chiều rộng trung bình",
		"width_narrow": "Hẹp",
		"width_wide": "Rộng"
	}
}

func tr_ui(key: String) -> String:

	var lang = UI_TEXT.get(
		current_language,
		UI_TEXT["en"]
	)

	if lang.has(key):
		return lang[key]

	return UI_TEXT["en"].get(
		key,
		auto_format(key)
	)
	
func tr_group(group_id: String) -> String:

	var lang = GROUP_TEXT.get(
		current_language,
		GROUP_TEXT["en"]
	)

	if lang.has(group_id):
		return lang[group_id]

	return auto_format(group_id)
	
func tr_pos(pos_id: String) -> String:

	var lang = POS_TEXT.get(
		current_language,
		POS_TEXT["en"]
	)

	if lang.has(pos_id):
		return lang[pos_id]

	return auto_format(pos_id)
	
func tr_relation(relation_id: String) -> String:

	var lang = RELATION_TEXT.get(
		current_language,
		RELATION_TEXT["en"]
	)

	if lang.has(relation_id):
		return lang[relation_id]

	return auto_format(relation_id)
	
func tr_rarity(rarity_id: String) -> String:

	var lang = RARITY_TEXT.get(
		current_language,
		RARITY_TEXT["en"]
	)

	if lang.has(rarity_id):
		return lang[rarity_id]

	return auto_format(rarity_id)
	
func tr_item(key: String) -> String:

	var lang = ITEM_TEXT.get(
		current_language,
		ITEM_TEXT["en"]
	)

	if lang.has(key):
		return lang[key]

	var fallback = ITEM_TEXT["en"]

	if fallback.has(key):
		return fallback[key]

	return auto_format(key.replace("_desc", ""))


func tr_status(key: String) -> String:

	var lang = STATUS_TEXT.get(
		current_language,
		STATUS_TEXT["en"]
	)

	if lang.has(key):
		return lang[key]

	return auto_format(key)
	
func auto_format(text: String) -> String:

	text = text.replace("_", " ")

	var words = text.split(" ")

	for i in range(words.size()):

		words[i] = words[i].capitalize()

	return " ".join(words)
	
func set_language(lang: String):

	current_language = lang
