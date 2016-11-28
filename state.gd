
extends Node

const LIMIT_ITEMS = 9

var new = false  # is change scene or go back
var scripting_continue = null  # has scripting cross scenes
var enemies_group_file = ""
var battle_background = ""

# current persistence state
var persist = restart_game()

var player_dict = {
	persist.players[0].name: 0,
	persist.players[1].name: 1,
	persist.players[2].name: 2,
}

func restart_game():
	var persist = {
		# level, experience and gold
		"level": 55,
		"experience": 555555,
		"gold": 55555,

		# players
		"players": [
			{
				"name": "Hero",
				"avail": true,
				"faint": false,
				"poison": false,
				"hp_max": 100,
				"hp": 1,
				"mp_max": 25,
				"mp": 25,
				"att": 10,
				"mag": 0,
				"def": 10,
				"spd": 12,
				"weapon": "sword",
				"armor": "armor",
				"accessory": "shield",
				"magics": [
					"cut",
					"slash",
					"warp",
					"thunder",
					"heroblade",
				],
				"equips": [
					"sword",
					"longsword",
					"dragon_sword",
					"hero_sword",
					"armor",
					"paladin_armor",
					"hero_armor",
					"shield",
					"paladin_shield",
					"hero_shield",
				],
			},
			{
				"name": "Rydia",
				"avail": true,
				"faint": false,
				"poison": true,
				"hp_max": 75,
				"hp": 30,
				"mp_max": 50,
				"mp": 49,
				"att": 7,
				"mag": 10,
				"def": 8,
				"spd": 11,
				"weapon": "wand",
				"armor": "robe",
				"accessory": "amulet",
				"magics": [
					"recover_hp_25",
					"recover_hp_50",
					"recover_hp_75",
					"recover_hp_100",
					"recover_hp_25_all",
					"recover_hp_50_all",
					"recover_hp_75_all",
					"recover_hp_100_all",
					"antidote",
					"antiseptic",
					"recovery_all",
					"protect",
					"shield",
					"fire",
					"fire_spread",
					"ice",
					"ice_spread",
				],
				"equips": [
					"wand",
					"starwand",
					"miraclewand",
					"robe",
					"starrobe",
					"miraclerobe",
					"amulet",
					"miracle_amulet",
				],
			},
			{
				"name": "Nadia",
				"avail": true,
				"faint": true,
				"poison": false,
				"hp_max": 50,
				"hp": 0,
				"mp_max": 75,
				"mp": 65,
				"att": 8,
				"mag": 0,
				"def": 7,
				"spd": 8,
				"weapon": "boomerang",
				"armor": "dress",
				"accessory": "ring",
				"magics": [
					"slow",
					"slow_all",
					"speed",
					"speed_all",
					"bomb",
					"wind",
					"meteor",
				],
				"equips": [
					"boomerang",
					"dress",
					"dark_dress",
					"ring",
					"void_ring",
				],
			},
		],

		# items, key items and others
		"items": {
			"recover_hp_25": 0,
			"recover_hp_50": 0,
			"recover_hp_75": 0,
			"recover_hp_100": 0,
			"recover_mp_25": 0,
			"recover_mp_50": 0,
			"recover_mp_75": 0,
			"recover_mp_100": 0,
			"recover_hpmp_25": 0,
			"recover_hpmp_50": 0,
			"recover_hpmp_75": 0,
			"recover_hpmp_100": 0,
			"antidote": 0,
			"antiseptic": 0,
		},
		"keys": [
		],
		"equipments": [
		],
		"treasures": {
		},
		"quests": {
		},

		# where are you
		"map": null,
		"x": 128,
		"y": 0,
		"face": "up",
		"ship": {
			"cruising": false,
			"map": "maps/world",
			"x": 512,
			"y": 320,
			"face": "down",
		},

		# where all NPCs in current map
		"npcs": {
		},
	}
	return persist

func start_game():
	new = true
	print("start game: persist=", persist.to_json())

func save_game(filename):
	var f = File.new()
	f.open(filename, File.WRITE)
	f.store_line(persist.to_json())
	f.close()
	print("saved game: persist=", persist.to_json())

func load_game(filename):
	var f = File.new()
	if !f.file_exists(filename):
		print("no game saved, new game instead")
		return new_game()
	f.open(filename, File.READ)
	if (!f.eof_reached()):
		persist.parse_json(f.get_line())
	f.close()
	new = true
	print("loaded game: persist=", persist.to_json())
	get_tree().change_scene("res://" + persist.map + ".tscn")

func back():
	get_tree().change_scene("res://" + persist.map + ".tscn")

func warp_to(x, y, map, retain_npcs):
	if state.persist.ship.cruising:
		persist.ship.map = map
		persist.ship.x = x
		persist.ship.y = y
	persist.map = map
	persist.x = x
	persist.y = y
	if !retain_npcs:
		persist.npcs.clear()
	new = true
	print("warp to: map=", persist.map, " (", persist.x, ", ", persist.y, ")")
	get_tree().change_scene("res://" + persist.map + ".tscn")

func fight(battle, background):
	enemies_group_file = battle
	battle_background = background
	get_tree().change_scene("res://battle.tscn")

