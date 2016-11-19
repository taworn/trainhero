
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_WORLD
var rect = Rect2(0, 0, 2560, 2240)

var enemy_dict = {
}

var enemy_ship_dict = {
	"fish0": 2,
	"fish1": 1,
}

var enemy_zone_dict = {
	"Island0": {
		"slimes0": 1,
	}
}

var warp_dict = {
	"Test0": {"x": 128, "y": 128, "map": "maps/test0"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

