
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_WORLD
var rect = Rect2(0, 0, 6144, 5120)

var enemy_dict = {
}

var enemy_ship_dict = {
}

var enemy_zone_dict = {
	"Island0": {
		"w0000": 1,
	},
	"Island1": {
		"w0100": 1,
		"w0101": 1,
	},
}

var warp_dict = {
	"Start Town": {"x": 192, "y": 1536, "map": "maps/start_town"},
	"First Cave": {"x": 0, "y": 2304, "map": "maps/first_cave_b1"},
	"First Cave Back": {"x": 512, "y": 64, "map": "maps/first_cave_b2"},
	"North Town": {"x": 320, "y": 640, "map": "maps/north_town"},
	"North Gateway": {"x": 384, "y": 640, "map": "maps/north_gateway"},
	"North Gateway Back": {"x": 384, "y": 1216, "map": "maps/north_gateway"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

