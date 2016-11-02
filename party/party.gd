
extends Node2D

# 1 step size
const STEP_X = 64
const STEP_Y = 64

# 1 step used time, as milli-seconds
const STEP_TIME = 150

# screen size
var screen_size = {
	"x": Globals.get("display/width"),
	"y": Globals.get("display/height")
}
var half_screen_size = {
	"x": screen_size.x >> 1,
	"y": screen_size.y >> 1
}

# passable for walking
var passableWalk = {
	"Grass0": 1,
	"Town0": 1,
	"Castle0": 1, "Castle1": 1, "Castle2": 1, "Castle3": 1
}

# passable for shiping
var passableShip = {
}

var currentScene = null  # current scene which has hero
var hero = null          # the hero
var walking = false      # is walking?
var scripting = false    # is scripting?
var tileMap = null       # tilemap
var tileSet = null       # tileset

# moving variables
var nextPos = null
var distance = null
var timeUsed = 0

# move to next scene
var nextScenePos = null

func set_current_scene(scene):
	currentScene = scene
	if currentScene != null:
		hero = currentScene.get_node("Camera/Hero")
		walking = false
		scripting = false
		tileMap = currentScene.get_node("Camera/TileMap")
		tileSet = tileMap.get_tileset()
		if nextScenePos != null:
			var pos = pixel_to_map(nextScenePos)
			pos = map_to_pixel(pos)
			hero.set_pos(pos)
		center_screen()
	else:
		hero = null

func _ready():
	set_process(true)

func _process(delta):
	if hero != null:
		if !walking && !scripting:
			distance = null
			if Input.is_action_pressed("ui_left"):
				distance = Vector2(-STEP_X, 0)
				hero.set_animation("left")
			elif Input.is_action_pressed("ui_right"):
				distance = Vector2(STEP_X, 0)
				hero.set_animation("right")
			elif Input.is_action_pressed("ui_up"):
				distance = Vector2(0, -STEP_Y)
				hero.set_animation("up")
			elif Input.is_action_pressed("ui_down"):
				distance = Vector2(0, STEP_Y)
				hero.set_animation("down")
			if distance != null:
				var pos = hero.get_pos()
				nextPos = Vector2(pos.x + distance.x, pos.y + distance.y)
				var mapPos = pixel_to_map(nextPos)
				var id = tileMap.get_cell(mapPos.x - 1, mapPos.y - 1)
				var nodeName = tileSet.tile_get_name(id)
				if passableWalk.has(nodeName):
					if passableWalk[nodeName]:
						timeUsed = 0
						walking = true
						hero.set_frame(0)
			else:
				if Input.is_action_pressed("ui_cancel"):
					get_tree().change_scene("res://title.tscn")
		elif walking:
			walk(delta)
		elif scripting:
			pass

func walk(delta):
	delta = ceil(delta * 1000)
	var finish = false
	var dx = ceil(delta * distance.x / STEP_TIME)
	var dy = ceil(delta * distance.y / STEP_TIME)
	var pos = hero.get_pos()
	pos.x += dx
	pos.y += dy
	if distance.x < 0:
		if pos.x <= nextPos.x + STEP_X / 2:
			hero.set_frame(1)
		if pos.x <= nextPos.x:
			pos.x = nextPos.x
			finish = true
	elif distance.x > 0:
		if pos.x >= nextPos.x - STEP_X / 2:
			hero.set_frame(1)
		if pos.x >= nextPos.x:
			pos.x = nextPos.x
			finish = true
	if distance.y < 0:
		if pos.y <= nextPos.y + STEP_Y / 2:
			hero.set_frame(1)
		if pos.y <= nextPos.y:
			pos.y = nextPos.y
			finish = true
	elif distance.y > 0:
		if pos.y >= nextPos.y - STEP_Y / 2:
			hero.set_frame(1)
		if pos.y >= nextPos.y:
			pos.y = nextPos.y
			finish = true
	hero.set_pos(pos)
	center_screen()
	timeUsed += delta
	if finish:
		walking = false
		hero.set_frame(0)
		check_script()

func center_screen():
	var p = hero.get_pos()
	var q = Vector2(half_screen_size.x - p.x, half_screen_size.y - p.y)
	currentScene.get_node("Camera").set_pos(q)

func check_script():
	var scripts = currentScene.get_node("Camera/Scripts")
	var count = scripts.get_child_count()
	var found = false
	var i = 0
	while i < count:
		var o = scripts.get_child(i)
		var r = Rect2(o.get_pos(), o.get_size())
		if r.has_point(hero.get_pos()):
			found = true
			break
		i = i + 1
	if found:
		var nodeName = scripts.get_child(i).get_name()
		var node = currentScene.goto(nodeName)
		if node != null:
			print("warp to ", node.map, " (", node.x, ",", node.y, ")")
			get_tree().change_scene("res://" + node.map + ".tscn")
			nextScenePos = Vector2(node.x, node.y)

func pixel_to_map(pixelPos):
	return Vector2(round(pixelPos.x / STEP_X), round(pixelPos.y / STEP_Y))

func map_to_pixel(mapPos):
	return Vector2((mapPos.x - 1) * STEP_X + (STEP_X >> 1), (mapPos.y - 1) * STEP_Y + (STEP_Y >> 1))

