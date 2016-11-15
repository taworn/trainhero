
extends Node

const LIMIT_ITEMS = 9

var new = false  # is change scene or go back
var scripting_continue = null  # has scripting cross scenes

# current persistence state
var persist = restart_game()

var players_dict = {
	persist.players[0].name: 0,
	persist.players[1].name: 1,
	persist.players[2].name: 2,
}

func restart_game():
	var persist = {
		# level, experience and gold
		"level": 0,
		"exp": 0,
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
				"mp": 0,
				"ap": 10,
				"dp": 10,
				"sp": 10,
				"weapon": null,
				"armor": null,
				"accessory": null,
				"magics": {
				},
			},
			{
				"name": "Rydia",
				"avail": true,
				"faint": false,
				"poison": true,
				"hp_max": 75,
				"hp": 75,
				"mp_max": 50,
				"mp": 1,
				"ap": 8,
				"dp": 8,
				"sp": 8,
				"weapon": null,
				"armor": null,
				"accessory": null,
				"magics": {
				},
			},
			{
				"name": "Unknown",
				"avail": true,
				"faint": true,
				"poison": false,
				"hp_max": 50,
				"hp": 0,
				"mp_max": 75,
				"mp": 7,
				"ap": 8,
				"dp": 8,
				"sp": 8,
				"weapon": null,
				"armor": null,
				"accessory": null,
				"magics": {
				},
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
			"map": "maps/test0",
			"x": 0,
			"y": 128,
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

func save_game(fileName):
	var f = File.new()
	f.open(fileName, File.WRITE)
	f.store_line(persist.to_json())
	f.close()
	print("saved game: persist=", persist.to_json())

func load_game(fileName):
	var f = File.new()
	if !f.file_exists(fileName):
		print("no game saved, new game instead")
		return new_game()
	f.open(fileName, File.READ)
	if (!f.eof_reached()):
	    persist.parse_json(f.get_line())
	f.close()
	new = true
	print("loaded game: persist=", persist.to_json())
	get_tree().change_scene("res://" + persist.map + ".tscn")

func back():
	get_tree().change_scene("res://" + persist.map + ".tscn")

func warp_to(x, y, map):
	if state.persist.ship.cruising:
		persist.ship.map = map
		persist.ship.x = x
		persist.ship.y = y
	persist.map = map
	persist.x = x
	persist.y = y
	persist.npcs.clear()
	new = true
	print("warp to: map=", persist.map, " (", persist.x, ", ", persist.y, ")")
	get_tree().change_scene("res://" + persist.map + ".tscn")

func fight():
	get_tree().change_scene("res://battle.tscn")

func item_check(id):
	var players = []
	var effect = master.item_dict[id].effect
	for i in range(3):
		var can_use = false
		if persist.players[i].avail:
			if !persist.players[i].faint:
				if effect.has("hp"):
					if persist.players[i].hp < persist.players[i].hp_max:
						can_use = true
				if effect.has("mp"):
					if persist.players[i].mp < persist.players[i].mp_max:
						can_use = true
				if effect.has("cure"):
					if persist.players[i].poison:
						can_use = true
			else:
				if effect.has("heal"):
					if persist.players[i].faint:
						can_use = true
			if can_use:
				players.append(i)
	return players

func item_use(id, player):
	var effect = master.item_dict[id].effect
	var used = false
	if player.avail:
		if !player.faint:
			if effect.has("hp"):
				if player.hp < player.hp_max:
					player.hp += round(effect["hp"] * player.hp_max / 100)
					if player.hp > player.hp_max:
						player.hp = player.hp_max
					used = true
			if effect.has("mp"):
				if player.mp < player.mp_max:
					player.mp += round(effect["mp"] * player.mp_max / 100)
					if player.mp > player.mp_max:
						player.mp = player.mp_max
					used = true
			if effect.has("cure"):
				if player.poison:
					player.poison = false
					used = true
		else:
			if effect.has("heal"):
				if player.faint:
					player.faint = false
					player.hp = round(effect["heal"] * player.hp_max / 100)
					used = true
	persist.items[id] -= 1
	return used

