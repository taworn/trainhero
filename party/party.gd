
extends Node2D

var camera = null      # camera to set position (x, y), can be null
var background = null  # background sprite, can be null
var tile_map = null    # tile map
var hero = null        # a hero
var ship = null        # a ship

var ui_container = null  # UI container
var animation = null     # animation

var paused = false   # game pause
var in_menu = false  # in menu?

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
	ship.set_hidden(state.persist.ship.map != state.persist.map)

	ui_container = get_node("../../../UI/Container")

	animation = get_node("../../../Effect/AnimationPlayer")
	animation.connect("finished", self, "_on_AnimationPlayer_finished")
	animation.get_node("../CanvasModulate").set_color(Color(0, 0, 0, 0))

	center_screen()
	set_process_input(true)
	set_process(true)
	paused = true

func _input(event):
	if paused || hero.is_moving() || (!ship.is_hidden() && ship.is_moving()):
		return
	if Input.is_action_pressed("ui_accept"):
		key_pressed()
	elif Input.is_action_pressed("ui_cancel"):
		key_pressed()

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
	if after_effect != null:
		state.warp_to(after_effect.x, after_effect.y, after_effect.map)
		after_effect = null
	paused = false

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
	
func warp_to(name):
	if scene.warp_dict.has(name):
		var data = scene.warp_dict[name]
		var pos = global.normalize(Vector2(data.x, data.y))
		after_effect = {
			"x": pos.x,
			"y": pos.y,
			"map": data.map,
		}
		animation.set_current_animation("fade_out")
		animation.play()
		paused = true

func set_current_scene(scene):
	self.scene = scene

