
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_WORLD
var rect = Rect2(0, 0, 2560, 2240)

var enemy_dict = {
}

var enemy_ship_dict = {
}

var enemy_zone_dict = {
	"Island0": {
		"w0000": 1,
	}
}

var warp_dict = {
	"Start Town": {"x": 192, "y": 1536, "map": "maps/start_town"},
	"First Cave": {"x": 128, "y": 1600, "map": "maps/first_cave_b1"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

