
extends Node2D

var warps = {
	"Town0": {"map":"test", "x":992, "y":160},
}

func _ready():
	get_node("/root/party").set_current_scene(self)

func _exit_tree():
	get_node("/root/party").set_current_scene(null)

func warp_to(nodeName):
	if warps.has(nodeName):
		return warps[nodeName]
	else:
		return null

func scene_name():
	return "Test 2"

