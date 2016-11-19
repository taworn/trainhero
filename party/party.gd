
extends Node2D

var camera = null      # camera to set position (x, y), can be null
var background = null  # background sprite, can be null
var tile_map = null    # tile map
var hero = null        # a hero
var ship = null        # a ship

var menu = null       # menu
var shop = null       # shop
var scripting = null  # scripting
var sound = null      # sound sample
var animation = null  # animation

var battle_roll = null

var paused = false  # game pause
var after_effect = null
var scene = null

func _ready():
	camera = get_node("../../../Camera")
	if camera != null:
		background = camera.get_node("../CanvasLayer/ParallaxBackground/ParallaxLayer/Background")
		if background.get_texture() == null:
			background = null
	tile_map = get_node("../../TileMap")
	hero = tile_map.get_node("Players/Hero")
	ship = tile_map.get_node("Players/Ship")
	hero.set_hidden(state.persist.ship.cruising)
	ship.set_hidden(state.persist.ship.map != state.persist.map)

	menu = get_node("../../../UI/Menu")
	shop = get_node("../../../UI/Shop")
	scripting = get_node("../../../UI/Scripting")
	sound = get_node("../../../SoundPlayer")

	animation = get_node("../../../Effect/AnimationPlayer")
	animation.connect("finished", self, "_on_AnimationPlayer_finished")
	animation.get_node("../CanvasModulate").set_color(Color(0, 0, 0, 0))

	var _class = load("res://party/battle_roll.gd")
	battle_roll = _class.new()

	center_screen()
	set_process_input(true)
	set_process(true)
	paused = true

func _input(event):
	if paused || hero.is_moving() || (!ship.is_hidden() && ship.is_moving()):
		return
	if Input.is_action_pressed("ui_accept"):
		key_pressed()
		if !state.persist.ship.cruising:
			var child = hero.check_standing()
			if child != null && child.tag in [global.TAG_NPC, global.TAG_DOOR, global.TAG_TREASURE]:
				execute_script(child)
	elif Input.is_action_pressed("ui_cancel"):
		key_pressed()
		if menu != null:
			save_npcs()
			menu.open(self)

func _process(delta):
	if paused || hero.is_moving() || (!ship.is_hidden() && ship.is_moving()):
		return
	var action = 0
	if Input.is_action_pressed("ui_down"):
		key_pressed()
		action = global.MOVE_DOWN
	elif Input.is_action_pressed("ui_left"):
		key_pressed()
		action = global.MOVE_LEFT
	elif Input.is_action_pressed("ui_right"):
		key_pressed()
		action = global.MOVE_RIGHT
	elif Input.is_action_pressed("ui_up"):
		key_pressed()
		action = global.MOVE_UP
	if action != 0:
		if !state.persist.ship.cruising:
			hero.move(action)
		else:
			ship.move(action)

func _on_AnimationPlayer_finished():
	paused = false
	if after_effect != null:
		if after_effect.has("map"):
			state.warp_to(after_effect.x, after_effect.y, after_effect.map, after_effect.retain_npcs)
		elif after_effect.has("battle"):
			state.fight(after_effect["battle"])
		after_effect = null
	else:
		if state.scripting_continue != null:
			var source = state.scripting_continue
			state.scripting_continue = null
			var dialog
			dialog = scene.dialog_dict[source]
			scripting.open_floor(self, dialog)

func key_pressed():
	var scene_name = get_node("../../../UI/SceneName")
	if scene_name != null:
		scene_name.set_hidden(true)

func on_moving_step():
	center_screen()

func center_screen():
	if camera != null:
		var pos
		if !state.persist.ship.cruising:
			pos = hero.get_pos()
		else:
			pos = ship.get_pos()
		var cam_pos = Vector2(global.half_screen_size.x - pos.x - (global.STEP_X >> 1), global.half_screen_size.y - pos.y - (global.STEP_Y >> 1))
		camera.set_pos(cam_pos)
		if background != null:
			background.set_pos(Vector2(cam_pos.x / 8, cam_pos.y / 32))

func switch_to_hero():
	state.persist.x = state.persist.ship.x
	state.persist.y = state.persist.ship.y
	hero.set_pos(ship.get_pos())
	hero.set_hidden(false)
	state.persist.ship.cruising = false

func switch_to_ship():
	state.persist.ship.cruising = true
	hero.set_hidden(true)

