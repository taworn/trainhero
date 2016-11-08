
extends Node2D

var state = {}  # current state

var paused = false  # paused entry scene
var new = false     # is change scene or go back
var back_fade = null

func start_game():
	state = {
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
		"key-items": {
		},
		
		# where are you
		"map": null,
		"x": null,
		"y": null,
		"face": null,
		"npcs": {
		},
	}
	state.map = "maps/test0"
	state.x = 96
	state.y = 96
	state.face = "down"
	new = true
	print("started, state=", state)
	get_tree().change_scene("res://" + state.map + ".tscn")

func save_game(fileName):
	var f = File.new()
	f.open(fileName, File.WRITE)
	f.store_line(state.to_json())
	f.close()
	print("saved, state=", state)

func load_game(fileName):
	var f = File.new()
	if !f.file_exists(fileName):
		return start_game()
	f.open(fileName, File.READ)
	if (!f.eof_reached()):
	    state.parse_json(f.get_line())
	f.close()
	new = true
	print("loaded, state=", state)
	get_tree().change_scene("res://" + state.map + ".tscn")

func back():
	get_tree().change_scene("res://" + state.map + ".tscn")

func warp_to(x, y, map):
	state.map = map
	state.x = x
	state.y = y
	state.npcs.clear()
	new = true
	print("warp to, map=", state.map, " (", state.x, ", ", state.y, ")")
	get_tree().change_scene("res://" + state.map + ".tscn")

