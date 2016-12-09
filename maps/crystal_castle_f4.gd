
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
	"To F3": {"x": 1216, "y": 704, "map": "maps/crystal_castle_f3"},
	"To F5": {"x": 1216, "y": 960, "map": "maps/crystal_castle_f5"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

