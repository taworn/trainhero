
extends Node

const LIMIT_ITEMS = 9

var new = false  # is change scene or go back
var scripting_continue = null  # has scripting cross scenes
var enemies_group_file = ""
var battle_background = ""
var battle_boss = false

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
		"level": 0,
		"experience": 0,
		"gold": 0,

		# players
		"players": [
			{
				"name": "Hero",
				"avail": true,
				"faint": false,
				"poison": false,
				"hp_max": 75,
				"hp": 75,
				"mp_max": 25,
				"mp": 25,
				"att": 5,
				"mag": 0,
				"def": 5,
				"spd": 12,
				"weapon": "sword",
				"armor": "armor",
				"accessory": "shield",
				"magics": [
				],
				"equips": [
					"sword",
					"armor",
					"shield",
				],
			},
			{
				"name": "Rydia",
				"avail": false,
				"faint": false,
				"poison": false,
				"hp_max": 50,
				"hp": 50,
				"mp_max": 50,
				"mp": 50,
				"att": 3,
				"mag": 5,
				"def": 4,
				"spd": 10,
				"weapon": "wand",
				"armor": "robe",
				"accessory": "amulet",
				"magics": [
				],
				"equips": [
					"wand",
					"robe",
					"amulet",
				],
			},
			{
				"name": "Nadia",
				"avail": false,
				"faint": false,
				"poison": false,
				"hp_max": 40,
				"hp": 40,
				"mp_max": 60,
				"mp": 60,
				"att": 4,
				"mag": 0,
				"def": 3,
				"spd": 8,
				"weapon": "boomerang",
				"armor": "dress",
				"accessory": "ring",
				"magics": [
				],
				"equips": [
					"boomerang",
					"dress",
					"ring",
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
			"x": 576,
			"y": 448,
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

func gameover():
	get_tree().change_scene("res://gameover.tscn")

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

func fight(battle, background, boss):
	enemies_group_file = battle
	battle_background = background
	battle_boss = boss
	get_tree().change_scene("res://battle.tscn")

