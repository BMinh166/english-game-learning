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
		"next": "Next",
		"done": "Done",
		
		"toturial": "TOTURIAL",
		
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

		"easy_desc":
			"15 rounds\n"
			+ "Lower target score and more relation words appear.\n"
			+ "A relaxed mode for learning and experimenting.",

		"normal_desc":
			"18 rounds\n"
			+ "Balanced target score and balanced relation frequency.\n"
			+ "The standard gameplay experience.",

		"hard_desc":
			"21 rounds\n"
			+ "Higher score scaling and fewer relation words.\n"
			+ "Requires strategy and vocabulary mastery.",
		
		"game_over": "Game Over",
		"victory": "Victory",

		"score": "Score",
		
		"completed": "Completed",
		"not_completed": "Not Completed",
		
		"easy": "Easy",
		"normal": "Normal",
		"hard": "Hard",
		
		"skip": "Skip",
		"reroll": "Reroll",
		"reward_item": "Choose a reward",
		
		"tutorial_step_1":
			"The target word appears at the center.\n"
			+ "Choose words below that can form relations with the target word to score points.\n"
			+ "Reach the target score before running out of Turns.",

		"tutorial_step_2":
			"There are 5 word relations and each relation gives different score values.\n\n"
			+ "Examples:\n"
			+ "Big – Huge (Synonym)\n"
			+ "Hot – Warm (Degree)\n"
			+ "Create – Creative (Family)\n\n"
			+ "Word relations are not completely rigid, so feel free to experiment.",

		"tutorial_step_3":
			"Chain activates when 2 or more valid words are played consecutively.\n"
			+ "Chain increases score exponentially, the longer the streak the stronger it becomes.\n"
			+ "Try to minimize invalid words as much as possible.",

		"tutorial_step_4":
			"Each play consumes 1 Turn. Running out of Turns means defeat.\n\n"
			+ "Besides the 5 words in your hand, the Bag contains 40 additional words.\n"
			+ "Use Discard to remove unwanted words and draw random new ones from the Bag.\n"
			+ "You can Discard up to 5 times.",

		"tutorial_step_5":
			"After reaching the target score, you clear the round and choose 1 support Item.\n"
			+ "Items shape your playstyle and improve scoring.\n"
			+ "You can only hold up to 5 Items, so choose carefully.\n"
			+ "Selling Items grants bonus Turns.",
		
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
		"next": "Tiếp",
		"done": "Xong",
		
		"toturial": "HƯỚNG DẪN",
		
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

		"easy_desc":
			"Có tổng 15 vòng\n"
			+ "Điểm mục tiêu thấp và nhiều từ có quan hệ xuất hiện hơn.\n"
			+ "Phù hợp để thư giãn và làm quen game.",

		"normal_desc":
			"Có tổng 18 vòng\n"
			+ "Điểm mục tiêu và tỉ lệ quan hệ từ cân bằng.\n"
			+ "Trải nghiệm tiêu chuẩn của game.",

		"hard_desc":
			"Có tổng 21 vòng\n"
			+ "Điểm mục tiêu tăng mạnh và ít quan hệ từ hơn.\n"
			+ "Yêu cầu chiến thuật và vốn từ vựng tốt.",
		
		"game_over": "Thất bại",
		"victory": "Chiến thắng",

		"score": "Điểm",
		
		"completed": "Đã hoàn thành",
		"not_completed": "Chưa hoàn thành",
		
		"easy": "Dễ",
		"normal": "Thường",
		"hard": "Khó",
		
		"skip": "Bỏ qua",
		"reroll": "Đổi lại",
		"reward_item": "Hãy chọn phần thưởng",
		
		"tutorial_step_1":
			"Từ yêu cầu xuất hiện ở giữa.\n"
			+ "Hãy chọn các từ bên dưới có thể lập mối quan hệ với từ yêu cầu để ghi điểm.\n"
			+ "Hãy ghi đủ số điểm trước khi hết Lượt chơi.",

		"tutorial_step_2":
			"Có 5 quan hệ từ và mỗi quan hệ từ sẽ ghi số điểm khác nhau.\n\n"
			+ "Ví dụ:\n"
			+ "Big – Huge (Đồng nghĩa)\n"
			+ "Hot – Warm (Mức độ)\n"
			+ "Create – Creative (Họ)\n\n"
			+ "Các quan hệ từ không hoạt động cứng nhắc vì thế hãy cứ thoải mái.",

		"tutorial_step_3":
			"Chain sẽ kích hoạt khi có 2 hoặc nhiều hơn từ hợp lệ liên tiếp nhau.\n"
			+ "Chain sẽ tăng điểm theo cấp số nhân, càng đúng liên tục điểm tăng càng mạnh.\n"
			+ "Hãy cố gắng giảm thiểu số từ không hợp lệ nhất nhé.",

		"tutorial_step_4":
			"Mỗi lần đánh từ ra sẽ tốn 1 Lượt, nếu hết lượt sẽ thua.\n\n"
			+ "Ngoài 5 từ trên tay, trong Túi sẽ có thêm 40 từ khác.\n"
			+ "Có thể dùng Bỏ từ để loại bỏ những từ không cần thiết và từ mới sẽ được lấy ngẫu nhiên trong Túi.\n"
			+ "Tối đa có 5 lượt Bỏ từ.",

		"tutorial_step_5":
			"Sau khi hoàn thành số điểm yêu cầu sẽ qua màn và được chọn 1 Vật Phẩm hỗ trợ.\n"
			+ "Các Vật Phẩm này giúp định hình lối chơi và cải thiện điểm nhận được.\n"
			+ "Tối đa chỉ chứa được 5 Vật Phẩm, hãy suy nghĩ kỹ trước khi lựa chọn.\n"
			+ "Vật phẩm khi bán sẽ chuyển thành số Lượt chơi.",
	}
}

