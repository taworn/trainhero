
extends Node2D

var _class = load("res://npcs/npc.gd")
var npc = null

func _ready():
	npc = _class.new(self)
	set_process(true)

func _process(delta):
	npc._process(delta)

