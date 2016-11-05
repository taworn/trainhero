
extends Node2D

var party = null

var background = null  # background sprite, can be null
var camera = null      # camera to set position (x, y)
var hero = null        # is hero
var tile_map = null    # tile map
var tile_set = null    # tile set
var warp_map = null    # a map to find warp zone
var npc_map = null     # a map to find NPC

var walking = false    # is walking?
var scripting = false  # is scripting?

var distance = null
var next_pos = null
var time_used = 0

var current_scene = null

func _ready():
	party = get_node("/root/party")
	background = get_node("../../CanvasLayer/ParallaxBackground/ParallaxLayer/Background")
	if background.get_texture() == null:
		background = null
	camera = get_node("../../Camera")
	hero = get_node("Hero")
	tile_map = get_node("../TileMap")
	tile_set = tile_map.get_tileset()
	warp_map = get_node("../WarpMap")
	npc_map = get_node("../NPCMap")
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
			distance = Vector2(-constants.STEP_X, 0)
			hero.set_animation("left")
		elif Input.is_action_pressed("ui_right"):
			key_pressed()
			distance = Vector2(constants.STEP_X, 0)
			hero.set_animation("right")
		elif Input.is_action_pressed("ui_up"):
			key_pressed()
			distance = Vector2(0, -constants.STEP_Y)
			hero.set_animation("up")
		elif Input.is_action_pressed("ui_down"):
			key_pressed()
			distance = Vector2(0, constants.STEP_Y)
			hero.set_animation("down")
		if distance != null:
			var pos = hero.get_pos()
			next_pos = Vector2(pos.x + distance.x, pos.y + distance.y)
			var map_pos = pixel_to_map(next_pos)
			var id = tile_map.get_cell(map_pos.x - 1, map_pos.y - 1)
			var name = tile_set.tile_get_name(id)
			if constants.passable_walk.has(name):
				if constants.passable_walk[name]:
					time_used = 0
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
	var dx = ceil(d * distance.x / constants.STEP_TIME)
	var dy = ceil(d * distance.y / constants.STEP_TIME)
	var pos = hero.get_pos()
	pos.x += dx
	pos.y += dy

	if distance.x < 0:
		if pos.x <= next_pos.x + constants.STEP_X / 2:
			hero.set_frame(1)
		if pos.x <= next_pos.x:
			pos.x = next_pos.x
			finish = true
	elif distance.x > 0:
		if pos.x >= next_pos.x - constants.STEP_X / 2:
			hero.set_frame(1)
		if pos.x >= next_pos.x:
			pos.x = next_pos.x
			finish = true

	if distance.y < 0:
		if pos.y <= next_pos.y + constants.STEP_Y / 2:
			hero.set_frame(1)
		if pos.y <= next_pos.y:
			pos.y = next_pos.y
			finish = true
	elif distance.y > 0:
		if pos.y >= next_pos.y - constants.STEP_Y / 2:
			hero.set_frame(1)
		if pos.y >= next_pos.y:
			pos.y = next_pos.y
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
	var q = Vector2(constants.half_screen_size.x - p.x, constants.half_screen_size.y - p.y)
	camera.set_pos(q)
	if background != null:
		background.set_pos(Vector2(q.x / 8, q.y / 32))

func check_script():
	var found = false
	var count = warp_map.get_child_count()
	var i = 0
	while i < count:
		var o = warp_map.get_child(i)
		var r = Rect2(o.get_pos(), o.get_size())
		if r.has_point(hero.get_pos()):
			found = true
			break
		i = i + 1
	if found:
		var name = warp_map.get_child(i).get_name()
		if current_scene.warps.has(name):
			var node = current_scene.warps[name]
			if node != null:
				var pos = Vector2(node.x, node.y)
				pos = map_to_pixel(pixel_to_map(pos))
				party.back_fade = hero.get_animation()
				party.warp_to(pos.x, pos.y, node.map)

func pixel_to_map(pixel_pos):
	return Vector2(round(pixel_pos.x / constants.STEP_X), round(pixel_pos.y / constants.STEP_Y))

func map_to_pixel(map_pos):
	return Vector2((map_pos.x - 1) * constants.STEP_X + (constants.STEP_X >> 1), (map_pos.y - 1) * constants.STEP_Y + (constants.STEP_Y >> 1))

