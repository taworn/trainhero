
extends Node2D

var label = null
var player = null

func attach(parent, width, height, this, finished):
	label = get_node("Label")
	player = get_node("Player")
	player.connect("finished", this, finished)
	parent.add_child(self)
	set_pos(Vector2((width - label.get_size().x) / 2, height / 2))

func display(number):
	label.set_text(number)

func play():
	player.play("bounce")

