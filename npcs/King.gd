
extends Node2D

var npc = null

func _ready():
	var _class = load("res://npcs/npc.gd")
	npc = _class.new(self)
	set_process(true)

func _process(delta):
	npc._process(delta)

