
extends Node2D

var party = null

# one step size, in pixels
const STEP_X = 64
const STEP_Y = 64

# one step time, in milli-seconds
const STEP_TIME = 150

# screen size, in pixel
var screen_size = {
	"x": Globals.get("display/width"),
	"y": Globals.get("display/height"),
}
var half_screen_size = {
	"x": screen_size.x >> 1,
	"y": screen_size.y >> 1,
}

# passable for walking
var passableWalk = {
	"Grass0": 1,
	"Town0": 1,
	"Castle0": 1, "Castle1": 1, "Castle2": 1, "Castle3": 1,
}

# passable for sailing
var passableSail = {
	"Water0": 1,
}

var background = null  # background sprite, can be null
var camera = null      # camera to set position (x, y)
var hero = null        # is hero
var tileMap = null     # tilemap
var tileSet = null     # tileset
var warpMap = null     # a map to find warp zone
var npcMap = null      # a map to find NPC

var walking = false    # is walking?
var scripting = false  # is scripting?

var distance = null
var nextPos = null
var timeUsed = 0

var currentScene = null

func _ready():
	party = get_node("/root/party")
	background = get_node("../../CanvasLayer/ParallaxBackground/ParallaxLayer/Background")
	if background.get_texture() == null:
		background = null
	camera = get_node("../../Camera")
	hero = get_node("Hero")
	tileMap = get_node("../TileMap")
	tileSet = tileMap.get_tileset()
	warpMap = get_node("../WarpMap")
	npcMap = get_node("../NPCMap")
	walking = false
	scripting = false

	hero.set_pos(Vector2(party.state.x, party.state.y))
	if party.back_fade != null:
		hero.set_animation(party.back_fade)
	center_screen()
	get_node("../../UI/Title").set_hidden(!party.new)
	party.new = false

	set_process_input(true)
	set_process(true)

func _input(event):
	if !walking && !scripting:
		if Input.is_action_pressed("ui_accept"):
			key_pressed()
			party.back_fade = hero.get_animation()
			get_tree().change_scene("res://menu.tscn")
		elif Input.is_action_pressed("ui_cancel"):
			key_pressed()
			get_tree().change_scene("res://title.tscn")

func _process(delta):
	if !walking && !scripting:
		distance = null
		if Input.is_action_pressed("ui_left"):
			key_pressed()
			distance = Vector2(-STEP_X, 0)
			hero.set_animation("left")
		elif Input.is_action_pressed("ui_right"):
			key_pressed()
			distance = Vector2(STEP_X, 0)
			hero.set_animation("right")
		elif Input.is_action_pressed("ui_up"):
			key_pressed()
			distance = Vector2(0, -STEP_Y)
			hero.set_animation("up")
		elif Input.is_action_pressed("ui_down"):
			key_pressed()
			distance = Vector2(0, STEP_Y)
			hero.set_animation("down")
		if distance != null:
			var pos = hero.get_pos()
			nextPos = Vector2(pos.x + distance.x, pos.y + distance.y)
			var mapPos = pixel_to_map(nextPos)
			var id = tileMap.get_cell(mapPos.x - 1, mapPos.y - 1)
			var name = tileSet.tile_get_name(id)
			if passableWalk.has(name):
				if passableWalk[name]:
					timeUsed = 0
					walking = true
					hero.set_frame(0)
	elif walking:
		walk(delta)
	elif scripting:
		pass

func key_pressed():
	get_node("../../UI/Title").set_hidden(true)

func walk(delta):
	var finish = false
	var d = ceil(delta * 1000)
	var dx = ceil(d * distance.x / STEP_TIME)
	var dy = ceil(d * distance.y / STEP_TIME)
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
	if finish:
		walking = false
		hero.set_frame(0)
		party.state.x = pos.x
		party.state.y = pos.y
		check_script()

func center_screen():
	var p = hero.get_pos()
	var q = Vector2(half_screen_size.x - p.x, half_screen_size.y - p.y)
	camera.set_pos(q)
	if background != null:
		background.set_pos(Vector2(q.x / 8, q.y / 32))

func check_script():
	var found = false
	var count = warpMap.get_child_count()
	var i = 0
	while i < count:
		var o = warpMap.get_child(i)
		var r = Rect2(o.get_pos(), o.get_size())
		if r.has_point(hero.get_pos()):
			found = true
			break
		i = i + 1
	if found:
		var name = warpMap.get_child(i).get_name()
		if currentScene.warps.has(name):
			var node = currentScene.warps[name]
			if node != null:
				var pos = Vector2(node.x, node.y)
				pos = map_to_pixel(pixel_to_map(pos))
				party.back_fade = hero.get_animation()
				party.warp_to(pos.x, pos.y, node.map)

func pixel_to_map(pixelPos):
	return Vector2(round(pixelPos.x / STEP_X), round(pixelPos.y / STEP_Y))

func map_to_pixel(mapPos):
	return Vector2((mapPos.x - 1) * STEP_X + (STEP_X >> 1), (mapPos.y - 1) * STEP_Y + (STEP_Y >> 1))

func set_current_scene(scene):
	currentScene = scene

