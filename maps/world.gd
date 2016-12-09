
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_WORLD
var rect = Rect2(0, 0, 6144, 5120)

var enemy_dict = {
}

var enemy_ship_dict = {
	"w1000": 1,
	"w1001": 1,
	"w1002": 1,
	"w1003": 1,
	"w1004": 1,
}

var enemy_zone_dict = {
	"Island0": {
		"w0000": 1,
	},
	"Island1": {
		"w0100": 1,
		"w0101": 1,
	},
	"Island2": {
		"w0200": 1,
		"w0201": 1,
		"w0202": 1,
		"w0203": 1,
	},
	"Island3": {
		"w0300": 1,
		"w0301": 1,
	},
	"Island4": {
		"w0400": 1,
		"w0401": 1,
	},
	"Island5": {
		"w0500": 2,
		"w0501": 1,
	},
}

var warp_dict = {
	"Start Town": {"x": 192, "y": 1536, "map": "maps/start_town"},
	"First Cave": {"x": 0, "y": 2304, "map": "maps/first_cave_b1"},
	"First Cave Back": {"x": 512, "y": 64, "map": "maps/first_cave_b2"},
	"North Town": {"x": 320, "y": 640, "map": "maps/north_town"},
	"North Gateway": {"x": 384, "y": 640, "map": "maps/north_gateway"},
	"North Gateway Back": {"x": 384, "y": 1216, "map": "maps/north_gateway"},
	"North Mountain": {"x": 512, "y": 2688, "map": "maps/north_mountain"},
	"Cave Fire": {"x": 512, "y": 576, "map": "maps/cave_fire_b1"},
	"Waterway Back": {"x": 2048, "y": 1408, "map": "maps/waterway"},
	"Port": {"x": 320, "y": 1088, "map": "maps/port"},
	"Ice Tower F1": {"x": 1088, "y": 1664, "map": "maps/ice_tower_f1"},
	"South Castle F1": {"x": 640, "y": 1920, "map": "maps/south_castle_f1"},
	"A House In A Forest": {"x": 384, "y": 1216, "map": "maps/house_in_forest"},
	"Passageway": {"x": 512, "y": 640, "map": "maps/passageway"},
	"Passageway Back": {"x": 512, "y": 1664, "map": "maps/passageway"},
	"Crystal Castle F1": {"x": 1216, "y": 1858, "map": "maps/crystal_castle_f1"},
}

var shop_dict = {
}

var door_dict = {
	"Alpha Door": "Alpha Key",
}

var treasure_dict = {
}

var dialog_dict = {
}

