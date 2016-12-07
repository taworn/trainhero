
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0200": 1,
	"d0201": 1,
	"d0202": 1,
}

var warp_dict = {
	"To B1": {"x": 1792, "y": 1600, "map": "maps/cave_fire_b1"},
	"To B3": {"x": 512, "y": 384, "map": "maps/cave_fire_b3"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

