
extends Node

var item_dict = {
	# restore HP
	"recover_hp_25": {
		"name": "Recover HP 25%",
		"money": 10,
		"hint": "Restore HP 25% to a player.",
		"effect": {"animation": "Heal", "hp": 25},
	},
	"recover_hp_50": {
		"name": "Recover HP 50%",
		"money": 100,
		"hint": "Restore HP 50% to a player.",
		"effect": {"animation": "Heal", "hp": 50},
	},
	"recover_hp_75": {
		"name": "Recover HP 75%",
		"money": 1000,
		"hint": "Restore HP 75% to a player.",
		"effect": {"animation": "Heal", "hp": 75},
	},
	"recover_hp_100": {
		"name": "Recover HP 100%",
		"money": 10000,
		"hint": "Restore HP 100% to a player.",
		"effect": {"animation": "Heal", "hp": 100},
	},

	# restore MP
	"recover_mp_25": {
		"name": "Recover MP 25%",
		"money": 10,
		"hint": "Restore MP 25% to a player.",
		"effect": {"animation": "Heal", "mp": 25},
	},
	"recover_mp_50": {
		"name": "Recover MP 50%",
		"money": 100,
		"hint": "Restore MP 50% to a player.",
		"effect": {"animation": "Heal", "mp": 50},
	},
	"recover_mp_75": {
		"name": "Recover MP 75%",
		"money": 1000,
		"hint": "Restore MP 75% to a player.",
		"effect": {"animation": "Heal", "mp": 75},
	},
	"recover_mp_100": {
		"name": "Recover MP 100%",
		"money": 10000,
		"hint": "Restore MP 100% to a player.",
		"effect": {"animation": "Heal", "mp": 100},
	},

	# restore HP/MP
	"recover_hpmp_25": {
		"name": "Recover HP/MP 25%",
		"money": 30,
		"hint": "Restore HP&MP 25% to a player.",
		"effect": {"animation": "Heal", "hp": 25, "mp": 25},
	},
	"recover_hpmp_50": {
		"name": "Recover HP/MP 50%",
		"money": 300,
		"hint": "Restore HP&MP 50% to a player.",
		"effect": {"animation": "Heal", "hp": 50, "mp": 50},
	},
	"recover_hpmp_75": {
		"name": "Recover HP/MP 75%",
		"money": 3000,
		"hint": "Restore HP&MP 75% to a player.",
		"effect": {"animation": "Heal", "hp": 75, "mp": 75},
	},
	"recover_hpmp_100": {
		"name": "Recover HP/MP 100%",
		"money": 30000,
		"hint": "Restore HP&MP 100% to a player.",
		"effect": {"animation": "Heal", "hp": 100, "mp": 100},
	},

	# anti-
	"antidote": {
		"name": "Antidote",
		"money": 25,
		"hint": "Remedy when a player poisoned.",
		"effect": {"animation": "Heal", "cure": 1},
	},
	"antiseptic": {
		"name": "Antiseptic",
		"money": 250,
		"hint": "Remedy when a player pass out.",
		"effect": {"animation": "Heal", "heal": 25},
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
			"hint": "Cut one enemy.",
			"effect": {"animation": "Cut", "battle": "one", "power": [15, 1, 0, 1.5]},
		},
		"slash": {
			"name": "Slash",
			"mp": 3,
			"time": 3,
			"hint": "Slash multiple targets.",
			"effect": {"animation": "Slash", "battle": "group", "power": [10, 1, 0, 1.25]},
		},
		"warp": {
			"name": "Warp Back",
			"mp": 5,
			"time": 3,
			"hint": "Warp to last town or castle.",
			"effect": {"warp": 1},
		},
		"thunder": {
			"name": "Thunder",
			"mp": 7,
			"time": 5,
			"hint": "Lightning all enemies.",
			"effect": {"animation": "Thunder", "battle": "all", "power": [75, 0, 0, 1.5]},
		},
		"heroblade": {
			"name": "Hero Blade",
			"mp": 9,
			"time": 5,
			"hint": "Attack one enemy with maximum power.",
			"effect": {"animation": "Blade", "battle": "one", "power": [0, 1.5, 0, 3], "element": 4},
		},
	},

	1: {
		# restore HP
		"recover_hp_25": {
			"name": "Recover HP 25%",
			"mp": 2,
			"time": 2,
			"hint": "Restore HP 25% to a player.",
			"effect": {"animation": "Heal", "hp": 25},
		},
		"recover_hp_50": {
			"name": "Recover HP 50%",
			"mp": 4,
			"time": 4,
			"hint": "Restore HP 50% to a player.",
			"effect": {"animation": "Heal", "hp": 50},
		},
		"recover_hp_75": {
			"name": "Recover HP 75%",
			"mp": 6,
			"time": 6,
			"hint": "Restore HP 75% to a player.",
			"effect": {"animation": "Heal", "hp": 50},
		},
		"recover_hp_100": {
			"name": "Recover HP 100%",
			"mp": 8,
			"time": 8,
			"hint": "Restore HP 100% to a player.",
			"effect": {"animation": "Heal", "hp": 100},
		},

		# restore HP all
		"recover_hp_25_all": {
			"name": "Recover HP 25% All",
			"mp": 4,
			"time": 4,
			"hint": "Restore HP 25% to all players.",
			"effect": {"animation": "Heals", "all": 1, "hp": 25},
		},
		"recover_hp_50_all": {
			"name": "Recover HP 50% All",
			"mp": 6,
			"time": 6,
			"hint": "Restore HP 50% to all players.",
			"effect": {"animation": "Heals", "all": 1, "hp": 50},
		},
		"recover_hp_75_all": {
			"name": "Recover HP 75% All",
			"mp": 8,
			"time": 8,
			"hint": "Restore HP 75% to all players.",
			"effect": {"animation": "Heals", "all": 1, "hp": 75},
		},
		"recover_hp_100_all": {
			"name": "Recover HP 100% All",
			"mp": 10,
			"time": 10,
			"hint": "Restore HP 100% to all players.",
			"effect": {"animation": "Heals", "all": 1, "hp": 100},
		},

		# anti-
		"antidote": {
			"name": "Antidote",
			"mp": 2,
			"time": 2,
			"hint": "Remedy when a player poisoned.",
			"effect": {"animation": "Heal", "cure": 1},
		},
		"antiseptic": {
			"name": "Antiseptic",
			"mp": 4,
			"time": 4,
			"hint": "Remedy when a player pass out.",
			"effect": {"animation": "Heal", "heal": 25},
		},

		# full recovery all
		"recovery_all": {
			"name": "Recovery Full All",
			"mp": 12,
			"time": 12,
			"hint": "Recover HP/Poison/Faint to all players.",
			"effect": {"animation": "Heals", "all": 1, "heal": 100, "cure": 1, "hp": 100},
		},

		# protect and shield
		"protect": {
			"name": "Protect",
			"mp": 3,
			"time": 3,
			"hint": "Protect players with attacks.",
			"effect": {"animation": "Protect", "all": 1, "block": "protect"},
		},
		"shield": {
			"name": "Shield",
			"mp": 3,
			"time": 3,
			"hint": "Protect players with magics.",
			"effect": {"animation": "Protect", "all": 1, "block": "shield"},
		},

		# attack
		"fire": {
			"name": "Fire",
			"mp": 3,
			"time": 3,
			"hint": "Attack one enemy with fire.",
			"effect": {"animation": "Fire", "battle": "one", "power": [10, 0, 1, 1.5], "element": 1},
		},
		"fire_spread": {
			"name": "Fire Spread",
			"mp": 5,
			"time": 5,
			"hint": "Attack group enemies with fire.",
			"effect": {"animation": "Fires", "battle": "group", "power": [10, 0, 1, 1.2], "element": 1},
		},
		"ice": {
			"name": "Ice",
			"mp": 3,
			"time": 3,
			"hint": "Attack one enemy with ice.",
			"effect": {"animation": "Ice", "battle": "one", "power": [10, 0, 1, 1.5], "element": 2},
		},
		"ice_spread": {
			"name": "Ice Spread",
			"mp": 5,
			"time": 5,
			"hint": "Attack group enemies with ice.",
			"effect": {"animation": "Ices", "battle": "group", "power": [10, 0, 1, 1.2], "element": 2},
		},
	},

	2: {
		# slow/speed
		"slow": {
			"name": "Slow",
			"mp": 2,
			"time": 4,
			"hint": "Slow down one enemy.",
			"effect": {"animation": "Slow", "battle": "one", "slow": 1},
		},
		"slow_all": {
			"name": "Slow All",
			"mp": 4,
			"time": 4,
			"hint": "Slow down all enemies.",
			"effect": {"animation": "Slows", "battle": "all", "slow": 1},
		},
		"speed": {
			"name": "Speed",
			"mp": 2,
			"time": 4,
			"hint": "Speed up one ally.",
			"effect": {"animation": "Speed", "speed": 1},
		},
		"speed_all": {
			"name": "Haste",
			"mp": 6,
			"time": 4,
			"hint": "Haste up all allies.",
			"effect": {"animation": "Speeds", "all": 1, "speed": 1},
		},

		# bomb
		"bomb": {
			"name": "Bomb",
			"mp": 6,
			"time": 8,
			"hint": "Attack all enemies with bomb.",
			"effect": {"animation": "Bomb", "battle": "all", "power": [30, 0, 1, 1.5]},
		},

		# whirlwind
		"wind": {
			"name": "Whirlwind",
			"mp": 9,
			"time": 8,
			"hint": "Attack all enemies with whirlwind.",
			"effect": {"animation": "Whirlwind", "battle": "all", "power": [50, 0, 1, 1.5]},
		},

		# meteor
		"meteor": {
			"name": "Meteor",
			"mp": 12,
			"time": 15,
			"hint": "Attack all enemies with meteor.",
			"effect": {"animation": "Meteor", "battle": "all", "power": [0, 0, 0, 4]},
		},
	},
}