var WORD_MEANING = {

	"en": {

		"small": "having little size",
		"tiny": "extremely small",
		"little": "small in size",
		"mini": "smaller than normal",
		"compact": "small and efficiently arranged",
		"slight": "small in amount or degree",

		"medium": "average in size or amount",
		"moderate": "not too much or too little",
		"average": "typical or normal",
		"normal": "usual or expected",

		"big": "large in size",
		"large": "big in size",
		"huge": "extremely large",
		"gigantic": "extremely big",
		"enormous": "very large",
		"massive": "very large and heavy",
		"giant": "extremely large",

		"size": "the dimensions of something",
		"resize": "to change size",

		"short": "having little length or height",
		"long": "having great length",
		"wide": "measuring a large distance from side to side",
		"narrow": "not wide",
		"thick": "having a large distance between sides",
		"thin": "having little thickness",

		"slow": "moving with little speed",
		"sluggish": "slow and lacking energy",
		"lazy": "unwilling to work or move",
		"steady": "moving regularly without change",
		"gradual": "happening slowly over time",

		"fast": "moving quickly",
		"quick": "done in a short time",
		"rapid": "happening very fast",
		"swift": "moving very quickly",
		"speedy": "fast in movement",
		"instant": "happening immediately",

		"speed": "the rate of movement",
		"speed up": "to become faster",
		"slow down": "to reduce speed",
		"rush": "to move quickly or a sudden hurry",
		"hurry": "to do something quickly",
		"delay": "to make something late",
		"pause": "to stop briefly or a short stop",

		"cold": "having low temperature",
		"cool": "slightly cold",
		"freezing": "extremely cold",
		"icy": "covered with ice or very cold",
		"chilly": "unpleasantly cold",
		"frozen": "turned into ice",

		"warm": "slightly hot",
		"mild": "not strong or extreme",
		"hot": "having high temperature",
		"heated": "made hot",
		"burning": "extremely hot",
		"boiling": "hot enough to boil",
		"fiery": "very hot or intense",

		"temperature": "degree of heat or cold",
		"heat": "high temperature or to make hot",
		"freeze": "to turn into ice",
		"melt": "to turn liquid by heat",
		"cool down": "to become cooler",
		"warm up": "to become warmer",
		"steam": "hot vapor or to cook with steam",

		"few": "a small number",
		"limited": "small in amount",
		"rare": "not common",
		"scarce": "hard to find",
		"minimal": "very small in amount",

		"some": "an unspecified amount",
		"several": "more than a few",
		"many": "a large number",
		"much": "a large amount",
		"numerous": "existing in large numbers",
		"plentiful": "existing in abundance",
		"abundant": "more than enough",
		"countless": "too many to count",

		"quantity": "amount of something",
		"amount": "a quantity of something",
		"increase": "to become greater",
		"decrease": "to become smaller",
		"count": "to determine number",
		"collect": "to gather together",
		"reduce": "to make smaller",
		"light": "not heavy or full of light",
		"lean": "thin and light",
		"lightweight": "light in weight",
		"heavy": "weighing a lot",
		"dense": "thick and closely packed",
		"solid": "strong, hard, and firm",
		"weighted": "having extra weight",

		"weight": "how heavy something is",
		"weigh": "to measure weight",
		"burden": "a heavy load or responsibility",
		"load": "something being carried",
		"carry": "to hold and move",
		"lift": "to raise upward",
		"drop": "to let fall",
		"balance": "a stable equal state",

		"weak": "not strong",
		"soft": "gentle, flexible, or not hard",
		"fragile": "easily broken",
		"feeble": "physically weak",
		"delicate": "easily damaged",
		"breakable": "able to break easily",

		"balanced": "stable, moderate, and even",
		"stable": "firm and unlikely to change",
		"strong": "having great power",
		"powerful": "having strong force",
		"tough": "strong and durable",
		"mighty": "very powerful",
		"forceful": "powerfully effective",

		"strength": "physical or mental power",
		"power": "ability to control or influence",
		"force": "strength or energy applied",
		"boost": "to improve or increase",
		"reinforce": "to strengthen support",
		"damage": "harm or injury",
		"break": "to separate into pieces or a pause",
		"protect": "to keep safe",

		"brief": "short in length or duration",
		"extended": "made longer",
		"wide-ranging": "covering many areas",
		"far": "at a great distance",
		"distant": "far away",

		"length": "measurement from end to end",
		"distance": "space between two points",
		"extend": "to make longer",
		"stretch": "to pull longer or a continuous area",
		"cut": "to divide with a sharp tool",
		"measure": "to determine size or amount",

		"tight": "firmly fixed or narrow",
		"broad": "wide in extent",
		"spacious": "having plenty of space",
		"open": "not closed",
		"expanded": "made larger",
		"roomy": "having a lot of space",

		"width": "side-to-side measurement",
		"space": "a wide empty area",
		"spread": "to extend over an area",
		"squeeze": "to press tightly",
		"compress": "to press into smaller size",
		"fit": "to be the correct size",

		"smooth": "having an even surface",
		"gentle": "soft and mild",
		"flexible": "able to bend easily",
		"elastic": "able to stretch and return",

		"hard": "firm and difficult to break",
		"firm": "solid and stable",
		"stiff": "hard to bend",
		"rigid": "unable to bend or change",
		"durable": "lasting a long time",

		"hardness": "degree of being hard",
		"material": "substance something is made of",
		"strengthen": "to make stronger",
		"bend": "to curve or fold",
		"crack": "a narrow break",
		"shape": "the outer form of something",
		
				"dirty": "not clean",
		"messy": "untidy and disorganized",
		"dusty": "covered with dust",
		"muddy": "covered with mud",
		"filthy": "extremely dirty",
		"polluted": "contaminated and dirty",

		"clean": "free from dirt",
		"fresh": "clean and new",
		"pure": "not mixed with anything dirty",
		"neat": "clean and organized",
		"spotless": "perfectly clean",
		"sanitary": "clean and hygienic",

		"cleanliness": "the state of being clean",
		"wash": "to clean with water",
		"wipe": "to clean by rubbing",
		"stain": "a dirty mark",
		"pollute": "to make dirty or harmful",
		"restore": "to bring back to good condition",
		"organize": "to arrange neatly",

		"empty": "containing nothing",
		"vacant": "not occupied",
		"blank": "without writing or marks",
		"hollow": "empty inside",
		"drained": "having nothing left",
		"depleted": "used up completely",

		"partial": "not complete",
		"half": "one of two equal parts",
		"full": "containing as much as possible",
		"packed": "filled tightly",
		"loaded": "filled or carrying much",
		"stuffed": "filled completely",
		"overflowing": "spilling over because too full",
		"crammed": "packed into a small space",

		"capacity": "maximum amount something can hold",
		"container": "an object used to hold things",
		"fill": "to make full",
		"drain": "to remove liquid or contents",
		"store": "to keep for future use",
		"contain": "to hold inside",

		"dry": "without moisture",
		"arid": "extremely dry",
		"rough": "dry and coarse",
		"crispy": "pleasantly dry and crunchy",
		"dehydrated": "having lost water",
		"brittle": "hard and easy to break",

		"damp": "slightly wet",
		"moist": "slightly wet in a pleasant way",
		"humid": "containing much moisture in air",
		"wet": "covered with water",
		"soaked": "completely wet",
		"watery": "containing too much water",
		"flooded": "covered with a large amount of water",
		"soaking": "extremely wet",
		"dripping": "falling in drops",

		"moisture": "small amount of water",
		"water": "clear liquid essential for life",
		"soak": "to make completely wet",
		"drip": "to fall in drops",
		"evaporate": "to turn into vapor",
		"hydrate": "to supply water",
		"absorb": "to take in liquid",

		"inflexible": "unable to bend or change",
		"stretchable": "able to stretch",
		"bendy": "easy to bend",
		"flexibility": "ability to bend or adapt",
		"twist": "to turn into a different shape",
		"tighten": "to make tighter",
		"lock": "to fasten securely",
		"adjust": "to change slightly",
		"adapt": "to change to fit conditions",
		
				"safe": "free from danger",
		"secure": "protected from harm",
		"protected": "kept safe from damage",
		"harmless": "not dangerous",
		"shielded": "covered for protection",

		"risky": "involving danger",
		"uncertain": "not known or sure",
		"unstable": "not steady or secure",
		"exposed": "left without protection",

		"dangerous": "likely to cause harm",
		"deadly": "able to cause death",
		"harmful": "causing damage",
		"toxic": "poisonous",
		"fatal": "causing death",
		"hazardous": "full of danger",

		"safety": "state of being safe",
		"danger": "possibility of harm",
		"shield": "to protect from danger",
		"warn": "to tell about danger",
		"attack": "to use force against",
		"survive": "to stay alive",
		"avoid": "to stay away from",

		"quiet": "making little noise",
		"silent": "making no sound",
		"calm": "peaceful and quiet",
		"muffled": "softened and unclear in sound",
		"whisper": "to speak very quietly",
		"faint": "weak, difficult to hear, or difficult to see",
		"inaudible": "unable to be heard",

		"loud": "making much noise",
		"noisy": "full of noise",
		"sharp": "clear and strong in sound",
		"booming": "deep and powerful in sound",
		"roaring": "very loud and deep",
		"thunderous": "extremely loud",

		"scream": "a loud cry",
		"echo": "a repeated sound",
		"sound": "something heard or to produce sound",
		"noise": "unwanted sound",
		"volume": "level of loudness",
		"resonate": "to produce deep clear sound",

		"dark": "having little or no light",
		"dim": "not bright",
		"shadowy": "filled with shadows",
		"gloomy": "dark and depressing",
		"obscure": "difficult to see or understand",
		"shade": "area protected from light",
		"shadow": "a dark shape or to follow closely",

		"neutral": "neither bright nor dark",
		"bright": "giving much light",
		"glowing": "shining softly",
		"shining": "giving off light",
		"radiant": "bright and glowing",
		"luminous": "producing light",

		"flash": "a sudden bright light",
		"sparkle": "to shine with tiny flashes",
		"brightness": "amount of light",
		"glow": "steady soft light",
		"fade": "to become weaker or dimmer",
		"illuminate": "to light up",
		
				"sparse": "thinly spread",
		"scattered": "spread apart in different places",
		"loose": "not tight or dense",
		"spread-out": "distributed over a wide area",
		"fragmented": "broken into separate parts",

		"disperse": "to spread in different directions",
		"scatter": "to throw in many directions",
		"even": "equal and balanced",
		"crowded": "full of many things or people",
		"compressed": "pressed into a smaller space",
		"concentrated": "gathered densely together",

		"cluster": "a close group of things",
		"density": "amount within a space",
		"pile": "a heap of things",

		"low": "not high",
		"shallow": "not deep",
		"stunted": "smaller than normal growth",
		"lower": "to move downward",
		"grounded": "connected to the ground",

		"level": "flat or equal height",
		"tall": "having great height",
		"high": "far above ground",
		"elevated": "raised higher",
		"towering": "extremely tall",
		"lofty": "very high",
		"sky-high": "extremely high",

		"rise": "to move upward",
		"climb": "to move upward using effort",
		"height": "measurement from bottom to top",
		"altitude": "height above sea level",
		"peak": "highest point",
		"descend": "to move downward",

		"surface": "outer top layer",
		"flat": "having little depth",
		"superficial": "existing only on surface",
		"skim": "to move lightly across surface",
		"scratch": "a shallow mark",

		"deep": "extending far downward",
		"profound": "very deep or meaningful",
		"intense": "very strong or deep",
		"bottomless": "extremely deep",
		"layered": "arranged in layers",

		"sink": "to move downward below surface",
		"dive": "to move deeply downward",
		"depth": "distance downward",
		"layer": "a level or sheet over another",
		"dig": "to break ground",
		"bury": "to place under ground",
		
		"old": "existing for a long time",
		"ancient": "extremely old",
		"aged": "old in age",
		"worn": "damaged from long use",
		"outdated": "no longer modern",
		"obsolete": "no longer used",
		"decay": "gradual destruction over time",

		"current": "belonging to the present time",
		"modern": "relating to current times",
		"recent": "happening not long ago",
		"present": "existing now",

		"new": "recently made or discovered",
		"renewed": "made new again",
		"innovative": "introducing new ideas",
		"cutting_edge": "highly advanced and modern",
		"emerging": "starting to appear",

		"renew": "to make new again",
		"update": "to make more modern",
		"age": "length of existence",
		"time": "continuous flow of moments",
		"era": "a long historical period",
		"evolve": "to develop gradually",

		"rarely": "not often",
		"seldom": "almost never",
		"infrequent": "not happening often",
		"occasional": "happening sometimes",
		"sporadic": "happening irregularly",

		"vanish": "to disappear completely",
		"sometimes": "on some occasions",
		"routine": "regular repeated activity",

		"often": "frequently",
		"frequent": "happening many times",
		"common": "happening or found often",
		"constant": "continuing without stopping",
		"continuous": "without interruption",
		"repetitive": "repeated many times",

		"repeat": "to do again",
		"recur": "to happen repeatedly",
		"frequency": "rate of repetition",
		"pattern": "repeated arrangement",
		"cycle": "series that repeats",
		"interval": "space between events",

		"simple": "easy to understand",
		"basic": "forming the foundation",
		"straightforward": "easy and direct",
		"streamlined": "made simpler and more efficient",

		"clarify": "to make clear",
		"complex": "having many connected parts",
		"complicated": "difficult to understand",
		"intricate": "having many small details",
		"sophisticated": "highly developed or advanced",
		"elaborate": "detailed and complicated",
		"multilayered": "having many layers",
		"convoluted": "extremely complicated",

		"decipher": "to understand something difficult",
		"complexity": "state of being complicated",
		"structure": "arrangement of parts",
		"framework": "basic supporting structure",
		"simplify": "to make easier",

		"bad": "low in quality",
		"poor": "not good enough",
		"flawed": "containing mistakes or defects",
		"defective": "not working properly",
		"inferior": "lower in quality",
		"substandard": "below normal quality",

		"deteriorate": "to become worse",
		"good": "high in quality",
		"excellent": "extremely good",
		"superior": "better than others",
		"premium": "high quality",
		"refined": "improved and polished",
		"exceptional": "unusually excellent",

		"enhance": "to improve quality",
		"quality": "degree of excellence",
		"standard": "normal level of quality",
		"masterpiece": "an outstanding work",
		"evaluate": "to judge quality or value",

		"sad": "feeling unhappy",
		"anxious": "feeling worried",
		"frustrated": "feeling upset from failure",
		"miserable": "extremely unhappy",
		"devastated": "emotionally destroyed",
		"melancholy": "deep sadness",
		"despair": "complete loss of hope",

		"happy": "feeling pleasure",
		"cheerful": "noticeably happy",
		"delighted": "very pleased",
		"thrilled": "extremely excited and happy",
		"ecstatic": "overwhelmingly happy",
		"euphoric": "intensely happy",

		"rejoice": "to feel or show joy",
		"emotion": "strong feeling",
		"mood": "temporary emotional state",
		"passion": "strong enthusiasm or love",
		"empathy": "ability to understand feelings",

		"dumb": "lacking intelligence",
		"foolish": "showing poor judgment",
		"ignorant": "lacking knowledge",
		"naive": "too trusting or inexperienced",
		"irrational": "not based on reason",
		"incompetent": "not capable",

		"misjudge": "to judge incorrectly",
		"smart": "intelligent",
		"clever": "quick to understand",
		"intelligent": "having high mental ability",
		"brilliant": "exceptionally intelligent",
		"analytical": "good at logical examination",
		"ingenious": "clever and inventive",

		"deduce": "to reach a conclusion logically",
		"intelligence": "ability to learn and reason",
		"logic": "system of reasoning",
		"reason": "cause or logical thinking",
		"perception": "awareness through senses",

		"subtle": "delicate and not obvious",
		"restrained": "controlled and moderate",
		"muted": "softened or reduced",
		"suppress": "to stop or reduce forcefully",

		"fierce": "extremely intense",
		"overwhelming": "too strong to resist",
		"explosive": "sudden and powerful",
		"ferocious": "extremely violent or intense",

		"amplify": "to increase intensity",
		"intensity": "degree of strength",
		"energy": "power or force",
		"pressure": "continuous force",
		"surge": "sudden strong increase",
		
		"sized": "having a particular size",
		"lengthy": "very long",
		"fat": "large and heavy",
		"slim": "thin in an attractive way",
		"oversized": "larger than normal",
		"undersized": "smaller than normal",

		"expand": "to become larger",
		"shrink": "to become smaller",

		"regular": "happening in a normal repeated way",

		"warm-hot": "moderately hot",
	},

	"vi": {

		"small": "Nhỏ bé",
		"tiny": "Cực nhỏ",
		"little": "Nhỏ",
		"mini": "Cỡ nhỏ",
		"compact": "Nhỏ gọn",
		"slight": "Nhẹ",

		"medium": "Trung bình",
		"moderate": "Vừa phải",
		"average": "Trung bình",
		"normal": "Bình thường",

		"big": "To lớn",
		"large": "Lớn",
		"huge": "Khổng lồ",
		"gigantic": "Khổng lồ",
		"enormous": "Khổng lồ",
		"massive": "Đồ sộ",
		"giant": "Khổng lồ",

		"size": "Kích thước",
		"resize": "Đổi kích thước",

		"short": "Ngắn hoặc thấp",
		"long": "Dài",
		"wide": "Rộng",
		"narrow": "Hẹp",
		"thick": "Dày",
		"thin": "Mỏng",

		"slow": "Chậm",
		"sluggish": "Ì ạch",
		"lazy": "Lười biếng",
		"steady": "Ổn định",
		"gradual": "Dần dần",

		"fast": "Nhanh",
		"quick": "Nhanh chóng",
		"rapid": "Mau lẹ",
		"swift": "Thoăn thoắt",
		"speedy": "Nhanh",
		"instant": "Ngay lập tức",

		"speed": "Tốc độ",
		"speed up": "Tăng tốc",
		"slow down": "Chậm lại",
		"rush": "Vội vã",
		"hurry": "Nhanh lên",
		"delay": "Trì hoãn",
		"pause": "Tạm dừng",

		"cold": "Lạnh",
		"cool": "Mát",
		"freezing": "Lạnh cóng",
		"icy": "Băng giá",
		"chilly": "Lạnh buốt",
		"frozen": "Đóng băng",

		"warm": "Ấm",
		"mild": "Ôn hòa",
		"hot": "Nóng",
		"heated": "Được làm nóng",
		"burning": "Nóng rực",
		"boiling": "Sôi sục",
		"fiery": "Rực lửa",

		"temperature": "Nhiệt độ",
		"heat": "Nhiệt",
		"freeze": "Đóng băng",
		"melt": "Tan chảy",
		"cool down": "Hạ nhiệt",
		"warm up": "Làm ấm",
		"steam": "Hơi nước",

		"few": "Ít",
		"limited": "Hạn chế",
		"rare": "Hiếm",
		"scarce": "Khan hiếm",
		"minimal": "Tối thiểu",

		"some": "Một vài",
		"several": "Một số",
		"many": "Nhiều",
		"much": "Nhiều",
		"numerous": "Vô số",
		"plentiful": "Phong phú",
		"abundant": "Dồi dào",
		"countless": "Không đếm xuể",

		"quantity": "Số lượng",
		"amount": "Lượng",
		"increase": "Gia tăng",
		"decrease": "Giảm xuống",
		"count": "Đếm",
		"collect": "Thu thập",
		"reduce": "Giảm bớt",
		"light": "Nhẹ hoặc sáng",
		"lean": "Gầy nhẹ",
		"lightweight": "Trọng lượng nhẹ",
		"heavy": "Nặng",
		"dense": "Dày đặc",
		"solid": "Rắn chắc và vững",
		"weighted": "Có trọng lượng",

		"weight": "Trọng lượng",
		"weigh": "Cân đo trọng lượng",
		"burden": "Gánh nặng",
		"load": "Tải trọng",
		"carry": "Mang vác",
		"lift": "Nâng lên",
		"drop": "Làm rơi",
		"balance": "Sự cân bằng",

		"weak": "Yếu",
		"soft": "Mềm hoặc dịu",
		"fragile": "Dễ vỡ",
		"feeble": "Yếu ớt",
		"delicate": "Mỏng manh",
		"breakable": "Có thể vỡ",

		"balanced": "Cân bằng",
		"stable": "Ổn định",
		"strong": "Mạnh",
		"powerful": "Đầy sức mạnh",
		"tough": "Cứng cáp",
		"mighty": "Hùng mạnh",
		"forceful": "Đầy uy lực",

		"strength": "Sức mạnh",
		"power": "Sức mạnh",
		"force": "Lực",
		"boost": "Tăng cường",
		"reinforce": "Gia cố",
		"damage": "Thiệt hại",
		"break": "Làm vỡ",
		"protect": "Bảo vệ",

		"brief": "Ngắn gọn",
		"extended": "Kéo dài",
		"wide-ranging": "Trên phạm vi rộng",
		"far": "Xa",
		"distant": "Xa xôi",

		"length": "Chiều dài",
		"distance": "Khoảng cách",
		"extend": "Mở rộng",
		"stretch": "Kéo giãn",
		"cut": "Cắt",
		"measure": "Đo lường",

		"tight": "Chật hoặc chặt",
		"broad": "Rộng lớn",
		"spacious": "Rộng rãi",
		"open": "Mở",
		"expanded": "Mở rộng",
		"roomy": "Rộng rãi",

		"width": "Chiều rộng",
		"space": "Khoảng trống",
		"spread": "Lan rộng",
		"squeeze": "Ép chặt",
		"compress": "Nén lại",
		"fit": "Vừa khít",

		"smooth": "Trơn mịn",
		"gentle": "Nhẹ nhàng",
		"flexible": "Linh hoạt",
		"elastic": "Co giãn",

		"hard": "Cứng",
		"firm": "Rắn chắc",
		"stiff": "Cứng nhắc",
		"rigid": "Cứng đờ",
		"durable": "Bền bỉ",

		"hardness": "Độ cứng",
		"material": "Vật liệu",
		"strengthen": "Làm mạnh hơn",
		"bend": "Bẻ cong",
		"crack": "Vết nứt",
		"shape": "Hình dạng",
		
		"dirty": "Bẩn",
		"messy": "Bừa bộn",
		"dusty": "Đầy bụi",
		"muddy": "Lấm bùn",
		"filthy": "Cực kỳ bẩn",
		"polluted": "Ô nhiễm",

		"clean": "Sạch sẽ",
		"fresh": "Tươi mới",
		"pure": "Tinh khiết",
		"neat": "Gọn gàng",
		"spotless": "Sạch bóng",
		"sanitary": "Vệ sinh",

		"cleanliness": "Sự sạch sẽ",
		"wash": "Rửa",
		"wipe": "Lau chùi",
		"stain": "Vết bẩn",
		"pollute": "Làm ô nhiễm",
		"restore": "Khôi phục",
		"organize": "Sắp xếp",

		"empty": "Trống rỗng",
		"vacant": "Bỏ trống",
		"blank": "Trống",
		"hollow": "Rỗng bên trong",
		"drained": "Cạn kiệt",
		"depleted": "Bị tiêu hao hết",

		"partial": "Một phần",
		"half": "Một nửa",
		"full": "Đầy",
		"packed": "Chật kín",
		"loaded": "Chứa đầy",
		"stuffed": "Nhồi đầy",
		"overflowing": "Tràn đầy",
		"crammed": "Chen chúc",

		"capacity": "Sức chứa",
		"container": "Vật chứa",
		"fill": "Lấp đầy",
		"drain": "Rút cạn",
		"store": "Lưu trữ",
		"contain": "Chứa đựng",

		"dry": "Khô",
		"arid": "Khô cằn",
		"rough": "Thô ráp",
		"crispy": "Giòn",
		"dehydrated": "Mất nước",
		"brittle": "Giòn dễ vỡ",

		"damp": "Ẩm nhẹ",
		"moist": "Ẩm",
		"humid": "Ẩm ướt",
		"wet": "Ướt",
		"soaked": "Ướt sũng",
		"watery": "Nhiều nước",
		"flooded": "Ngập nước",
		"soaking": "Sũng nước",
		"dripping": "Nhỏ giọt",

		"moisture": "Độ ẩm",
		"water": "Nước",
		"soak": "Ngâm ướt",
		"drip": "Nhỏ giọt",
		"evaporate": "Bay hơi",
		"hydrate": "Cấp nước",
		"absorb": "Hấp thụ",

		"inflexible": "Không linh hoạt",
		"stretchable": "Có thể kéo giãn",
		"bendy": "Dẻo",
		"flexibility": "Độ linh hoạt",
		"twist": "Xoắn vặn",
		"tighten": "Siết chặt",
		"lock": "Khóa",
		"adjust": "Điều chỉnh",
		"adapt": "Thích nghi",
		
				"safe": "An toàn",
		"secure": "Bảo mật hoặc an toàn",
		"protected": "Được bảo vệ",
		"harmless": "Vô hại",
		"shielded": "Được che chắn",

		"risky": "Rủi ro",
		"uncertain": "Không chắc chắn",
		"unstable": "Không ổn định",
		"exposed": "Bị lộ ra",

		"dangerous": "Nguy hiểm",
		"deadly": "Chết người",
		"harmful": "Có hại",
		"toxic": "Độc hại",
		"fatal": "Gây tử vong",
		"hazardous": "Nguy hại",

		"safety": "Sự an toàn",
		"danger": "Nguy hiểm",
		"shield": "Che chắn",
		"warn": "Cảnh báo",
		"attack": "Tấn công",
		"survive": "Sống sót",
		"avoid": "Tránh né",

		"quiet": "Yên tĩnh",
		"silent": "Im lặng",
		"calm": "Bình tĩnh",
		"muffled": "Bị nghẹt tiếng",
		"whisper": "Thì thầm",
		"faint": "Mờ nhạt hoặc yếu",
		"inaudible": "Không thể nghe được",

		"loud": "Ồn ào",
		"noisy": "Nhiều tiếng ồn",
		"sharp": "Chói tai",
		"booming": "Vang dội",
		"roaring": "Gầm rú",
		"thunderous": "Ầm vang",

		"scream": "Tiếng hét",
		"echo": "Tiếng vang",
		"sound": "Âm thanh",
		"noise": "Tiếng ồn",
		"volume": "Âm lượng",
		"resonate": "Cộng hưởng",

		"dark": "Tối",
		"dim": "Mờ tối",
		"shadowy": "Mờ trong bóng tối",
		"gloomy": "U ám",
		"obscure": "Mơ hồ",
		"shade": "Bóng râm",
		"shadow": "Bóng đổ",

		"neutral": "Trung tính",
		"bright": "Sáng",
		"glowing": "Phát sáng",
		"shining": "Tỏa sáng",
		"radiant": "Rạng rỡ",
		"luminous": "Phát quang",

		"flash": "Tia chớp sáng",
		"sparkle": "Lấp lánh",
		"brightness": "Độ sáng",
		"glow": "Ánh sáng dịu",
		"fade": "Mờ dần",
		"illuminate": "Chiếu sáng",
		
				"sparse": "Thưa thớt",
		"scattered": "Phân tán",
		"loose": "Lỏng lẻo",
		"spread-out": "Trải rộng",
		"fragmented": "Phân mảnh",

		"disperse": "Phân tán",
		"scatter": "Rải rác",
		"even": "Đều đặn",
		"crowded": "Đông đúc",
		"compressed": "Bị nén",
		"concentrated": "Cô đặc",

		"cluster": "Cụm",
		"density": "Mật độ",
		"pile": "Đống",

		"low": "Thấp",
		"shallow": "Nông",
		"stunted": "Còi cọc",
		"lower": "Hạ xuống",
		"grounded": "Tiếp đất",

		"level": "Cân bằng hoặc bằng phẳng",
		"tall": "Cao",
		"high": "Cao",
		"elevated": "Nâng cao",
		"towering": "Cao chót vót",
		"lofty": "Rất cao",
		"sky-high": "Cao ngất",

		"rise": "Tăng lên",
		"climb": "Leo lên",
		"height": "Chiều cao",
		"altitude": "Độ cao",
		"peak": "Đỉnh",
		"descend": "Đi xuống",

		"surface": "Bề mặt",
		"flat": "Phẳng",
		"superficial": "Nông cạn",
		"skim": "Lướt qua",
		"scratch": "Vết xước",

		"deep": "Sâu",
		"profound": "Sâu sắc",
		"intense": "Mạnh mẽ",
		"bottomless": "Sâu không đáy",
		"layered": "Nhiều lớp",

		"sink": "Chìm xuống",
		"dive": "Lặn xuống",
		"depth": "Độ sâu",
		"layer": "Lớp",
		"dig": "Đào",
		"bury": "Chôn vùi",
		
		"old": "Cũ",
		"ancient": "Cổ xưa",
		"aged": "Có tuổi",
		"worn": "Mòn cũ",
		"outdated": "Lỗi thời",
		"obsolete": "Lạc hậu",
		"decay": "Sự mục nát",

		"current": "Hiện tại",
		"modern": "Hiện đại",
		"recent": "Gần đây",
		"present": "Hiện diện",

		"new": "Mới",
		"renewed": "Được làm mới",
		"innovative": "Đổi mới sáng tạo",
		"cutting_edge": "Tân tiến",
		"emerging": "Mới nổi",

		"renew": "Làm mới",
		"update": "Cập nhật",
		"age": "Tuổi tác",
		"time": "Thời gian",
		"era": "Kỷ nguyên",
		"evolve": "Tiến hóa",

		"rarely": "Hiếm khi",
		"seldom": "Ít khi",
		"infrequent": "Không thường xuyên",
		"occasional": "Thỉnh thoảng",
		"sporadic": "Rải rác",

		"vanish": "Biến mất",
		"sometimes": "Đôi khi",
		"routine": "Thói quen",

		"often": "Thường xuyên",
		"frequent": "Xảy ra thường xuyên",
		"common": "Phổ biến",
		"constant": "Liên tục",
		"continuous": "Không ngừng",
		"repetitive": "Lặp đi lặp lại",

		"repeat": "Lặp lại",
		"recur": "Tái diễn",
		"frequency": "Tần suất",
		"pattern": "Mẫu hình",
		"cycle": "Chu kỳ",
		"interval": "Khoảng cách",

		"simple": "Đơn giản",
		"basic": "Cơ bản",
		"straightforward": "Trực tiếp dễ hiểu",
		"streamlined": "Tinh gọn",

		"clarify": "Làm rõ",
		"complex": "Phức tạp",
		"complicated": "Rắc rối",
		"intricate": "Tinh vi",
		"sophisticated": "Tinh vi hiện đại",
		"elaborate": "Cầu kỳ",
		"multilayered": "Nhiều tầng lớp",
		"convoluted": "Cực kỳ phức tạp",

		"decipher": "Giải mã",
		"complexity": "Độ phức tạp",
		"structure": "Cấu trúc",
		"framework": "Khung cấu trúc",
		"simplify": "Đơn giản hóa",

		"bad": "Tệ",
		"poor": "Kém",
		"flawed": "Có khuyết điểm",
		"defective": "Bị lỗi",
		"inferior": "Kém hơn",
		"substandard": "Dưới tiêu chuẩn",

		"deteriorate": "Xuống cấp",
		"good": "Tốt",
		"excellent": "Xuất sắc",
		"superior": "Vượt trội",
		"premium": "Cao cấp",
		"refined": "Tinh chỉnh",
		"exceptional": "Phi thường",

		"enhance": "Nâng cao",
		"quality": "Chất lượng",
		"standard": "Tiêu chuẩn",
		"masterpiece": "Kiệt tác",
		"evaluate": "Đánh giá",

		"sad": "Buồn",
		"anxious": "Lo lắng",
		"frustrated": "Thất vọng",
		"miserable": "Khốn khổ",
		"devastated": "Suy sụp",
		"melancholy": "Nỗi buồn sâu lắng",
		"despair": "Tuyệt vọng",

		"happy": "Vui vẻ",
		"cheerful": "Vui tươi",
		"delighted": "Vô cùng hài lòng",
		"thrilled": "Phấn khích",
		"ecstatic": "Cực kỳ hạnh phúc",
		"euphoric": "Hưng phấn tột độ",

		"rejoice": "Vui mừng",
		"emotion": "Cảm xúc",
		"mood": "Tâm trạng",
		"passion": "Đam mê",
		"empathy": "Sự đồng cảm",

		"dumb": "Ngu ngốc",
		"foolish": "Dại dột",
		"ignorant": "Thiếu hiểu biết",
		"naive": "Ngây thơ",
		"irrational": "Phi lý",
		"incompetent": "Bất tài",

		"misjudge": "Đánh giá sai",
		"smart": "Thông minh",
		"clever": "Nhanh trí",
		"intelligent": "Thông minh",
		"brilliant": "Xuất chúng",
		"analytical": "Có tư duy phân tích",
		"ingenious": "Tài tình",

		"deduce": "Suy luận",
		"intelligence": "Trí thông minh",
		"logic": "Logic",
		"reason": "Lý trí hoặc lý do",
		"perception": "Nhận thức",

		"subtle": "Tinh tế",
		"restrained": "Kiềm chế",
		"muted": "Giảm nhẹ",
		"suppress": "Đè nén",

		"fierce": "Dữ dội",
		"overwhelming": "Áp đảo",
		"explosive": "Bùng nổ",
		"ferocious": "Hung bạo",

		"amplify": "Khuếch đại",
		"intensity": "Cường độ",
		"energy": "Năng lượng",
		"pressure": "Áp lực",
		"surge": "Làn tăng mạnh",
		"sized": "Có kích thước",
		"lengthy": "Rất dài",
		"fat": "Béo",
		"slim": "Mảnh mai",
		"oversized": "Quá khổ",
		"undersized": "Quá nhỏ",

		"expand": "Mở rộng",
		"shrink": "Co lại",

		"regular": "Thông thường hoặc đều đặn",

		"warm-hot": "Ấm nóng",
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
			"Synonym relations gain +40 Point",

		"wildcard_desc":
			"Gain +1 Mult each valid word",

		"cappuccino_desc":
			"B1/B2 level words gain +25 Point",

		"intensifier_desc":
			"First Degree relation each turn gains +3 Mult",

		"extra_caffeine_desc":
			"First valid word each turn gains +125 Point",

		"handy_shortcut_desc":
			"First chain bonus applies instantly",

		"family_guide_desc":
			"Family relations gain +360 Point",

		"phantom_hand_desc":
			"First fail each turn does not reset chain",

		"language_glitch_desc":
			"Antonym also counts as Synonym",

		"golden_ratio_desc":
			"Valid words permanently gain +2 Point",

		"scholars_thesis_desc":
			"C1/C2 level words gain +2 Mult",

		"yin_yang_desc":
			"Antonym relations gain +5 Mult",

		"magnetic_force_desc":
			"Same consecutive relation gains +67 Point",

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
			"Từ Đồng Nghĩa nhận +40 Point",

		"wildcard_desc":
			"Mỗi từ hợp lệ nhận +1 Mult",

		"cappuccino_desc":
			"Từ cấp độ B1/B2 nhận +25 Point",

		"intensifier_desc":
			"Từ Mức Độ đầu tiên mỗi lượt nhận +3 Mult",

		"extra_caffeine_desc":
			"Từ hợp lệ đầu tiên mỗi lượt nhận +125 Point",

		"handy_shortcut_desc":
			"Chain đầu tiên kích hoạt ngay lập tức",

		"family_guide_desc":
			"Từ Quan hệ Họ từ nhận +360 Point",

		"phantom_hand_desc":
			"Fail đầu tiên mỗi lượt sẽ không mất Chain",

		"language_glitch_desc":
			"Trái Nghĩa cũng được tính là Đồng Nghĩa",

		"golden_ratio_desc":
			"Từ hợp lệ nhận vĩnh viễn +2 Point",

		"scholars_thesis_desc":
			"Từ cấp độ C1/C2 nhận +2 Mult",

		"yin_yang_desc":
			"Từ Trái Nghĩa nhận +5 Mult",

		"magnetic_force_desc":
			"Hai từ có Quan hệ liên tiếp giống nhau nhận +67 Point",

		"future_debt_desc":
			"Từ hợp lệ đầu tiên nhận +45 Point cho mỗi Lượt Bỏ đã dùng",

		"full_combo_desc":
			"Nếu cả 5 từ hợp lệ, từ cuối cùng sẽ tiếp tục Chain thêm 2 lần nữa",

		"lone_word_desc":
			"Chơi 1 từ Đồng Nghĩa sẽ không tốn Lượt",

		"blueprint_desc":
			"Sử dụng vật phẩm này, chọn vào vật phẩm khác để sao chép hiệu ứng của nó",

		"yojigen_pocket_desc":
			"Nhận thêm Lượt bằng một nửa giá trị bán của các item khác",

		"over_heaven_desc":
			"Từ Đồng Nghĩa nhận x2 Mult và sẽ tăng vĩnh viễn giá trị đó lên +0.5",

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

		"copying": "Copy",

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
	
func tr_meaning(word: String) -> String:

	return WORD_MEANING.get(
		current_language,
		{}
	).get(
		word,
		word
	)
	
func auto_format(text: String) -> String:

	text = text.replace("_", " ")

	var words = text.split(" ")

	for i in range(words.size()):

		words[i] = words[i].capitalize()

	return " ".join(words)
	
func set_language(lang: String):

	current_language = lang
