
extends Node2D

func _ready():
	var audio = load("res://musics/Final Fantasy 3 - Sylx Tower.ogg")
	get_node("MusicPlayer").set_stream(audio)
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"To F6": {"x": 1216, "y": 1664, "map": "maps/crystal_castle_f6"},
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
		[global.SCRIPT_READ_QUEST, "Zoma"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Zoma"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Zoma"],
		"NO No no...",
		"Aarrrgh...",
		[global.SCRIPT_WRITE_QUEST, "Zoma"],
		[global.SCRIPT_NPC_HIDDEN, "Zoma"],
		[global.SCRIPT_TITLE_SET, 0],
		"Let's use this key to open the door in Passageway.",
	],
	"Zoma": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"You will taste my power!",
		[global.SCRIPT_BATTLE, "Win", "d0699", "Floor8"],
	],
}

