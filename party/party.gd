
extends Node2D

# one step size, in pixels
const STEP_X = 64
const STEP_Y = 64

# one step used time, in milli-seconds
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

var currentScene = null  # current scene which has hero
var sceneName = null     # current scene name
var hero = null          # the hero
var walking = false      # is walking?
var scripting = false    # is scripting?
var tileMap = null       # tilemap
var tileSet = null       # tileset

# moving variables
var distance = null
var nextPos = null
var timeUsed = 0

# save state
var state = {
	"oldMap": null,
	"map": null,
	"x": null,
	"y": null,
}

func _ready():
	set_process_input(true)
	set_process(true)

func _input(event):
	if hero != null:
		if !walking && !scripting:
			if Input.is_action_pressed("ui_accept"):
				get_tree().change_scene("res://menu.tscn")
			elif Input.is_action_pressed("ui_cancel"):
				get_tree().change_scene("res://title.tscn")

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
		elif walking:
			walk(delta)
		elif scripting:
			pass

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
		state.x = pos.x
		state.y = pos.y
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
		var node = currentScene.warp_to(nodeName)
		if node != null:
			warp_to(node)

func warp_to(node):
	print("warp to ", node.map, " (", node.x, ",", node.y, ")")
	var pos = Vector2(node.x, node.y)
	pos = map_to_pixel(pixel_to_map(pos))
	state.oldMap = state.map
	state.map = node.map
	state.x = pos.x
	state.y = pos.y
	get_tree().change_scene("res://" + state.map + ".tscn")

func pixel_to_map(pixelPos):
	return Vector2(round(pixelPos.x / STEP_X), round(pixelPos.y / STEP_Y))

func map_to_pixel(mapPos):
	return Vector2((mapPos.x - 1) * STEP_X + (STEP_X >> 1), (mapPos.y - 1) * STEP_Y + (STEP_Y >> 1))

func start_game():
	state.map = "test"
	state.x = 96
	state.y = 96
	get_tree().change_scene("res://test.tscn")

func save_game(fileName):
	var f = File.new()
	f.open(fileName, File.WRITE)
	f.store_line(state.to_json())
	f.close()
	print("saved ", state)

func load_game(fileName):
	var f = File.new()
	if !f.file_exists(fileName):
		return start_game()
	f.open(fileName, File.READ)
	if (!f.eof_reached()):
	    state.parse_json(f.get_line())
	f.close()
	print("loaded ", state)
	get_tree().change_scene("res://" + state.map + ".tscn")

func back():
	get_tree().change_scene("res://" + state.map + ".tscn")

func set_current_scene(scene):
	currentScene = scene
	if currentScene != null:
		sceneName = currentScene.scene_name()
		hero = currentScene.get_node("Camera/Hero")
		if hero != null:
			var pos = Vector2(state.x, state.y)
			hero.set_pos(pos)
			tileMap = currentScene.get_node("Camera/TileMap")
			tileSet = tileMap.get_tileset()
			center_screen()
		walking = false
		scripting = false
	else:
		hero = null