var equip_dict = {
	0: {
		"sword": {
			"name": "Sword",
			"type": "weapon",
			"att": 10,
			"mag": 0,
			"hint": "Normal sword.",
			"effect": {"animation": "Sword0"},
		},
		"longsword": {
			"name": "Long Sword",
			"type": "weapon",
			"att": 20,
			"mag": 0,
			"hint": "A fine long-sword.",
			"effect": {"animation": "Sword0"},
		},
		"dragon_sword": {
			"name": "Dragon Sword",
			"type": "weapon",
			"att": 35,
			"mag": 0,
			"hint": "A dragon sword, absorb HP/MP.",
			"effect": {"animation": "Sword1", "absorb_hp": 1, "absorb_mp": 1},
		},
		"hero_sword": {
			"name": "Hero Sword",
			"type": "weapon",
			"att": 50,
			"mag": 0,
			"hint": "A legendary sword, absorb HP/MP.",
			"effect": {"animation": "Sword2", "absorb_hp": 3, "absorb_mp": 1, "element": 4},
		},
		"armor": {
			"name": "Armor",
			"type": "armor",
			"def": 5,
			"hint": "An ordinary armor.",
		},
		"paladin_armor": {
			"name": "Paladin Armor",
			"type": "armor",
			"def": 15,
			"hint": "A fine good armor.",
		},
		"hero_armor": {
			"name": "Hero Armor",
			"type": "armor",
			"def": 30,
			"hint": "A legendary armor, reduce damage 1/2.",
			"effect": {"reduce_hp": 50, "reduce_mp": 50},
		},
		"shield": {
			"name": "Shield",
			"type": "accessory",
			"def": 3,
			"hint": "A common shield, block rate 10%.",
			"effect": {"block": 10},
		},
		"paladin_shield": {
			"name": "Paladin Shield",
			"type": "accessory",
			"def": 12,
			"hint": "A fine good shield, block rate 30%.",
			"effect": {"block": 30},
		},
		"hero_shield": {
			"name": "Hero Shield",
			"type": "accessory",
			"def": 20,
			"hint": "A legendary shield, block rate 50%.",
			"effect": {"block": 50},
		},
	},

	1: {
		"wand": {
			"name": "Wand",
			"type": "weapon",
			"att": 5,
			"mag": 10,
			"hint": "A average wand.",
			"effect": {"animation": "Wand0"},
		},
		"starwand": {
			"name": "Star Wand",
			"type": "weapon",
			"att": 7,
			"mag": 20,
			"hint": "A star wand with cut MP usage 1/4.",
			"effect": {"animation": "Wand0", "usage_mp": 25},
		},
		"miraclewand": {
			"name": "Miracle Wand",
			"type": "weapon",
			"att": 10,
			"mag": 30,
			"hint": "A miracle wand with cut MP usage 1/2.",
			"effect": {"animation": "Wand0", "usage_mp": 50},
		},
		"robe": {
			"name": "Robe",
			"type": "armor",
			"def": 4,
			"hint": "A plain robe.",
		},
		"starrobe": {
			"name": "Star Robe",
			"type": "armor",
			"def": 10,
			"hint": "A good robe.",
		},
		"miraclerobe": {
			"name": "Miracle Robe",
			"type": "armor",
			"def": 25,
			"hint": "A miracle robe, reduce magic damage 1/3.",
			"effect": {"reduce_mp": 33},
		},
		"amulet": {
			"name": "Amulet",
			"type": "accessory",
			"def": 1,
			"hint": "An amulet with memory.",
		},
		"miracle_amulet": {
			"name": "Miracle Amulet",
			"type": "accessory",
			"def": 1,
			"hint": "A miracle amulet with walk restore MP.",
			"effect": {"walk_mp": 1}
		},
	},

	2: {
		"boomerang": {
			"name": "Boomerang",
			"type": "weapon",
			"att": 16,
			"mag": 0,
			"hint": "A nifty boomerang.",
			"effect": {"animation": "Boomerang0"},
		},
		"dress": {
			"name": "Dress",
			"type": "armor",
			"def": 4,
			"hint": "A generic dress.",
		},
		"dark_dress": {
			"name": "Dark Dress",
			"type": "armor",
			"def": 10,
			"hint": "A black dress.",
		},
		"ring": {
			"name": "Ring",
			"type": "accessory",
			"def": 0,
			"hint": "A MP regenerate ring.",
			"effect": {"regen_mp": 4}
		},
		"void_ring": {
			"name": "Void Ring",
			"type": "accessory",
			"def": 0,
			"hint": "A fast MP regenerate ring.",
			"effect": {"regen_hp": 1, "regen_mp": 8}
		},
	},
}

