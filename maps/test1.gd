
extends Node2D

func _ready():
	get_node("Camera/Group").set_current_scene(self)

var dialogs = {
	"Fake King": [
		"You DIE",
		global.SCRIPT_BATTLE,
	],
}

var shops = {
}

var doors = {
}

var treasures = {
}

var warps = {
	"Town0": {"x": 160, "y": 224, "map": "maps/test0"},
}

