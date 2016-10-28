
extends Node2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("/root/party").set_current_scene(self)

func _exit_tree():
	get_node("/root/party").set_current_scene(null)

