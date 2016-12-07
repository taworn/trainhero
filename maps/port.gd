
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"Back": {"x": 4736, "y": 3392, "map": "maps/world"},
	"Next": {"x": 4864, "y": 3392, "map": "maps/world"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

