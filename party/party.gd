
extends Node2D

const STEP = 32

var passable = {
	"Grass0": 1
}

var currentScene = null
var hero = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)

func _input(event):
	if hero != null:
		var pos = hero.get_pos()
		var move = false
		if Input.is_action_pressed("ui_left"):
			pos.x -= STEP
			move = true
		elif Input.is_action_pressed("ui_right"):
			pos.x += STEP
			move = true
		elif Input.is_action_pressed("ui_up"):
			pos.y -= STEP
			move = true
		elif Input.is_action_pressed("ui_down"):
			pos.y += STEP
			move = true
		if move:
			var tileMap = currentScene.get_node("TileMap")
			var tileSet = tileMap.get_tileset()
			var posMap = Vector2();
			posMap.x = round(pos.x / 32)
			posMap.y = round(pos.y / 32)
			var id = tileMap.get_cell(posMap.x - 1, posMap.y - 1)
			print(id)
			var nodeName = tileSet.tile_get_name(id)
			print(nodeName)
			if passable.has(nodeName):
				if passable[nodeName]:
					hero.set_pos(pos)
		else:
			if Input.is_action_pressed("ui_cancel"):
				get_tree().change_scene("res://title.tscn")

func set_current_scene(scene):
	currentScene = scene
	if currentScene != null:
		hero = currentScene.get_node("Hero")
	else:
		hero = null

