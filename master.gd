
extends Node

var item_dict = {
	# restore HP
	"recover_hp_25": {
		"name": "Recover HP 25%",
		"money": 10,
		"effect": {"hp": 25},
	},
	"recover_hp_50": {
		"name": "Recover HP 50%",
		"money": 100,
		"effect": {"hp": 50},
	},
	"recover_hp_75": {
		"name": "Recover HP 75%",
		"money": 1000,
		"effect": {"hp": 75},
	},
	"recover_hp_100": {
		"name": "Recover HP 100%",
		"money": 10000,
		"effect": {"hp": 100},
	},

	# restore MP
	"recover_mp_25": {
		"name": "Recover MP 25%",
		"money": 10,
		"effect": {"mp": 25},
	},
	"recover_mp_50": {
		"name": "Recover MP 50%",
		"money": 100,
		"effect": {"mp": 50},
	},
	"recover_mp_75": {
		"name": "Recover MP 75%",
		"money": 1000,
		"effect": {"mp": 75},
	},
	"recover_mp_100": {
		"name": "Recover MP 100%",
		"money": 10000,
		"effect": {"mp": 100},
	},

	# restore HP/MP
	"recover_hpmp_25": {
		"name": "Recover HP/MP 25%",
		"money": 30,
		"effect": {"hp": 25, "mp": 25},
	},
	"recover_hpmp_50": {
		"name": "Recover HP/MP 50%",
		"money": 300,
		"effect": {"hp": 50, "mp": 50},
	},
	"recover_hpmp_75": {
		"name": "Recover HP/MP 75%",
		"money": 3000,
		"effect": {"hp": 75, "mp": 75},
	},
	"recover_hpmp_100": {
		"name": "Recover HP/MP 100%",
		"money": 30000,
		"effect": {"hp": 100, "mp": 100},
	},

	# anti-
	"antidote": {
		"name": "Antidote",
		"money": 25,
		"effect": {"cure": 1},
	},
	"antiseptic": {
		"name": "Antiseptic",
		"money": 250,
		"effect": {"heal": 25},
	},
}

var item_list_sort = [
	"recover_hp_25",
	"recover_hp_50",
	"recover_hp_75",
	"recover_hp_100",
	"recover_mp_25",
	"recover_mp_50",
	"recover_mp_75",
	"recover_mp_100",
	"recover_hpmp_25",
	"recover_hpmp_50",
	"recover_hpmp_75",
	"recover_hpmp_100",
	"antidote",
	"antiseptic",
]

var magic_dict = {
	0: {
		"cut": {
			"name": "Cut",
			"mp": 3,
			"time": 3,
			"effect": {"battle": "one"},
		},
		"slash": {
			"name": "Slash",
			"mp": 3,
			"time": 3,
			"effect": {"battle": "group"},
		},
		"warp": {
			"name": "Warp Back",
			"mp": 5,
			"time": 2,
			"effect": {"warp": 1},
		},
		"thunder": {
			"name": "Thunder",
			"mp": 7,
			"time": 5,
			"effect": {"battle": "all"},
		},
		"lightning": {
			"name": "Lightning",
			"mp": 9,
			"time": 5,
			"effect": {"battle": "one"},
		},
	},

	1: {
		# restore HP
		"recover_hp_25": {
			"name": "Recover HP 25%",
			"mp": 2,
			"time": 2,
			"effect": {"hp": 25},
		},
		"recover_hp_50": {
			"name": "Recover HP 50%",
			"mp": 4,
			"time": 4,
			"effect": {"hp": 50},
		},
		"recover_hp_75": {
			"name": "Recover HP 75%",
			"mp": 6,
			"time": 6,
			"effect": {"hp": 50},
		},
		"recover_hp_100": {
			"name": "Recover HP 100%",
			"mp": 8,
			"time": 8,
			"effect": {"hp": 100},
		},

		# restore HP all
		"recover_hp_25_all": {
			"name": "Recover HP 25% All",
			"mp": 4,
			"time": 4,
			"effect": {"all": 1, "hp": 25},
		},
		"recover_hp_50_all": {
			"name": "Recover HP 50% All",
			"mp": 6,
			"time": 6,
			"effect": {"all": 1, "hp": 50},
		},
		"recover_hp_75_all": {
			"name": "Recover HP 75% All",
			"mp": 8,
			"time": 8,
			"effect": {"all": 1, "hp": 75},
		},
		"recover_hp_100_all": {
			"name": "Recover HP 100% All",
			"mp": 10,
			"time": 10,
			"effect": {"all": 1, "hp": 100},
		},

		# anti-
		"antidote": {
			"name": "Antidote",
			"mp": 2,
			"time": 2,
			"effect": {"cure": 1},
		},
		"antiseptic": {
			"name": "Antiseptic",
			"mp": 4,
			"time": 4,
			"effect": {"heal": 25},
		},

		# full recovery all
		"recovery_all": {
			"name": "Recovery Full All",
			"mp": 12,
			"time": 12,
			"effect": {"all": 1, "heal": 100, "cure": 1, "hp": 100},
		},

		# protect and shield
		"protect": {
			"name": "Protect",
			"mp": 3,
			"time": 3,
			"effect": {"all": 1, "block": "protect"},
		},
		"shield": {
			"name": "Shield",
			"mp": 3,
			"time": 3,
			"effect": {"all": 1, "block": "shield"},
		},

		# attack
		"fire": {
			"name": "Fire",
			"mp": 3,
			"time": 3,
			"effect": {"battle": "one"},
		},
		"fire_group": {
			"name": "Fire Group",
			"mp": 5,
			"time": 5,
			"effect": {"battle": "group"},
		},
		"fire_all": {
			"name": "Fire All",
			"mp": 7,
			"time": 7,
			"effect": {"battle": "all"},
		},
		"ice": {
			"name": "Ice",
			"mp": 3,
			"time": 3,
			"effect": {"battle": "one"},
		},
		"ice_group": {
			"name": "Ice Group",
			"mp": 5,
			"time": 5,
			"effect": {"battle": "group"},
		},
		"ice_all": {
			"name": "Ice All",
			"mp": 7,
			"time": 7,
			"effect": {"battle": "all"},
		},
	},

	2: {
		# slow/speed
		"slow": {
			"name": "Slow",
			"mp": 2,
			"time": 4,
			"effect": {"battle": "one"},
		},
		"slow_all": {
			"name": "Slow All",
			"mp": 4,
			"time": 4,
			"effect": {"battle": "all"},
		},
		"speed": {
			"name": "Speed",
			"mp": 2,
			"time": 4,
			"effect": {"speed": 1},
		},
		"speed_all": {
			"name": "Haste",
			"mp": 6,
			"time": 4,
			"effect": {"all": 1, "speed": 1},
		},

		# bomb
		"bomb": {
			"name": "Bomb",
			"mp": 6,
			"time": 8,
			"effect": {"battle": "all"},
		},

		# whirlwind
		"wind": {
			"name": "Whirlwind",
			"mp": 9,
			"time": 8,
			"effect": {"battle": "all"},
		},

		# meteor
		"meteor": {
			"name": "Meteor",
			"mp": 12,
			"time": 15,
			"effect": {"battle": "all"},
		},
	},
}

