
extends Node2D

var data = {
	"name": "Voodoo Man",
	"hp_max": 400,
	"hp": 400,
	"att": 30,
	"mag": 33,
	"def": 15,
	"spd": 8,
	"exp": 300,
	"gold": 800,
	"items": {
		"recover_hp_100": 100,
		"recover_mp_100": 100,
		"recover_hpmp_75": 100,
		"recover_hpmp_100": 100,
	},
	"equips": [
		"miraclerobe",
	],
	"attacks": {
		"recover_hp_25": 2,
		"recover_hp_50": 1,
		"ices": 2,
		"poisonhi": 2,
	},
	"element": master.ELEMENT_ICE,
}

