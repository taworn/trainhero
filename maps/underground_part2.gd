
extends Node2D

func _ready():
	#get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0700": 1,
	"d0701": 1,
	"d0702": 1,
}

var warp_dict = {
	"Back": {"x": 704, "y": 832, "map": "maps/underground_part1"},
	"Next": {"x": 1088, "y": 960, "map": "maps/underground_part3"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

