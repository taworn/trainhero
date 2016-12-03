
extends Node

var list = [
	# lv 1-5
	{"exp": 1},
	{"exp": 4},
	{"exp": 5, 0: ["cut", "slash"]},
	{"exp": 10, 1: ["recover_hp_25"]},
	{"exp": 15},

	# lv 6-10
	{"exp": 20},
	{"exp": 30, 1: ["fire", "ice"]},
	{"exp": 35, 1: ["recover_hp_50"]},
	{"exp": 40, 1: ["antidote"]},
	{"exp": 50, 0: ["warp"]},

	# lv 11-15
	{"exp": 60, 2: ["slow", "speed"]},
	{"exp": 70, 1: ["fire_spread", "ice_spread", "recover_hp_75", "recover_hp_25_all"]},
	{"exp": 80},
	{"exp": 90, 2: ["slow_all", "speed_all"]},
	{"exp": 100, 1: ["antiseptic"]},

	# lv 16-20
	{"exp": 110, 1: ["recover_hp_100", "recover_hp_50_all"]},
	{"exp": 120, 2: ["bomb"]},
	{"exp": 130, 1: ["protect"]},
	{"exp": 140, 2: ["wind"]},
	{"exp": 150, 1: ["recover_hp_75_all"]},

	# lv 21-25
	{"exp": 160, 0: ["thunder"]},
	{"exp": 170},
	{"exp": 180},
	{"exp": 190, 1: ["recover_hp_100_all"]},
	{"exp": 200},

	# lv 26-30
	{"exp": 210},
	{"exp": 220},
	{"exp": 230, 1: ["recovery_all"]},
	{"exp": 240},
	{"exp": 250, 0: ["heroblade"], 2: ["meteor"]},
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

