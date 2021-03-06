
extends Node2D

func _ready():
	var audio = load("res://musics/Final Fantasy 3 - Sylx Tower.ogg")
	get_node("MusicPlayer").set_stream(audio)
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0600": 1,
	"d0601": 1,
	"d0602": 1,
}

var warp_dict = {
	"To F1": {"x": 1216, "y": 704, "map": "maps/crystal_castle_f1"},
	"To F3": {"x": 1216, "y": 960, "map": "maps/crystal_castle_f3"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
	"Treasure1": {
		"items": [
			"recover_hp_100",
			"recover_mp_100",
			"recover_hpmp_100",
			"antiseptic",
		],
		"keys": [
		],
		"equips": [
		],
	},
}

var dialog_dict = {
}

