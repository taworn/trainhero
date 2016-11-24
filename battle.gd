
extends Container

const TIME_LIMIT = 32
const TIME_TICK = 50
const WAIT_TURN = 0
const WAIT_MENU = 1
const WAIT_ACTION = 2
const WAIT_ATTACK = 3

var party = []                # party of hero and heroines
var monsters_on_floor = null  # monsters who on floor
var monsters_on_air = null    # monsters who on air
var monsters = []             # monsters add to list

var effects = null         # when players attack or use magic
var effect_player = null   # effect player
var current_effect = null  # current using effect

var menu = null
var text_panel = null
var text_label = null

var sound = null      # sound sample
var animation = null  # animation
var after_effect = null

var time_cumulative = 0
var owner_id = null
var wait = WAIT_TURN

func _ready():
	print("background: ", state.battle_background)
	party.append(get_node("Players/Party/Status0"))
	party.append(get_node("Players/Party/Status1"))
	party.append(get_node("Players/Party/Status2"))
	party[0].update(0)
	party[1].update(1)
	party[2].update(2)
	party[0].set_active(false)
	party[1].set_active(false)
	party[2].set_active(false)
	monsters_on_floor = get_node("Players/Monsters On Floor")
	monsters_on_air = get_node("Players/Monsters On Air")
	get_node("Players/Loader").execute("res://enemies/groups/" + state.enemies_group_file + ".txt")

	effects = get_node("Players/Effects")
	effect_player = get_node("Players/Effects/Player")

	menu = get_node("UI/Menu")
	text_panel = get_node("UI/PanelText")
	text_panel.set_hidden(true)
	text_label = text_panel.get_node("Text")

	sound = get_node("SoundPlayer")

	get_node("MusicPlayer").play()
	animation = get_node("Effect/AnimationPlayer")
	animation.connect("finished", self, "_on_AnimationPlayer_finished")
	animation.get_node("../CanvasModulate").set_color(Color(0, 0, 0, 0))

	var i = 0
	while i < monsters_on_floor.get_child_count():
		var child = monsters_on_floor.get_child(i)
		monsters.append(child)
		i += 1
	i = 0
	while i < monsters_on_air.get_child_count():
		var child = monsters_on_air.get_child(i)
		i += 1
		monsters.append(child)
	for i in monsters:
		i.data.speed = TIME_LIMIT - i.data.spd
		i.data.action = null
	for i in party:
		i.data.speed = TIME_LIMIT - i.data.spd
		i.data.action = null

	set_process(true)

func _process(delta):
	if wait == WAIT_MENU:
		if !menu.is_opened():
			var player = party[owner_id]
			player.set_active(false)
			player.data.action = menu.result
			player.data.speed = player.data.action.take_time
			wait = WAIT_TURN

	elif wait == WAIT_ACTION:
		var player = party[owner_id]
		var action = player.data.action
		if action.name == "attack":
			print("action(%s): attack %s" % [player.data.name, action.target.data.name])
			player.data.speed = TIME_LIMIT - player.data.spd
			player.data.action = null
			wait = WAIT_ATTACK
			run_attack(action)
			return
		elif action.name == "magic":
			if master.magic_dict[owner_id][action.magic].effect.has("battle"):
				var battle = master.magic_dict[owner_id][action.magic].effect["battle"]
				if battle == "one":
					print("action(%s): attack magic %s to %s" % [player.data.name, action.magic, action.target.data.name])
				elif battle == "group":
					print("action(%s): attack magic %s to %s" % [player.data.name, action.magic, action.targets])
				elif battle == "all":
					print("action(%s): attack magic %s to all enemies" % [player.data.name, action.magic])
			else:
				if typeof(action.target) == TYPE_STRING:
					print("action(%s): use magic %s to %s" % [player.data.name, action.magic, action.target])
				else:
					print("action(%s): use magic %s to %s" % [player.data.name, action.magic, party[action.target].data.name])
		elif action.name == "item":
			print("action(%s): use item %s on %s" % [player.data.name, action.item, party[action.target].data.name])
		elif action.name == "wait":
			print("action(%s): waiting..." % [player.data.name])
		elif action.name == "runaway":
			print("action(%s): runaway, bye bye ^_^" % [player.data.name])
			state.back()
		player.data.speed = TIME_LIMIT - player.data.spd
		player.data.action = null
		wait = WAIT_TURN

	elif wait == WAIT_ATTACK:
		pass

	else:
		time_cumulative += round(delta * 1000)
		if time_cumulative > TIME_TICK:
			time_cumulative = 0
			turn()

func _on_AnimationPlayer_finished():
	if after_effect != null:
		after_effect = null
		state.back()

func _on_Player_finished():
	wait = WAIT_TURN

func turn():
	var player = check_party_turn()
	if player != null:
		var player_id = state.player_dict[player.data.name]
		owner_id = player_id
		if player.data.action == null:
			party[player_id].set_active(true)
			menu.open(self, player_id)
			wait = WAIT_MENU
		else:
			wait = WAIT_ACTION
		return

	var monster = check_monsters_turn()
	if monster != null:
		print("monster: ", monster.data.name)
		monster.data.speed = TIME_LIMIT - monster.data.spd
		return

	for i in monsters:
		i.data.speed -= 1
	for i in party:
		i.data.speed -= 1

func check_party_turn():
	for i in party:
		if i.data.avail && !i.data.faint:
			if i.data.speed <= 0:
				return i
	return null

func check_monsters_turn():
	for i in monsters:
		if !i.data.has("die"):
			if i.data.speed <= 0:
				return i
	return null

func run_attack(action):
	var weapon = party[owner_id].data.weapon
	var animation = master.equip_dict[owner_id][weapon].effect.animation
	var enemy = action.target
	var parent = enemy.get_parent()
	var enemy_pos = enemy.get_pos()
	var parent_pos = parent.get_pos()
	current_effect = effects.get_node(animation)
	current_effect.set_pos(Vector2(parent_pos.x + enemy_pos.x + enemy.data.width / 2, parent_pos.y + enemy_pos.y + enemy.data.height / 2))
	effect_player.play(animation)

