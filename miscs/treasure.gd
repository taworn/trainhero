
extends Node2D

var tag = global.TAG_TREASURE

var animate = null  # animation to act various tasks

func _ready():
	set_pos(global.normalize(get_pos()))
	animate = get_node("Animate")

func is_opened():
	return animate.get_animation() == "opened"

func set_opened():
	animate.set_animation("opened")

func set_pause(b):
	pass

