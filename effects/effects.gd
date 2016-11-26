
extends Node2D

var player = null

func _ready():
	player = get_node("Player")

func connect(this, finished):
	player.connect("finished", this, finished)

func play(animation, effect_pos):
	var effect = get_node(animation)
	if effect == null:
		var template = load("res://effects/" + animation.to_lower() + ".tscn")
		print("res://effects/" + animation.to_lower() + ".tscn")
		effect = template.instance()
		add_child(effect)
	effect.set_pos(effect_pos)
	effect.set_frame(0)
	player.play(animation)

