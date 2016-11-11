
extends Node2D

var tag = global.TAG_TREASURE

var animate = null  # animation to act various tasks

func _ready():
	set_pos(global.normalize(get_pos()))
	animate = get_node("Animate")