var equip_dict = {
	0: {
		"sword": {
			"name": "Sword",
			"type": "weapon",
			"ap": 10,
			"mp": 0,
		},
		"longsword": {
			"name": "Long Sword",
			"type": "weapon",
			"ap": 20,
			"mp": 0,
		},
		"paladin_sword": {
			"name": "Paladin Sword",
			"type": "weapon",
			"ap": 35,
			"mp": 0,
		},
		"hero_sword": {
			"name": "Hero Sword",
			"type": "weapon",
			"ap": 50,
			"mp": 0,
		},
		"armor": {
			"name": "Armor",
			"type": "armor",
			"dp": 5,
		},
		"paladin_armor": {
			"name": "Paladin Armor",
			"type": "armor",
			"dp": 15,
		},
		"hero_armor": {
			"name": "Hero Armor",
			"type": "armor",
			"dp": 30,
		},
		"shield": {
			"name": "Shield",
			"type": "accessory",
			"dp": 3,
		},
		"paladin_shield": {
			"name": "Paladin Shield",
			"type": "accessory",
			"dp": 12,
		},
		"hero_shield": {
			"name": "Hero Shield",
			"type": "accessory",
			"dp": 20,
		},
	},

	1: {
		"wand": {
			"name": "Wand",
			"type": "weapon",
			"ap": 5,
			"mp": 10,
		},
		"firewand": {
			"name": "Fire Wand",
			"type": "weapon",
			"ap": 7,
			"mp": 20,
		},
		"icewand": {
			"name": "Ice Wand",
			"type": "weapon",
			"ap": 7,
			"mp": 20,
		},
		"miraclewand": {
			"name": "Miracle Wand",
			"type": "weapon",
			"ap": 10,
			"mp": 30,
		},
		"robe": {
			"name": "Robe",
			"type": "armor",
			"dp": 4,
		},
		"firerobe": {
			"name": "Fire Robe",
			"type": "armor",
			"dp": 10,
		},
		"icerobe": {
			"name": "Ice Robe",
			"type": "armor",
			"dp": 10,
		},
		"miraclerobe": {
			"name": "Miracle Robe",
			"type": "armor",
			"dp": 25,
		},
		"amulet": {
			"name": "Amulet",
			"type": "accessory",
			"dp": 0,
			"effect": {"regen_mp": 1}
		},
		"light_amulet": {
			"name": "Light Amulet",
			"type": "accessory",
			"dp": 0,
			"effect": {"regen_mp": 2}
		},
		"miracle_amulet": {
			"name": "Miracle Amulet",
			"type": "accessory",
			"dp": 0,
			"effect": {"regen_mp": 3, "cut_mp": 50}
		},
	},

	2: {
		"staff": {
			"name": "Staff",
			"type": "weapon",
			"ap": 3,
			"mp": 12,
		},
		"magic_staff": {
			"name": "Magic Staff",
			"type": "weapon",
			"ap": 3,
			"mp": 20,
		},
		"dress": {
			"name": "Dress",
			"type": "armor",
			"dp": 4,
		},
		"dark_dress": {
			"name": "Dark Dress",
			"type": "armor",
			"dp": 10,
		},
		"void_dress": {
			"name": "Void Dress",
			"type": "armor",
			"dp": 16,
		},
		"ring": {
			"name": "Ring",
			"type": "accessory",
			"dp": 0,
			"effect": {"regen_mp": 4}
		},
		"void_ring": {
			"name": "Void Ring",
			"type": "accessory",
			"dp": 0,
			"effect": {"regen_mp": 8}
		},
	},
}

