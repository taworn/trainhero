
extends Node2D

func _ready():
	get_node("Camera/Hero").currentScene = self

var warps = {
	"Town0": { "x": 160, "y": 227, "map": "maps/test0", },
}

