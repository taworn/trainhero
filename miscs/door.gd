
extends Node2D

var tag = global.TAG_DOOR

var animate = null  # animation to act various tasks

func _ready():
	set_pos(global.normalize(get_pos()))
	animate = get_node("Animate")

func set_pause(b):
	pass

