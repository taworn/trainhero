
extends Node2D

func _ready():
	var audio = load("res://musics/Final Fantasy 3 - Sylx Tower.ogg")
	get_node("MusicPlayer").set_stream(audio)
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0600": 1,
}

var warp_dict = {
	"Back": {"x": 2880, "y": 3136, "map": "maps/world"},
	"To B1": {"x": 640, "y": 384, "map": "maps/crystal_castle_b1"},
	"To F2": {"x": 1216, "y": 704, "map": "maps/crystal_castle_f2"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
	"START": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_READ_QUEST, "Guardian Captain"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Guardian Captain"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Guardian Captain"],
		"Aarrrgh...",
		[global.SCRIPT_WRITE_QUEST, "Guardian Captain"],
		[global.SCRIPT_NPC_HIDDEN, "Guardian Captain"],
	],
	"Guardian Captain": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"You die!!!",
		[global.SCRIPT_BATTLE, "Win", "d0690", "Floor8"],
	],
}

