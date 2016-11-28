
extends Container

const TIME_TICK = 50
const TIME_LIMIT = 32

const TIME_SLOW = 64
const TIME_SPEED = 64
const TIME_PROTECT = 64
const TIME_SHIELD = 64

const WAIT_TURN = 0
const WAIT_MENU = 1
const WAIT_ACTION = 2
const WAIT_ACTIONING = 3
const WAIT_WIN = 4

var background = null         # background
var party = []                # party of hero and heroines
var monsters_on_floor = null  # monsters who on floor
var monsters_on_air = null    # monsters who on air
var monsters_floor = []       # monsters on floor add to array
var monsters_air = []         # monsters on air add to array
var monsters = []             # monsters add to array

var effects = null  # players attack or use magic

var menu = null
var text_panel = null
var text_label = null

var sound = null      # sound sample
var animation = null  # animation
var after_effect = null

var time_cumulative = 0
var owner_id = null
var wait = WAIT_TURN

var map_to_background = {
	"Grass1": "forest",
	"Tree1": "forest",
}

func _ready():
	background = get_node("Background")
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
	effects.connect(self, "_on_Player_finished")

	menu = get_node("UI/Menu")
	text_panel = get_node("UI/PanelText")
	text_panel.set_hidden(true)
	text_label = text_panel.get_node("Text")

	sound = get_node("SoundPlayer")

	get_node("MusicPlayer").play()
	animation = get_node("Effect/AnimationPlayer")
	animation.connect("finished", self, "_on_AnimationPlayer_finished")
	animation.get_node("../CanvasModulate").set_color(Color(0, 0, 0, 0))

	var filename = null
	if state.persist.ship.cruising:
		filename = "ocean"
	else:
		if map_to_background.has(state.battle_background):
			filename = map_to_background[state.battle_background]
		else:
			filename = "grass"
	filename = "res://backgrounds/" + filename + ".png"
	var image = ImageTexture.new()
	image.load(filename)
	background.set_texture(image)

	var i = 0
	while i < monsters_on_floor.get_child_count():
		var child = monsters_on_floor.get_child(i)
		monsters_floor.append(child)
		monsters.append(child)
		i += 1
	i = 0
	while i < monsters_on_air.get_child_count():
		var child = monsters_on_air.get_child(i)
		i += 1
		monsters_air.append(child)
		monsters.append(child)
	var boss = false
	for i in monsters:
		i.data.timeout = {"slow": 0}
		i.data.speed = TIME_LIMIT - i.data.spd
		i.data.action = null
		if i.data.has("boss"):
			boss = true
		var template = load("res://battle/damage.tscn")
		var damage = template.instance()
		damage.attach(i, i.data.width, i.data.height, self, "_on_Damage_finished")
		i.data.damage = damage
	for i in party:
		i.data.timeout = {"speed": 0, "protect": 0, "shield": 0}
		i.data.speed = TIME_LIMIT - i.data.spd
		i.data.action = null

	if boss:
		menu.disable_for_boss()

	set_process(true)

func _process(delta):
	if wait == WAIT_MENU:
		if !menu.is_opened():
			var player = party[owner_id]
			player.set_active(false)
			player.data.action = menu.result
			player.data.speed = player.data.action.take_time
			after_select_menu(player.data.action)
			wait = WAIT_TURN

	elif wait == WAIT_ACTION:
		var player = party[owner_id]
		var action = player.data.action
		if action.name == "attack":
			begin_attack_or_magic()
			return
		elif action.name == "magic":
			if master.magic_dict[owner_id][action.magic].effect.has("battle"):
				begin_attack_or_magic()
				return
			else:
				begin_powerup()
				return
		elif action.name == "item":
			begin_powerup()
			return
		elif action.name == "wait":
			print("action(%s): waiting..." % [player.data.name])
		elif action.name == "runaway":
			print("action(%s): runaway, bye bye ^_^" % [player.data.name])
			state.back()
		player.data.speed = TIME_LIMIT - player.data.spd
		player.data.action = null
		wait = WAIT_TURN

	elif wait == WAIT_ACTIONING:
		pass

	elif wait == WAIT_WIN:
		state.back()

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
	var player = party[owner_id]
	var action = player.data.action
	if !action.has("party"):
		# check if all miss
		var dies = true
		for i in action.enemies:
			if !i.data.has("die"):
				dies = false
				break
		if !dies:
			# continue will normal flow
			if can_action_to_attack(action):
				for i in action.enemies:
					if !i.is_hidden():
						var damage = action_to_attack(action, i)
						i.data.hp -= damage
						i.data.damage.display("%d" % damage)
						i.data.damage.play()
			else:
				# support magic, no attack to enemies
				for i in action.enemies:
					if !i.is_hidden():
						action_to_support_attack(action, i)
				end_action()
		else:
			# continue next loop
			end_action()
	else:
		for i in action.party:
			action_to_powerup(action, party[i])
		party[0].update(0)
		party[1].update(1)
		party[2].update(2)
		end_action()

func _on_Damage_finished():
	var player = party[owner_id]
	var action = player.data.action
	action.enemy_count += 1
	if action.enemy_count >= live_count(action.enemies):
		for i in action.enemies:
			if !i.is_hidden():
				if i.data.hp <= 0:
					i.data.hp = 0
					i.data.die = 1
					i.set_hidden(true)
				after_kill_enemy(action)
		end_action()

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
		if !i.data.has("die"):
			if i.data.timeout.slow <= 0:
				i.data.speed -= 2
			else:
				i.data.speed -= 1
				i.data.timeout.slow -= 1
	for i in party:
		if !i.data.faint:
			if i.data.timeout.speed <= 0:
				i.data.speed -= 2
			else:
				i.data.speed -= 4
				i.data.timeout.speed -= 1
			if i.data.timeout.protect > 0:
				i.data.timeout.protect -= 1
			if i.data.timeout.shield > 0:
				i.data.timeout.shield -= 1

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

