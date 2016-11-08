
extends Node2D

var party = null

var background = null  # background sprite, can be null
var camera = null      # camera to set position (x, y)
var hero = null        # is hero
var tile_map = null    # tile map
var tile_set = null    # tile set
var warp_map = null    # a map to find warp zones
var npc_map = null     # a map to find NPCs
var container = null   # a container UI

var walking = false    # is walking?
var scripting = false  # is scripting?
var in_shop = false    # is in shop?
var in_menu = false    # is in menu?

var distance = null
var next_pos = null
var time_used = 0

var talk_with = null
var dialog = null
var dialog_pointer = -1

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
	container = get_node("../../UI/Container")
	container.set_hidden(true)
	walking = false
	scripting = false

	hero.set_pos(Vector2(party.state.x, party.state.y))
	hero.set_animation(party.state.face)
	center_screen()
	get_node("../../UI/Title").set_hidden(!party.new)
	party.new = false

	set_process_input(true)
	set_process(true)
	get_node("../../MusicPlayer").play()

func _input(event):
	if !party.paused:
		if !walking && !scripting && !in_shop && !in_menu:
			if Input.is_action_pressed("ui_accept"):
				key_pressed()
				var npc = detect_talk()
				if npc != null:
					start_talk(npc)
			elif Input.is_action_pressed("ui_menu"):
				party.back_fade = hero.get_animation()
				save_npcs()
				get_tree().change_scene("res://menu.tscn")
			elif Input.is_action_pressed("ui_cancel"):
				key_pressed()
				party.paused = true
				in_menu = true
				get_node("../../UI/Menu").container.open()
				save_npcs()
		elif scripting:
			if !in_shop && !in_menu:
				if Input.is_action_pressed("ui_accept"):
					var next = next_dialog()
					if next != null:
						container.get_node("Text").set_text(next)
					else:
						container.set_hidden(true)
						talk_with.scripting = false
						scripting = false
			elif in_shop:
				if Input.is_action_pressed("ui_cancel"):
					container.get_node("Title").set_hidden(false)
					container.get_node("Text").set_hidden(false)
					get_node("../../UI/Shop").container.close()
					in_shop = false
					var next = next_dialog()
					if next != null:
						container.get_node("Text").set_text(next)
					else:
						container.set_hidden(true)
						talk_with.scripting = false
						scripting = false
	elif in_menu:
		if Input.is_action_pressed("ui_cancel"):
			if get_node("../../UI/Menu").container.cancel():
				in_menu = false
				party.paused = false

func _process(delta):
	if !party.paused:
		if !walking && !scripting && !in_shop:
			distance = null
			if Input.is_action_pressed("ui_down"):
				key_pressed()
				distance = Vector2(0, constants.STEP_Y)
				hero.set_animation("down")
			elif Input.is_action_pressed("ui_left"):
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
			party.state.face = hero.get_animation()
			if distance != null:
				var pos = hero.get_pos()
				next_pos = Vector2(pos.x + distance.x, pos.y + distance.y)
				var map_pos = constants.pixel_to_map(next_pos)
				var id = tile_map.get_cell(map_pos.x - 1, map_pos.y - 1)
				var name = tile_set.tile_get_name(id)
				if constants.passable_walk.has(name):
					if constants.passable_walk[name]:
						if detect_hit() == null:
							hero.set_frame(0)
							time_used = 0
							walking = true
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
		hero.set_frame(0)
		party.state.x = pos.x
		party.state.y = pos.y
		check_script()
		walking = false

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
		i += 1
	if found:
		var name = warp_map.get_child(i).get_name()
		if current_scene.warps.has(name):
			var node = current_scene.warps[name]
			if node != null:
				var pos = Vector2(node.x, node.y)
				pos = constants.map_to_pixel(constants.pixel_to_map(pos))
				party.back_fade = hero.get_animation()
				party.warp_to(pos.x, pos.y, node.map)

func position():
	if !walking:
		return hero.get_pos()
	else:
		return next_pos

func detect_hit():
	var found = false
	var count = npc_map.get_child_count()
	var i = 0
	while i < count:
		var npc = npc_map.get_child(i).npc
		var pos = npc.position()
		if next_pos.x == pos.x && next_pos.y == pos.y:
			found = true
			break
		i += 1
	if found:
		return npc_map.get_child(i)
	else:
		return null

func detect_talk():
	var face = null
	var animate = hero.get_animation()
	if animate == "down":
		face = Vector2(0, constants.STEP_Y)
	elif animate == "left":
		face = Vector2(-constants.STEP_X, 0)
	elif animate == "right":
		face = Vector2(constants.STEP_X, 0)
	elif animate == "up":
		face = Vector2(0, -constants.STEP_Y)
	var pos = hero.get_pos()
	var talk_pos = Vector2(pos.x + face.x, pos.y + face.y)

	var found = false
	var count = npc_map.get_child_count()
	var i = 0
	while i < count:
		var npc = npc_map.get_child(i).npc
		var pos = npc.position()
		if talk_pos.x == pos.x && talk_pos.y == pos.y:
			found = true
			break
		i += 1
	if found:
		return npc_map.get_child(i).npc
	else:
		return null

func next_dialog():
	while dialog_pointer < dialog.size():
		dialog_pointer += 1
		if dialog_pointer < dialog.size():
			if typeof(dialog[dialog_pointer]) == TYPE_STRING:
				return dialog[dialog_pointer]
			elif typeof(dialog[dialog_pointer]) == TYPE_INT:
				if dialog[dialog_pointer] == constants.SCRIPT_SWITCH_TITLE:
					switch_title()
				elif dialog[dialog_pointer] == constants.SCRIPT_OPEN_SHOP:
					open_shop()
					return ""
				continue
			else:
				continue
	return null

func switch_title():
	var title = container.get_node("Title").get_text()
	if title == talk_with.npc.get_name():
		title = "Hero"
	else:
		title = talk_with.npc.get_name()
	container.get_node("Title").set_text(title)

func open_shop():
	container.get_node("Title").set_hidden(true)
	container.get_node("Text").set_hidden(true)
	in_shop = true
	get_node("../../UI/Shop").container.open(current_scene.shops[talk_with.npc.get_name()])

func start_talk(npc):
	talk_with = npc
	print("talk with ", talk_with.npc.get_name())
	container.set_hidden(false)
	talk_with.set_face(hero.get_animation())
	talk_with.scripting = true
	scripting = true

	if !current_scene.dialogs.has(talk_with.npc.get_name()):
		dialog = talk_with.common_talk()
	else:
		dialog = current_scene.dialogs[talk_with.npc.get_name()]
	dialog_pointer = -1	
	container.get_node("Title").set_text(talk_with.npc.get_name())
	container.get_node("Text").set_text(next_dialog())

func save_npcs():
	var i = 0
	while i < npc_map.get_child_count():
		var npc = npc_map.get_child(i).npc
		var pos = npc.position()
		var name = npc_map.get_child(i).get_name()
		party.state.npcs[name] = {"x": pos.x, "y": pos.y, "face": npc.animate.get_animation()}
		i += 1

func set_current_scene(scene):
	current_scene = scene
	for i in party.state.npcs:
		var node = npc_map.get_node(i)
		if node != null:
			var data = party.state.npcs[i]
			node.set_pos(Vector2(data.x, data.y))
			node.npc.animate.set_animation(data.face)

