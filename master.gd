
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
			"effect": {"battle": 1},
		},
		"slash": {
			"name": "Slash",
			"mp": 3,
			"effect": {"battle": 1},
		},
		"warp": {
			"name": "Warp Back",
			"mp": 5,
			"effect": {"warp": 1},
		},
		"thunder": {
			"name": "Thunder",
			"mp": 7,
			"effect": {"battle": 1},
		},
		"lightning": {
			"name": "Lightning",
			"mp": 9,
			"effect": {"battle": 1},
		},
	},

	1: {
		# restore HP
		"recover_hp_25": {
			"name": "Recover HP 25%",
			"mp": 2,
			"effect": {"hp": 25},
		},
		"recover_hp_50": {
			"name": "Recover HP 50%",
			"mp": 4,
			"effect": {"hp": 50},
		},
		"recover_hp_75": {
			"name": "Recover HP 75%",
			"mp": 6,
			"effect": {"hp": 50},
		},
		"recover_hp_100": {
			"name": "Recover HP 100%",
			"mp": 8,
			"effect": {"hp": 100},
		},

		# restore HP all
		"recover_hp_25_all": {
			"name": "Recover HP 25% All",
			"mp": 4,
			"effect": {"all": 1, "hp": 25},
		},
		"recover_hp_50_all": {
			"name": "Recover HP 50% All",
			"mp": 6,
			"effect": {"all": 1, "hp": 50},
		},
		"recover_hp_75_all": {
			"name": "Recover HP 75% All",
			"mp": 8,
			"effect": {"all": 1, "hp": 75},
		},
		"recover_hp_100_all": {
			"name": "Recover HP 100% All",
			"mp": 10,
			"effect": {"all": 1, "hp": 100},
		},

		# anti-
		"antidote": {
			"name": "Antidote",
			"mp": 2,
			"effect": {"cure": 1},
		},
		"antiseptic": {
			"name": "Antiseptic",
			"mp": 4,
			"effect": {"heal": 25},
		},

		# full recovery all
		"recovery_all": {
			"name": "Recovery Full",
			"mp": 12,
			"effect": {"all": 1, "heal": 100, "cure": 1, "hp": 100},
		},

		# protect
		"protect": {
			"name": "Protect",
			"mp": 3,
			"effect": {"battle": 1},
		},
		"shield": {
			"name": "Shield",
			"mp": 3,
			"effect": {"battle": 1},
		},

		# attack
		"fire": {
			"name": "Fire",
			"mp": 3,
			"effect": {"battle": 1},
		},
		"fire_group": {
			"name": "Fire Group",
			"mp": 5,
			"effect": {"battle": 1},
		},
		"fire_all": {
			"name": "Fire All",
			"mp": 7,
			"effect": {"battle": 1},
		},
		"ice": {
			"name": "Ice",
			"mp": 3,
			"effect": {"battle": 1},
		},
		"ice_group": {
			"name": "Ice Group",
			"mp": 5,
			"effect": {"battle": 1},
		},
		"ice_all": {
			"name": "Ice All",
			"mp": 7,
			"effect": {"battle": 1},
		},
	},

	2: {
		# slow/speed
		"slow": {
			"name": "Slow",
			"mp": 2,
			"effect": {"battle": 1},
		},
		"slow_all": {
			"name": "Slow All",
			"mp": 4,
			"effect": {"battle": 1},
		},
		"speed": {
			"name": "Speed",
			"mp": 2,
			"effect": {"battle": 1},
		},
		"speed_all": {
			"name": "Haste",
			"mp": 6,
			"effect": {"battle": 1},
		},

		# bomb
		"bomb": {
			"name": "Bomb",
			"mp": 6,
			"effect": {"battle": 1},
		},

		# whirlwind
		"wind": {
			"name": "Whirlwind",
			"mp": 9,
			"effect": {"battle": 1},
		},

		# meteor
		"meteor": {
			"name": "Meteor",
			"mp": 12,
			"effect": {"battle": 1},
		},
	},
}

var sword_dict = {
	"sword": {
		"name": "Sword",
	},
	"longsword": {
		"name": "Long Sword",
	},
	"thunder_sword": {
		"name": "Thunder Sword",
	},
	"lightning_sword": {
		"name": "Lightning Sword",
	},
}

var armor_dict = {
	"armor": {
		"name": "Armor",
	},
	"paladin_armor": {
		"name": "Paladin Armor",
	},
	"lightning_armor": {
		"name": "Lightning Armor",
	},
}

var shield_dict = {
	"shield": {
		"name": "Shield",
	},
	"paladin_shield": {
		"name": "Paladin Shield",
	},
	"lightning_shield": {
		"name": "Lightning Shield",
	},
}

var wand_dict = {
	"wand": {
		"name": "Wand",
	},
	"firewand": {
		"name": "Fire Wand",
	},
	"icewand": {
		"name": "Ice Wand",
	},
	"miraclewand": {
		"name": "Miracle Wand",
	},
}

var robe_dict = {
	"robe": {
		"name": "Robe",
	},
	"firerobe": {
		"name": "Fire Robe",
	},
	"icerobe": {
		"name": "Ice Robe",
	},
	"miraclerobe": {
		"name": "Miracle Robe",
	},
}

var amulet_dict = {
	"amulet": {
		"name": "Amulet",
	},
	"light_amulet": {
		"name": "Light Amulet",
	},
	"miracle_amulet": {
		"name": "Miracle Amulet",
	},
}

var staff_dict = {
	"staff": {
		"name": "Staff",
	},
	"magic_staff": {
		"name": "Magic Staff",
	},
}

var dress_dict = {
	"dress": {
		"name": "Dress",
	},
	"dark_dress": {
		"name": "Dark Dress",
	},
	"void_dress": {
		"name": "Void Dress",
	},
}

var ring_dict = {
	"ring": {
		"name": "Ring",
	},
	"void_ring": {
		"name": "Void Ring",
	},
}