func execute_script(child):
	if child.tag == global.TAG_NPC:
		var dialog
		if scene.dialog_dict.has(child.get_name()):
			dialog = scene.dialog_dict[child.get_name()]
		else:
			dialog = child.get_common_dialog()
		scripting.open(self, child, dialog)
	elif child.tag == global.TAG_DOOR:
		check_key(child)
	elif child.tag == global.TAG_TREASURE:
		check_box(child)

func get_sale_list(name):
	return scene.shop_dict[name]

func check_face_to_hero():
	var face = hero.get_face()
	if face == "down":
		return "up"
	elif face == "left":
		return "right"
	elif face == "right":
		return "left"
	elif face == "up":
		return "down"

func check_key(door):
	if scene.door_dict.has(door.get_name()):
		var found = false
		var data = scene.door_dict[door.get_name()]
		if typeof(data) == TYPE_STRING:
			if state.persist.keys.has(data):
				found = true
		else:
			found = true
		if found:
			door.set_hidden(true)
			return true
	return false

func check_box(child):
	if !state.persist.treasures.has(state.persist.map):
		state.persist.treasures[state.persist.map] = []
	var array = state.persist.treasures[state.persist.map]
	if !array.has(child.get_name()):
		array.append(child.get_name())
		child.set_opened()
		if scene.treasure_dict.has(child.get_name()):
			var list = scene.treasure_dict[child.get_name()]
			var s = ""
			for i in list:
				state.persist.keys.append(i)
				if s != "":
					s += ", "
				s += i
			scripting.open_treasure(self, child, s)

func after_walk(name):
	if name != null:
		if scene.warp_dict.has(name):
			warp_to(name)
		elif scene.dialog_dict.has(name):
			var dialog = scene.dialog_dict[name]
			scripting.open_floor(self, dialog)
	else:
		if scene.tag in [global.TAG_DUNGEON, global.TAG_WORLD]:
			if !scripting.is_opened():
				if battle_roll.random():
					if !state.persist.ship.cruising:
						var zone = detect_battle_zone()
						if zone != null:
							random_battle(scene.enemy_zone_dict[zone.get_name()])
						else:
							random_battle(scene.enemy_dict)
					else:
						random_battle(scene.enemy_ship_dict)

func detect_battle_zone():
	var zones = tile_map.get_node("Battle Zones")
	if zones != null:
		var pos = hero.get_pos()
		var count = zones.get_child_count()
		var i = 0
		while i < count:
			var child = zones.get_child(i)
			var rect = Rect2(child.get_pos(), child.get_size())
			if rect.has_point(pos):
				return child
			i += 1
	return null

func warp_to(name):
	if name != null:
		var data = scene.warp_dict[name]
		var pos = global.normalize(Vector2(data.x, data.y))
		after_effect = {
			"x": pos.x,
			"y": pos.y,
			"map": data.map,
			"retain_npcs": false,
		}
	else:
		save_npcs()
		after_effect = {
			"x": state.persist.x,
			"y": state.persist.y,
			"map": state.persist.map,
			"retain_npcs": true,
		}
	animation.set_current_animation("fade_out")
	animation.play()
	paused = true

func random_battle(dict):
	if dict.size() <= 0:
		return

	var sum = 0
	for i in dict:
		sum += dict[i]

	randomize()
	var random = randi() % sum
	sum = 0
	for i in dict:
		sum += dict[i]
		if random < sum:
			open_battle(i)
			return

func open_battle(battle):
	save_npcs()
	after_effect = {"battle": battle}
	animation.set_current_animation("light")
	animation.play()
	paused = true

func save_npcs():
	var players = tile_map.get_node("Players")
	var count = players.get_child_count()
	var i = 0
	while i < count:
		var child = players.get_child(i)
		if child != self && !child.is_hidden():
			if child.tag in [global.TAG_NPC]:
				var name = child.get_name()
				var pos = child.get_current_pos()
				state.persist.npcs[name] = {"x": pos.x, "y": pos.y, "face": child.get_face()}
		i += 1

func set_current_scene(scene):
	self.scene = scene

	var players = tile_map.get_node("Players")
	for i in state.persist.npcs:
		var node = players.get_node(i)
		if node != null:
			var data = state.persist.npcs[i]
			node.set_pos(Vector2(data.x, data.y))
			node.set_face(data.face)

	if state.persist.treasures.has(state.persist.map):
		var array = state.persist.treasures[state.persist.map]
		for i in array:
			var box = players.get_node(i)
			if box != null:
				box.set_opened()

	if scene.dialog_dict.has("START"):
		var dialog
		dialog = scene.dialog_dict["START"]
		scripting.open_hidden(self, dialog)