func check_party_win():
	for i in monsters:
		if !i.data.has("die"):
			return false
	return true

func live_count(group):
	var count = 0
	for i in group:
		if !i.data.has("die"):
			count += 1
	return count

func random_next_enemy():
	for i in monsters:
		if !i.data.has("die"):
			return i
	return null

func begin_attack_or_magic():
	var player = party[owner_id]
	player.data.speed = TIME_LIMIT - player.data.spd
	wait = WAIT_ACTIONING

	var action = player.data.action
	var animation = null
	if action.name == "attack":
		var weapon = player.data.weapon
		animation = master.equip_dict[owner_id][weapon].effect.animation
	elif action.name == "magic":
		var magic_id = action.magic
		animation = master.magic_dict[owner_id][magic_id].effect.animation
		player.data.mp -= formulas.usage_mp(owner_id, magic_id)
		player.update(owner_id)

	var effect_pos
	if action.has("target"):
		# select one enemy
		var target = action.target
		if target.data.has("die"):
			target = random_next_enemy()
		var pos = target.get_pos()
		var parent_pos = target.get_parent().get_pos()
		effect_pos = Vector2(parent_pos.x + pos.x + target.data.width / 2, parent_pos.y + pos.y + target.data.height / 2)
		action.enemies = [target]
	else:
		# select multiple enemies
		var group
		if action.targets == "air":
			group = monsters_air
		elif action.targets == "floor":
			group = monsters_floor
		else:
			group = monsters
		effect_pos = Vector2(global.half_screen_size.x, 250)
		action.enemies = group
	action.enemy_count = 0

	effects.play(animation, effect_pos)

func begin_powerup():
	var player = party[owner_id]
	player.data.speed = TIME_LIMIT - player.data.spd
	wait = WAIT_ACTIONING

	var action = player.data.action
	var animation = null
	if action.name == "magic":
		var magic_id = action.magic
		animation = master.magic_dict[owner_id][magic_id].effect.animation
		player.data.mp -= formulas.usage_mp(owner_id, magic_id)
	else:
		var item_id = action.item
		animation = master.item_dict[item_id].effect.animation
		state.persist.items[item_id] -= 1
	player.update(owner_id)

	var effect_pos
	if typeof(action.target) == TYPE_INT:
		var target = party[action.target]
		var pos = target.get_pos()
		effect_pos = Vector2(pos.x + 48, pos.y + 48)
		action.party = [target.data_id]
	else:
		var pos = party[0].get_pos()
		effect_pos = Vector2(global.half_screen_size.x, pos.y - 64)
		action.party = [0, 1, 2]

	effects.play(animation, effect_pos)

func end_action():
	party[owner_id].data.action = null
	if !check_party_win():
		wait = WAIT_TURN
	else:
		wait = WAIT_WIN

func can_action_to_attack(action):
	if action.name == "attack":
		return true
	else:
		var magic = master.magic_dict[owner_id][action.magic]
		if magic.effect.has("power"):
			return true
	return false

func action_to_attack(action, enemy):
	if action.name == "attack":
		return formulas.player_attack_monster(owner_id, enemy)
	else:
		var magic = master.magic_dict[owner_id][action.magic]
		if magic.effect.has("power"):
			return formulas.player_magic_monster(owner_id, action.magic, enemy)
		else:
			return 0

func action_to_support_attack(action, enemy):
	var magic = master.magic_dict[owner_id][action.magic]
	if magic.effect.has("slow"):
		enemy.data.timeout["slow"] = TIME_SHIELD

func after_kill_enemy(action):
	var player = party[owner_id]
	var effect = master.equip_dict[owner_id][player.data.weapon].effect
	if effect.has("absorb_hp"):
		player.data.hp += effect["absorb_hp"]
		if player.data.hp > player.data.hp_max:
			player.data.hp = player.data.hp_max
	if effect.has("absorb_mp"):
		player.data.mp += effect["absorb_mp"]
		if player.data.mp > player.data.mp_max:
			player.data.mp = player.data.mp_max
	player.update(owner_id)

func after_select_menu(action):
	var player = party[owner_id]
	var accesory = master.equip_dict[owner_id][player.data.accessory]
	if accesory.has("effect"):
		var effect = accesory["effect"]
		if effect.has("regen_hp"):
			player.data.hp += effect["regen_hp"]
			if player.data.hp > player.data.hp_max:
				player.data.hp = player.data.hp_max
		if effect.has("regen_mp"):
			player.data.mp += effect["regen_mp"]
			if player.data.mp > player.data.mp_max:
				player.data.mp = player.data.mp_max
		player.update(owner_id)

func action_to_powerup(action, player):
	var effect
	if action.has("magic"):
		effect = master.magic_dict[owner_id][action.magic].effect
	else:
		effect = master.item_dict[action.item].effect
	if player.data.faint:
		if effect.has("heal"):
			player.data.faint = false
			player.data.hp = round(effect["heal"] * player.data.hp_max / 100)
	if !player.data.faint:
		if effect.has("hp"):
			player.data.hp += round(effect["hp"] * player.data.hp_max / 100)
			if player.data.hp > player.data.hp_max:
				player.data.hp = player.data.hp_max
		if effect.has("cure"):
			player.data.poison = false
		if effect.has("speed"):
			player.data.timeout["speed"] = TIME_SPEED
		if effect.has("protect"):
			player.data.timeout["protect"] = TIME_PROTECT
		if effect.has("shield"):
			player.data.timeout["shield"] = TIME_SHIELD

