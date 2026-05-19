extends Node
class_name ItemDB

static func get_rarity_value(rarity):

	match rarity:
		"common":
			return 1

		"uncommon":
			return 2

		"rare":
			return 5

		"legendary":
			return 10

	return 0
	
static var REWARD_RARITY_WEIGHTS := {
	"common": 62,
	"uncommon": 29,
	"rare": 8,
	"legendary": 1,
}

static var ITEMS = {

	# =====================
	# COMMON
	# =====================

	"synonym_codex": {
		"id": "synonym_codex",
		"name": "Synonym Codex",
		"rarity": "common",
		"description": "Synonym relations gain +10 Point"
	},

	"wildcard": {
		"id": "wildcard",
		"name": "Wildcard",
		"rarity": "common",
		"description": "Gain +1 extra Mult each word"
	},
	
	"cappuccino": {
		"id": "cappuccino",
		"name": "Cappuccino",
		"rarity": "common",
		"description": "B1 and B2 words gain +15 Point"
	},
	
	"intensifier": {
		"id": "intensifier",
		"name": "Intensifier",
		"rarity": "common",
		"description": "The first Degree relation each turn gains +3 Final Mult"
	},
	
	"extra_caffeine": {
		"id": "extra_caffeine",
		"name": "Extra Caffeine",
		"rarity": "common",
		"description": "First valid word each turn gains +25 Point"
	},
	
	"handy_shortcut": {
		"id": "handy_shortcut",
		"name": "Handy Shortcut",
		"rarity": "common",
		"description": "First chain multiplier applies immediately"
	},
	
	"family_guide": {
		"id": "family_guide",
		"name": "Family Guide",
		"rarity": "common",
		"description": "Family relations gain +20 Point"
	},

	"phantom_hand": {
		"id": "phantom_hand",
		"name": "Phantom Hand",
		"rarity": "common",
		"description": "First fail each turn does not reset chain"
	},
	
	"language_glitch": {
		"id": "language_glitch",
		"name": "Language Glitch",
		"rarity": "uncommon",
		"description": "Antonym relations are also treated as Synonym relations"
	},

	"golden_ratio": {
		"id": "golden_ratio",
		"name": "Golden Ratio",
		"rarity": "uncommon",
		"description": "Gain +2 permanent Point bonus whenever you play a valid word"
	},
	
	"scholars_thesis": {
		"id": "scholars_thesis",
		"name": "Scholar's Thesis",
		"rarity": "uncommon",
		"description": "C1 and C2 words gain +2 Mult"
	},

	"yin_yang": {
		"id": "yin_yang",
		"name": "Yin and Yang",
		"rarity": "uncommon",
		"description": "Antonym relations gain +3 Final Mult"
	},
	
	"magnetic_force": {
		"id": "magnetic_force",
		"name": "Magnetic Force",
		"rarity": "uncommon",
		"description": "If 2 consecutive words share the same relation type, gain +40 Point"
	},

	"future_debt": {
		"id": "future_debt",
		"name": "Future Debt",
		"rarity": "uncommon",
		"description": "Your first valid word each turn gains +45 Point for each Discard used"
	},
	
	"full_combo": {
		"id": "full_combo",
		"name": "Full Combo",
		"rarity": "rare",
		"description": "If all 5 played words are valid, the final word continues the chain two more"
	},

	"lone_word": {
		"id": "lone_word",
		"name": "Lone Word",
		"rarity": "rare",
		"description": "Playing only 1 Synonym word costs no Turn"
	},
	
	"blueprint": {
		"id": "blueprint",
		"name": "Blueprint",
		"rarity": "rare",
		"description": "Click this item, then choose another item to copy its effect"
	},
	
	"yojigen_pocket": {
		"id": "yojigen_pocket",
		"name": "Yojigen Pocket",
		"rarity": "rare",
		"description": "Gain bonus Turns each round equal to half total rarity value of your other items"
	},
	
	"over_heaven": {
		"id": "over_heaven",
		"name": "Over Heaven",
		"rarity": "legendary",
		"description": "Gain x2 Final Mult. Each Synonym permanently increases it by +0.5"
	},
	
	"infinite_paradox": {
		"id": "infinite_paradox",
		"name": "Infinite Paradox",
		"rarity": "legendary",
		"description": "Chain never ends unless you fail"
	},
}

static func get_random_reward(excluded_ids: Array = []) -> Dictionary:

	var pools = {
		"common": [],
		"uncommon": [],
		"rare": [],
		"legendary": []
	}

	for item in ITEMS.values():

		var id = item.get("id", "")

		if id == "":
			continue

		if id in excluded_ids:
			continue

		var rarity = item.get("rarity", "common")

		if pools.has(rarity):
			pools[rarity].append(item)

	var available_rarities = []
	var total_weight = 0

	for rarity in ["common", "uncommon", "rare", "legendary"]:

		if pools[rarity].size() <= 0:
			continue

		available_rarities.append(rarity)
		total_weight += int(REWARD_RARITY_WEIGHTS[rarity])

	if total_weight <= 0:
		return {}

	var roll = randi() % total_weight

	var acc = 0
	var chosen_rarity = ""

	for rarity in available_rarities:

		acc += int(REWARD_RARITY_WEIGHTS[rarity])

		if roll < acc:
			chosen_rarity = rarity
			break

	if chosen_rarity == "":
		return {}

	var candidates = pools[chosen_rarity]

	if candidates.size() <= 0:
		return {}

	return candidates[randi() % candidates.size()]


static func get_random_rewards(count := 3, excluded_ids: Array = []) -> Array:

	var result = []

	var used_ids = excluded_ids.duplicate()

	for i in range(count):

		var reward = get_random_reward(used_ids)

		if reward.is_empty():
			break

		result.append(reward)

		used_ids.append(reward.get("id", ""))

	return result
