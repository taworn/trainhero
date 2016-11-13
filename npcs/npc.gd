
extends Node2D

var tag = global.TAG_NPC

var moving = false   # is moving?
var animate = null   # animation to act various tasks
var tile_map = null  # tile map
var pause = false    # this NPC is pause or resume

# adds child node to control more behaviors
var fix_face = false   # can talk but no set face
var movable = false    # a movable NPC
var scripting = false  # can use in scripting only
var same_tile = false  # a movable NPC, but can walk on same tile only
var tile_check = null  # tile to check if same_tile is true

var distance = null
var next_pos = null
var time_used = 0
var speed = 0

var party = null

var common_dialogs = [
	["Good day"],
	["Hello"],
	["..."],
]

func _ready():
	set_pos(global.normalize(get_pos()))
	moving = false
	animate = get_node("Animate")
	tile_map = get_node("../../../TileMap")
	if get_node("FixFace"):
		fix_face = true
	elif get_node("Movable"):
		movable = true
	elif get_node("Scripting"):
		movable = true
		scripting = true
	elif get_node("SameTile"):
		movable = true
		same_tile = true
		var map_pos = global.pixel_to_map(get_pos())
		tile_check = tile_map.get_cell(map_pos.x, map_pos.y)
	party = tile_map.get_node("Party")
	set_process(true)

func _process(delta):
	if !party.paused:
		if !moving:
			if movable && !pause:
				if !scripting:
					var action = ai_walk()
					if action == global.MOVE_DOWN:
						action = global.MOVE_DOWN
					elif action == global.MOVE_LEFT:
						action = global.MOVE_LEFT
					elif action == global.MOVE_RIGHT:
						action = global.MOVE_RIGHT
					elif action == global.MOVE_UP:
						action = global.MOVE_UP
					if action != 0:
						speed = ai_speed()
						move(action)
		else:
			moving_step(delta)

func is_moving():
	return moving

func get_current_pos():
	if !moving:
		return get_pos()
	else:
		return next_pos

func set_pause(b):
	pause = b

func set_speed(s):
	speed = s

func get_face():
	return animate.get_animation()

func set_face(action):
	if fix_face:
		return
	if typeof(action) == TYPE_INT:
			distance = null
			if action == global.MOVE_DOWN:
				distance = Vector2(0, global.STEP_Y)
				animate.set_animation("down")
			elif action == global.MOVE_LEFT:
				distance = Vector2(-global.STEP_X, 0)
				animate.set_animation("left")
			elif action == global.MOVE_RIGHT:
				distance = Vector2(global.STEP_X, 0)
				animate.set_animation("right")
			elif action == global.MOVE_UP:
				distance = Vector2(0, -global.STEP_Y)
				animate.set_animation("up")
	else:
		animate.set_animation(action)

func move(action):
	set_face(action)
	if distance != null:
		var pos = get_pos()
		next_pos = Vector2(pos.x + distance.x, pos.y + distance.y)
		if scripting || check_before_walk():
			animate.set_frame(0)
			time_used = 0
			moving = true
			return true
	return false

func moving_step(delta):
	var finish = false
	var d = ceil(delta * 1000)
	var dx = ceil(d * distance.x / speed)
	var dy = ceil(d * distance.y / speed)
	var pos = get_pos()
	pos.x += dx
	pos.y += dy

	if distance.x < 0:
		if pos.x <= next_pos.x + global.STEP_X / 2:
			animate.set_frame(1)
		if pos.x <= next_pos.x:
			pos.x = next_pos.x
			finish = true
	elif distance.x > 0:
		if pos.x >= next_pos.x - global.STEP_X / 2:
			animate.set_frame(1)
		if pos.x >= next_pos.x:
			pos.x = next_pos.x
			finish = true

	if distance.y < 0:
		if pos.y <= next_pos.y + global.STEP_Y / 2:
			animate.set_frame(1)
		if pos.y <= next_pos.y:
			pos.y = next_pos.y
			finish = true
	elif distance.y > 0:
		if pos.y >= next_pos.y - global.STEP_Y / 2:
			animate.set_frame(1)
		if pos.y >= next_pos.y:
			pos.y = next_pos.y
			finish = true

	set_pos(pos)
	if finish:
		animate.set_frame(0)
		moving = false

func check_before_walk():
	# checks players
	var players = tile_map.get_node("Players")
	var count = players.get_child_count()
	var i = 0
	while i < count:
		var pos
		var child = players.get_child(i)
		if child != self && !child.is_hidden():
			if child.tag in [global.TAG_HERO, global.TAG_SHIP, global.TAG_NPC]:
				pos = child.get_current_pos()
			else:
				pos = child.get_pos()
			if next_pos.x == pos.x && next_pos.y == pos.y:
				return false
		i += 1

	# checks map
	var map_pos = global.pixel_to_map(next_pos)
	var id = tile_map.get_cell(map_pos.x, map_pos.y)
	var name = tile_map.get_tileset().tile_get_name(id)
	if global.passable_walk_dict.has(name) && global.passable_walk_dict[name]:
		if same_tile && tile_check != id:
			return false
		return true
	return false

func get_common_dialog():
	return common_dialogs[randi() % common_dialogs.size()]

func ai_walk():
	var i = randi() % 100
	if i > 95:
		return i - 95;
	else:
		return 0

func ai_speed():
	var i = randi() % 500
	return 250 + i

