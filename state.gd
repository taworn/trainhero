
extends Node

var new = false  # is change scene or go back

# current persistence state
var persist = restart_game()

func restart_game():
	var persist = {
		# level, experience and gold
		"level": 0,
		"exp": 0,
		"gold": 999999999,
	
		# users
		"hero": {
			"avail": true,
			"down": false,
			"hp": 100,
			"mp": 20,
			"ap": 10,
			"dp": 10,
			"sp": 10,
			"weapon": null,
			"armor": null,
			"accessory": null,
			"magics": {
			},
		},
		"heroine0": {
			"avail": false,
			"down": false,
			"hp": 70,
			"mp": 50,
			"ap": 8,
			"dp": 8,
			"sp": 8,
			"weapon": null,
			"armor": null,
			"accessory": null,
			"magics": {
			},
		},
		"heroine1": {
			"avail": false,
			"down": false,
			"hp": 50,
			"mp": 70,
			"ap": 8,
			"dp": 8,
			"sp": 8,
			"weapon": null,
			"armor": null,
			"accessory": null,
			"magics": {
			},
		},
	
		# items
		"items": {
		},
		"keys": [
		],
		"treasures": {
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

func new_game():
	new = true
	print("new game: persist=", persist.to_json())

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
	persist.map = map
	persist.x = x
	persist.y = y
	persist.npcs.clear()
	new = true
	print("warp to: map=", persist.map, " (", persist.x, ", ", persist.y, ")")
	get_tree().change_scene("res://" + persist.map + ".tscn")

