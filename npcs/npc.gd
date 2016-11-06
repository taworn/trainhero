
extends Node

const MOVE_DOWN = 1
const MOVE_LEFT = 2
const MOVE_RIGHT = 3
const MOVE_UP = 4

var npc = null         # is hero
var animate = null     # animated graphics
var tile_map = null    # tile map
var tile_set = null    # tile set
var movable = false    # check it is a movable
var same_tile = false  # check it move is same tile only
var tile_check = null  # tile to check if same_tile is true
var walking = false    # is walking?
var scripting = false  # is scripting?

var distance = null
var next_pos = null
var time_used = 0
var speed = 0

func _init(instance):
	npc = instance
	animate = instance.get_node("Animate")
	tile_map = instance.get_node("../../TileMap")
	tile_set = tile_map.get_tileset()
	if instance.get_node("Movable"):
		movable = true
	elif instance.get_node("SameTile"):
		movable = true
		same_tile = true
		var map_pos = constants.pixel_to_map(npc.get_pos())
		tile_check = tile_map.get_cell(map_pos.x - 1, map_pos.y - 1)
	walking = false
	scripting = false

func _process(delta):
	if movable && !walking && !scripting:
		distance = null
		var a = ai_walk()
		if a == MOVE_DOWN:
			distance = Vector2(-constants.STEP_X, 0)
			animate.set_animation("left")
		elif a == MOVE_LEFT:
			distance = Vector2(constants.STEP_X, 0)
			animate.set_animation("right")
		elif a == MOVE_RIGHT:
			distance = Vector2(0, -constants.STEP_Y)
			animate.set_animation("up")
		elif a == MOVE_UP:
			distance = Vector2(0, constants.STEP_Y)
			animate.set_animation("down")
		if distance != null:
			var pos = npc.get_pos()
			next_pos = Vector2(pos.x + distance.x, pos.y + distance.y)
			var map_pos = constants.pixel_to_map(next_pos)
			var id = tile_map.get_cell(map_pos.x - 1, map_pos.y - 1)
			if same_tile && tile_check != id:
				return
			var name = tile_set.tile_get_name(id)
			if constants.passable_walk.has(name):
				if constants.passable_walk[name]:
					time_used = 0
					walking = true
					animate.set_frame(0)
					speed = ai_speed()
	elif walking:
		walk(delta)
	elif scripting:
		pass

func walk(delta):
	var finish = false
	var d = ceil(delta * 1000)
	var dx = ceil(d * distance.x / speed)
	var dy = ceil(d * distance.y / speed)
	var pos = npc.get_pos()
	pos.x += dx
	pos.y += dy

	if distance.x < 0:
		if pos.x <= next_pos.x + constants.STEP_X / 2:
			animate.set_frame(1)
		if pos.x <= next_pos.x:
			pos.x = next_pos.x
			finish = true
	elif distance.x > 0:
		if pos.x >= next_pos.x - constants.STEP_X / 2:
			animate.set_frame(1)
		if pos.x >= next_pos.x:
			pos.x = next_pos.x
			finish = true

	if distance.y < 0:
		if pos.y <= next_pos.y + constants.STEP_Y / 2:
			animate.set_frame(1)
		if pos.y <= next_pos.y:
			pos.y = next_pos.y
			finish = true
	elif distance.y > 0:
		if pos.y >= next_pos.y - constants.STEP_Y / 2:
			animate.set_frame(1)
		if pos.y >= next_pos.y:
			pos.y = next_pos.y
			finish = true

	npc.set_pos(pos)
	if finish:
		walking = false
		animate.set_frame(0)

func detect_hit():
	if !walking:
		return npc.get_pos()
	else:
		return next_pos

func ai_walk():
	var i = randi() % 100
	if i > 95:
		return i - 95;
	else:
		return 0

func ai_speed():
	var i = randi() % 500
	return 250 + i

