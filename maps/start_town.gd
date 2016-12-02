
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back": {"x": 960, "y": 576, "map": "maps/world"},
}

var shop_dict = {
	"Female Merchant": [
		"recover_hp_25",
	],
}

var door_dict = {
	"Door1": 1,
}

var treasure_dict = {
}

var dialog_dict = {
	"Elder": [
		"Good morning",
		"This will start your training of a hero.",
	],
	"Female Merchant": [
		"Hello, have a nice day.",
		[global.SCRIPT_OPEN_SHOP],
		"Thank you.",
	],
	"Innkeeper": [
		"This is an inn, it will fill HP/MP to full.",
		"For start game, this place will be free.",
		"Need a rest? (Press ESC/Cancel to cancel)",
		[global.SCRIPT_OPEN_INN, 0],
		"Oh, sorry, you have not enough gold.",
	],
	"Villager Girl 1": [
		"It's a beautiful scenery.",
	],
}

