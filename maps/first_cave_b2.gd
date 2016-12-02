
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0000": 1,
}

var warp_dict = {
	"To B1": {"x": 1472, "y": 704, "map": "maps/first_cave_b1"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
	"Recover": [
		"HP/MP (will be) full",
	],
}