var monster_attack_dict = {
	"bite": {
		"name": "Bite",
		"effect": {"animation": "Bite", "power": [1, 0]},
	},
	"charge": {
		"name": "Charge",
		"effect": {"animation": "Charge", "power": [1.25, 0]},
	},
	"poison": {
		"name": "Poison",
		"effect": {"animation": "Poison", "power": [1.25, 0], "poison": 25},
	},
	"poisonhi": {
		"name": "Poison Hi",
		"effect": {"animation": "Poison", "power": [1.25, 0], "poison": 75},
	},

	"fire": {
		"name": "Fire",
		"effect": {"animation": "Fire", "power": [0, 1.25]},
	},
	"ice": {
		"name": "Ice",
		"effect": {"animation": "Ice", "power": [0, 1.25]},
	},
	"fires": {
		"name": "Fire Spread",
		"effect": {"animation": "Fires", "all": 1, "power": [0, 1.25]},
	},
	"ices": {
		"name": "Ice Spread",
		"effect": {"animation": "Ices", "all": 1, "power": [0, 1.25]},
	},

	"recover_hp_25": {
		"name": "Recover HP 25%",
		"effect": {"animation": "Heal", "hp": 25},
	},
	"recover_hp_50": {
		"name": "Recover HP 50%",
		"effect": {"animation": "Heal", "hp": 50},
	},
	"recover_hp_75": {
		"name": "Recover HP 75%",
		"effect": {"animation": "Heal", "hp": 75},
	},
	"recover_hp_100": {
		"name": "Recover HP 100%",
		"effect": {"animation": "Heal", "hp": 100},
	},
}

