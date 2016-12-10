
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"Back": {"x": 1088, "y": 192, "map": "maps/passageway"},
	"Next": {"x": 1600, "y": 3200, "map": "maps/underground_part2"},
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
		[global.SCRIPT_READ_QUEST, "Skel Dragon"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Skel Dragon"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Skel Dragon"],
		"...",
		[global.SCRIPT_WRITE_QUEST, "Skel Dragon"],
		[global.SCRIPT_NPC_HIDDEN, "Skel Dragon"],
	],
	"Skel Dragon": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"DIE DIE DIE !!!",
		[global.SCRIPT_BATTLE, "Win", "d0790", "Floor1"],
	],
	"Recover": [
		[global.SCRIPT_HPMP_FULL],
		"HP/MP recover :)",
	],
}

