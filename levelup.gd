
extends Node

var list = [
	# lv 1-5
	{"exp": 1},
	{"exp": 4},
	{"exp": 5,
		0: [
			"cut",
			"slash",
		],
	},
	{"exp": 10},
	{"exp": 15,
		1: [
			"recover_hp_25",
		],
	},

	# lv 6-10
	{"exp": 20},
	{"exp": 30,
		1: [
			"fire",
			"ice",
		],
	},
	{"exp": 35},
	{"exp": 40},
	{"exp": 50,
		0: [
			"warp",
		],
	},
]

var level_hpmp = [
	{"hp_add": 3, "mp_add": 1},
	{"hp_add": 2, "mp_add": 2},
	{"hp_add": 1, "mp_add": 3},
]

func exp_to_level(e):
	var sum = 0
	var i = 0
	while i < list.size():
		if sum + list[i]["exp"] <= e:
			sum += list[i]["exp"]
			i += 1
		else:
			break
	return i

