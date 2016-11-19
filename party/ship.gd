
extends Node2D

const STEP_TIME = 150

var tag = global.TAG_SHIP

var moving = false   # is moving?
var animate = null   # animation to act various tasks
var tile_map = null  # tile map

var distance = null
var next_pos = null
var time_used = 0

var party = null

func _ready():
	set_pos(global.normalize(Vector2(state.persist.ship.x, state.persist.ship.y)))
	moving = false
	animate = get_node("Animate")
	animate.set_animation(state.persist.ship.face)
	tile_map = get_node("../../../TileMap")
	party = tile_map.get_node("Party")
	set_process(true)

func _process(delta):
	if moving:
		moving_step(delta)

func is_moving():
	return moving

func get_current_pos():
	if !moving:
		return get_pos()
	else:
		return next_pos

func set_face(action):
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
	state.persist.ship.face = animate.get_animation()

func move(action):
	set_face(action)
	if distance != null:
		var pos = get_pos()
		if party.scene.tag == global.TAG_WORLD:
			if action == global.MOVE_UP && pos.y == party.scene.rect.pos.y:
				print("reach up")
				pos.y = party.scene.rect.end.y
				set_pos(Vector2(pos.x, pos.y))
			elif action == global.MOVE_LEFT && pos.x == party.scene.rect.pos.x:
				print("reach left")
				pos.x = party.scene.rect.end.x
				set_pos(Vector2(pos.x, pos.y))
			elif action == global.MOVE_RIGHT && pos.x == party.scene.rect.end.x:
				print("reach right")
				pos.x = party.scene.rect.pos.x
				set_pos(Vector2(pos.x, pos.y))
			elif action == global.MOVE_DOWN && pos.y == party.scene.rect.end.y:
				print("reach down")
				pos.y = party.scene.rect.pos.y
				set_pos(Vector2(pos.x, pos.y))
		next_pos = Vector2(pos.x + distance.x, pos.y + distance.y)
		if check_on_land():
			party.switch_to_hero()
			return false
		if check_before_walk():
			animate.set_frame(0)
			time_used = 0
			moving = true
			return true
	return false

func moving_step(delta):
	var finish = false
	var d = ceil(delta * 1000)
	var dx = ceil(d * distance.x / STEP_TIME)
	var dy = ceil(d * distance.y / STEP_TIME)
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
	party.on_moving_step()
	if finish:
		animate.set_frame(0)
		moving = false
		state.persist.ship.x = pos.x
		state.persist.ship.y = pos.y
		check_after_walk()

func check_before_walk():
	# checks map
	var map_pos = global.pixel_to_map(next_pos)
	var id = tile_map.get_cell(map_pos.x, map_pos.y)
	var name = tile_map.get_tileset().tile_get_name(id)
	if global.passable_sail_dict.has(name) && global.passable_sail_dict[name]:
		return true
	return false

func check_after_walk():
	# checks scripts
	var pos = get_pos()
	var scripts = tile_map.get_node("Scripts")
	var count = scripts.get_child_count()
	var i = 0
	while i < count:
		var child = scripts.get_child(i)
		var rect = Rect2(child.get_pos(), child.get_size())
		if rect.has_point(pos):
			party.after_walk(child.get_name())
			return true
		i += 1
	party.after_walk(null)
	return false

func check_on_land():
	var map_pos = global.pixel_to_map(next_pos)
	var id = tile_map.get_cell(map_pos.x, map_pos.y)
	var name = tile_map.get_tileset().tile_get_name(id)
	if global.passable_walk_dict.has(name) && global.passable_walk_dict[name]:
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
		return true
	return false

