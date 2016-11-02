
extends Node2D

var warp = {
	"Town0": {"map":"test", "x":992, "y":160},
}

func _ready():
	get_node("/root/party").set_current_scene(self)

func _exit_tree():
	get_node("/root/party").set_current_scene(null)

func goto(nodeName):
	if warp.has(nodeName):
		return warp[nodeName]
	else:
		return null

