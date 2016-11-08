
extends Node

const MOVE_DOWN = 1
const MOVE_LEFT = 2
const MOVE_RIGHT = 3
const MOVE_UP = 4

var npc = null         # is hero
var npc_map = null     # a map to find other NPCs
var animate = null     # animated graphics
var tile_map = null    # tile map
var tile_set = null    # tile set
var movable = false    # check it is a movable
var same_tile = false  # check it move is same tile only
var tile_check = null  # tile to check if same_tile is true
var with_hero = null   # referencing with hero
var walking = false    # is walking?
var scripting = false  # is scripting?

var distance = null
var next_pos = null
var time_used = 0
var speed = 0

var common_dialogs = [
	[
		"Good day"
	],
	[
		"Hello"
	],
	[
		"..."
	],
]

func _init(instance):
	npc = instance
	npc_map = instance.get_node("../../NPCMap")
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
	with_hero = instance.get_node("../../Group")
	walking = false
	scripting = false
	var pos = npc.get_pos()
	pos = constants.map_to_pixel(constants.pixel_to_map(pos))
	npc.set_pos(pos)

func _process(delta):
	if party.paused:
		return
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
					if detect_hit() == null:
						speed = ai_speed()
						animate.set_frame(0)
						time_used = 0
						walking = true
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
		animate.set_frame(0)
		walking = false

func position():
	if !walking:
		return npc.get_pos()
	else:
		return next_pos

func detect_hit():
	var found = false
	var count = npc_map.get_child_count()
	var i = 0
	while i < count:
		var npc = npc_map.get_child(i).npc
		if npc != self:
			var pos = npc.position()
			if next_pos.x == pos.x && next_pos.y == pos.y:
				found = true
				break
		i += 1
	if found:
		return npc_map.get_child(i)
	else:
		var pos = with_hero.position()
		if next_pos.x == pos.x && next_pos.y == pos.y:
			return with_hero
		else:
			return null

func set_face(hero_face):
	if hero_face == "down":
		animate.set_animation("up")
	elif hero_face == "left":
		animate.set_animation("right")
	elif hero_face == "right":
		animate.set_animation("left")
	elif hero_face == "up":
		animate.set_animation("down")

func ai_walk():
	var i = randi() % 100
	if i > 95:
		return i - 95;
	else:
		return 0

func ai_speed():
	var i = randi() % 500
	return 250 + i

func common_talk():
	var c = common_dialogs.size()
	var i = randi() % c
	return common_dialogs[i]

