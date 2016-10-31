
extends Node2D

const STEP = 32

var screen_size = {
	"x": Globals.get("display/width"),
	"y": Globals.get("display/height")
}

var half_screen_size = {
	"x": screen_size.x >> 1,
	"y": screen_size.y >> 1
}

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
			var nodeName = tileSet.tile_get_name(id)
			if passable.has(nodeName):
				if passable[nodeName]:
					hero.set_pos(pos)
					center_screen()
					check_script(pos)
		else:
			if Input.is_action_pressed("ui_cancel"):
				get_tree().change_scene("res://title.tscn")

func check_script(pos):
	var scripts = currentScene.get_node("Scripts")
	var count = scripts.get_child_count()
	var found = false
	var i = 0
	while i < count:
		var o = scripts.get_child(i)
		var r = Rect2(o.get_pos(), o.get_size())
		if r.has_point(pos):
			found = true
			break
		i = i + 1
	if found:
		var nodeName = scripts.get_child(i).get_name()
		var name = currentScene.goto(nodeName)
		if name != null:
			print("warp to ")
			print(name)
			get_tree().change_scene("res://" + name + ".tscn")

func set_current_scene(scene):
	currentScene = scene
	if currentScene != null:
		hero = currentScene.get_node("Hero")
		center_screen()
	else:
		hero = null

func center_screen():
	var p = hero.get_pos()
	var q = Vector2(half_screen_size.x - p.x, half_screen_size.y - p.y)
	currentScene.set_pos(q)

