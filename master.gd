
extends Node

var item_dict = {
	# restore HP
	"recover_hp_25": {
		"name": "Recover HP 25%",
		"money": 10,
	},
	"recover_hp_50": {
		"name": "Recover HP 50%",
		"money": 100,
	},
	"recover_hp_75": {
		"name": "Recover HP 75%",
		"money": 1000,
	},
	"recover_hp_100": {
		"name": "Recover HP 100%",
		"money": 10000,
	},

	# restore MP
	"recover_mp_25": {
		"name": "Recover MP 25%",
		"money": 10,
	},
	"recover_mp_50": {
		"name": "Recover MP 50%",
		"money": 100,
	},
	"recover_mp_75": {
		"name": "Recover MP 75%",
		"money": 1000,
	},
	"recover_mp_100": {
		"name": "Recover MP 100%",
		"money": 10000,
	},

	# restore HP/MP
	"recover_hpmp_25": {
		"name": "Recover HP/MP 25%",
		"money": 50,
	},
	"recover_hpmp_50": {
		"name": "Recover HP/MP 50%",
		"money": 500,
	},
	"recover_hpmp_75": {
		"name": "Recover HP/MP 75%",
		"money": 5000,
	},
	"recover_hpmp_100": {
		"name": "Recover HP/MP 100%",
		"money": 50000,
	},

	# anti-
	"antidote": {
		"name": "Antidote",
		"money": 50,
	},
	"antiseptic": {
		"name": "Antiseptic",
		"money": 500,
	},
}

var magic_dict = {
	0: {
		"cut": {
			"name": "Cut",
			"mp": 2,
		},
		"slash": {
			"name": "Slash",
			"mp": 2,
		},
		"thunder": {
			"name": "Thunder",
			"mp": 4,
		},
		"lightning": {
			"name": "Lightning",
			"mp": 9,
		},
	},

	1: {
		# restore HP
		"recover_hp_25": {
			"name": "Recover HP 25%",
			"mp": 2,
		},
		"recover_hp_50": {
			"name": "Recover HP 50%",
			"mp": 4,
		},
		"recover_hp_75": {
			"name": "Recover HP 75%",
			"mp": 6,
		},
		"recover_hp_100": {
			"name": "Recover HP 100%",
			"mp": 8,
		},

		# anti-
		"antidote": {
			"name": "Antidote",
			"mp": 3,
		},
		"antiseptic": {
			"name": "Antiseptic",
			"mp": 9,
		},

		# protect
		"protect": {
			"name": "Protect",
			"mp": 3,
		},
		"shield": {
			"name": "Shield",
			"mp": 3,
		},

		# attack
		"fire": {
			"name": "Fire",
			"mp": 2,
		},
		"fireall": {
			"name": "Fire All",
			"mp": 4,
		},
		"ice": {
			"name": "Ice",
			"mp": 2,
		},
		"iceall": {
			"name": "Ice All",
			"mp": 4,
		},
	},

	2: {
		# slow/speed
		"slow": {
			"name": "Slow",
			"mp": 2,
		},
		"speed": {
			"name": "Speed",
			"mp": 2,
		},

		# bomb
		"bomb": {
			"name": "Bomb",
			"mp": 6,
		},

		# whirlwind
		"wind": {
			"name": "Whirlwind",
			"mp": 9,
		},

		# meteor
		"meteor": {
			"name": "Meteor",
			"mp": 12,
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

