
extends Node2D

var monster = null
var label = null
var player = null
var blinker = null

func attach(parent, width, height, this, finished):
	monster = get_node("..")
	label = get_node("Label")
	player = get_node("Player")
	player.connect("finished", this, finished)
	blinker = get_node("Blinker")
	parent.add_child(self)
	set_pos(Vector2((width - label.get_size().x) / 2, height / 2))

func display(number):
	label.set_text(number)

func play():
	player.play("bounce")

func blink():
	blinker.play("blink")

