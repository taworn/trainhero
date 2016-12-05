
extends Container

const FORMAT_LEVEL = "Lv %d"
const FORMAT_EXP = "Exp %d"
const FORMAT_MONEY = "%d G"
const FORMAT_ITEM_STOCK = "%s x%d"
const FORMAT_MAGIC_STOCK = "%s (-%dMP)"
const FORMAT_EQUIP_STOCK = "%s: %s"
const FORMAT_EQUIP_WEAPON = "%s   A%d M%d"
const FORMAT_EQUIP_ARMOR = "%s   D%d"

const SAVE_COUNT = 2

var equip_type = ["weapon", "armor", "accessory"]

var deep_level = 0
var party = null
var player_id = null

var status0 = null
var status1 = null
var status2 = null
var menu_list = null
var save_list = null

var item_list_data = null
var item_list = null
var item_player_list = null

var magic_from_list = null
var magic_list = null
var magic_to_list = null

var equip_player_list = null
var equip_list = null
var equip_changeable_list_data = null
var equip_changeable_list = null

var hint_panel = null
var hint_text = null

func _ready():
	set_hidden(true)

	status0 = get_node("Status0")
	status1 = get_node("Status1")
	status2 = get_node("Status2")

	menu_list = get_node("PanelMenu/MenuList")
	menu_list.add_item("Items", null)
	menu_list.add_item("Magics", null)
	menu_list.add_item("Equipment", null)
	menu_list.add_item("Save Game", null)
	menu_list.add_item("Exit Game", null)
	menu_list.add_item("Return Game", null)

	save_list = get_node("SaveList")
	for i in range(SAVE_COUNT):
		save_list.add_item("Save Game #%d" % i, null)

	item_list_data = []
	item_list = get_node("ItemContainer/ItemList")
	item_player_list = get_node("ItemContainer/ItemPlayerList")

	magic_from_list = get_node("MagicContainer/MagicPlayerFromList")
	magic_list = get_node("MagicContainer/MagicList")
	magic_to_list = get_node("MagicContainer/MagicPlayerToList")

	equip_player_list = get_node("EquipContainer/EquipPlayerList")
	equip_list = get_node("EquipContainer/EquipList")
	equip_changeable_list_data = []
	equip_changeable_list = get_node("EquipContainer/EquipChangeableList")

	hint_panel = get_node("PanelHint")
	hint_text = get_node("PanelHint/Hint")

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		pass
	elif Input.is_action_pressed("ui_cancel"):
		if deep_level > 0:
			cancel()
		else:
			close()

func _on_MenuList_item_activated(index):
	save_list.set_hidden(true)
	item_list.set_hidden(true)
	item_player_list.set_hidden(true)
	magic_from_list.set_hidden(true)
	magic_list.set_hidden(true)
	magic_to_list.set_hidden(true)
	equip_player_list.set_hidden(true)
	equip_list.set_hidden(true)
	equip_changeable_list.set_hidden(true)
	hint_panel.set_hidden(true)

	deep_level = 1
	if index == 0:
		item_list.set_hidden(false)
		item_list.select(0)
		item_list.grab_focus()
		hint_panel.set_hidden(false)
		_on_ItemList_item_selected(0)
	elif index == 1:
		magic_from_list.set_hidden(false)
		magic_from_list.select(0)
		magic_from_list.grab_focus()
	elif index == 2:
		equip_player_list.set_hidden(false)
		equip_player_list.select(0)
		equip_player_list.grab_focus()
	elif index == 3:
		save_list.set_hidden(false)
		save_list.select(0)
		save_list.grab_focus()
	elif index == 4:
		state.persist = state.restart_game()
		get_tree().change_scene("res://title.tscn")
	elif index == 5:
		close()

func _on_ItemList_item_activated(index):
	var id = item_list_data[index]
	item_player_list.clear()
	var players = item_check(id)
	if players.size() > 0:
		for i in players:
			item_player_list.add_item(state.persist.players[i].name)
		item_player_list.set_hidden(false)
		item_player_list.select(0)
		item_player_list.grab_focus()
	else:
		party.sound.play("error")

func _on_ItemList_item_selected(index):
	if index < item_list_data.size():
		var id = item_list_data[index]
		hint_text.set_text(master.item_dict[id].hint)
	else:
		hint_text.set_text("")

func _on_ItemPlayerList_item_activated(index):
	var name = item_player_list.get_item_text(index)
	var player = state.persist.players[state.player_dict[name]]
	var selected = item_list.get_selected_items()
	if item_use(item_list_data[selected[0]], player):
		party.sound.play("heal")
		refresh()

func _on_MagicPlayerFromList_item_activated(index):
	var name = magic_from_list.get_item_text(index)
	player_id = state.player_dict[name]
	var player = state.persist.players[player_id]
	magic_list.clear()
	for i in player.magics:
		magic_list.add_item(FORMAT_MAGIC_STOCK % [master.magic_dict[player_id][i].name, master.usage_mp(player_id, i)])
	magic_from_list.set_hidden(true)
	magic_list.set_hidden(false)
	magic_list.select(0)
	magic_list.grab_focus()
	hint_panel.set_hidden(false)
	_on_MagicList_item_selected(0)

func _on_MagicList_item_activated(index):
	var id = state.persist.players[player_id].magics[index]
	var players = magic_check(player_id, id)
	if typeof(players) == TYPE_ARRAY:
		if players.size() > 0:
			magic_to_list.clear()
			for i in players:
				magic_to_list.add_item(state.persist.players[i].name)
			magic_to_list.set_hidden(false)
			magic_to_list.select(0)
			magic_to_list.grab_focus()
			return
	else:
		if players:
			if magic_use_all(player_id, state.persist.players[player_id].magics[index]):
				party.sound.play("heal")
				refresh()
				return
	party.sound.play("error")

func _on_MagicList_item_selected(index):
	if index < state.persist.players[player_id].magics.size():
		var id = state.persist.players[player_id].magics[index]
		hint_text.set_text(master.magic_dict[player_id][id].hint)
	else:
		hint_text.set_text("")

func _on_MagicPlayerToList_item_activated(index):
	var name = magic_to_list.get_item_text(index)
	var player = state.persist.players[state.player_dict[name]]
	var selected = magic_list.get_selected_items()
	var id = state.persist.players[player_id].magics[selected[0]]
	if !master.magic_dict[player_id][id].effect.has("warp"):
		if magic_use_one(player_id, id, player):
			party.sound.play("heal")
			refresh()
		else:
			party.sound.play("error")
	else:
		if party.scene.tag == global.TAG_DUNGEON:
			state.persist.players[player_id].mp -= master.usage_mp(player_id, id)
			party.warp_back()
			close()
		else:
			party.sound.play("error")

func _on_EquipPlayerList_item_activated(index):
	var name = equip_player_list.get_item_text(index)
	player_id = state.player_dict[name]
	var player = state.persist.players[player_id]
	equip_list.clear()
	equip_list.add_item(FORMAT_EQUIP_STOCK % ["Weapon", master.equip_dict[player_id][player.weapon].name])
	equip_list.add_item(FORMAT_EQUIP_STOCK % ["Armor", master.equip_dict[player_id][player.armor].name])
	equip_list.add_item(FORMAT_EQUIP_STOCK % ["Accessory", master.equip_dict[player_id][player.accessory].name])
	equip_player_list.set_hidden(true)
	equip_list.set_hidden(false)
	equip_list.select(0)
	equip_list.grab_focus()

func _on_EquipList_item_activated(index):
	equip_changeable_list_data.clear()
	equip_changeable_list.clear()
	for i in state.persist.players[player_id].equips:
		var equipment = master.equip_dict[player_id][i]
		if equipment.type == equip_type[index]:
			equip_changeable_list_data.append(i)
			if index == 0:
				equip_changeable_list.add_item(FORMAT_EQUIP_WEAPON % [equipment.name, equipment.att, equipment.mag])
			else:
				equip_changeable_list.add_item(FORMAT_EQUIP_ARMOR % [equipment.name, equipment.def])
	equip_list.set_hidden(true)
	equip_changeable_list.set_hidden(false)
	equip_changeable_list.select(0)
	equip_changeable_list.grab_focus()
	hint_panel.set_hidden(false)
	_on_EquipChangeableList_item_selected(0)

func _on_EquipChangeableList_item_activated(index):
	var player = state.persist.players[player_id]
	var selected = equip_list.get_selected_items()
	if selected[0] == 0:
		player.weapon = equip_changeable_list_data[index]
	elif selected[0] == 1:
		player.armor = equip_changeable_list_data[index]
	elif selected[0] == 2:
		player.accessory = equip_changeable_list_data[index]
	party.sound.play("coin")
	refresh()

func _on_EquipChangeableList_item_selected(index):
	if index < equip_changeable_list_data.size():
		var id = equip_changeable_list_data[index]
		hint_text.set_text(master.equip_dict[player_id][id].hint)
	else:
		hint_text.set_text("")

func _on_SaveList_item_activated(index):
	var save = "user://game%d.save" % index
	state.save_game(save)
	party.sound.play("save")
	close()

func refresh():
	status0.update(0)
	status1.update(1)
	status2.update(2)

	item_list_data.clear()
	item_list.clear()
	for i in master.item_list_sort:
		if state.persist.items[i] > 0:
			item_list_data.append(i)
			item_list.add_item(FORMAT_ITEM_STOCK % [master.item_dict[i].name, state.persist.items[i]])

	magic_from_list.clear()
	for i in state.persist.players:
		if i.avail && !i.faint:
			magic_from_list.add_item(i.name)

	equip_player_list.clear()
	for i in state.persist.players:
		if i.avail && !i.faint:
			equip_player_list.add_item(i.name)

	cancel()

func cancel():
	player_id = null
	deep_level = 0
	item_list.set_hidden(true)
	item_player_list.set_hidden(true)
	magic_from_list.set_hidden(true)
	magic_list.set_hidden(true)
	magic_to_list.set_hidden(true)
	equip_player_list.set_hidden(true)
	equip_list.set_hidden(true)
	equip_changeable_list.set_hidden(true)
	save_list.set_hidden(true)
	hint_panel.set_hidden(true)
	menu_list.grab_focus()

func close():
	set_hidden(true)
	set_process_input(false)
	party.set_process_input(true)
	party.set_process(true)
	party.paused = false
	party = null

func open(party):
	self.party = party
	party.paused = true
	party.set_process(false)
	party.set_process_input(false)
	set_process_input(true)
	set_hidden(false)
	get_node("PanelExp/Level").set_text(FORMAT_LEVEL % state.persist.level)
	get_node("PanelExp/Exp").set_text(FORMAT_EXP % state.persist.experience)
	get_node("PanelGold/Gold").set_text(FORMAT_MONEY % state.persist.gold)
	refresh()
	menu_list.select(0)

func is_opened():
	return party != null

func item_check(id):
	var players = []
	var effect = master.item_dict[id].effect
	for i in range(3):
		var can_use = false
		var player = state.persist.players[i]
		if player.avail:
			if player.faint:
				if effect.has("heal"):
					can_use = true
			if !player.faint:
				if effect.has("hp"):
					if player.hp < player.hp_max:
						can_use = true
				if effect.has("mp"):
					if player.mp < player.mp_max:
						can_use = true
				if effect.has("cure"):
					if player.poison:
						can_use = true
			if can_use:
				players.append(i)
	return players

func item_use(id, player):
	var effect = master.item_dict[id].effect
	var used = false
	if player.avail:
		if player.faint:
			if effect.has("heal"):
				if player.faint:
					player.faint = false
					player.poison = false
					player.hp = round(effect["heal"] * player.hp_max / 100)
					used = true
		if !player.faint:
			if effect.has("hp"):
				if player.hp < player.hp_max:
					player.hp += round(effect["hp"] * player.hp_max / 100)
					if player.hp > player.hp_max:
						player.hp = player.hp_max
					used = true
			if effect.has("mp"):
				if player.mp < player.mp_max:
					player.mp += round(effect["mp"] * player.mp_max / 100)
					if player.mp > player.mp_max:
						player.mp = player.mp_max
					used = true
			if effect.has("cure"):
				if player.poison:
					player.poison = false
					used = true
	state.persist.items[id] -= 1
	return used

func magic_check(player_id, id):
	if state.persist.players[player_id].mp < master.usage_mp(player_id, id):
		return false
	var players = []
	var effect = master.magic_dict[player_id][id].effect
	if !effect.has("all"):
		if !effect.has("warp"):
			for i in range(3):
				var can_use = false
				var player = state.persist.players[i]
				if player.avail:
					if player.faint:
						if effect.has("heal"):
							can_use = true
					if !player.faint:
						if effect.has("hp"):
							if player.hp < player.hp_max:
								can_use = true
						if effect.has("cure"):
							if player.poison:
								can_use = true
					if can_use:
						players.append(i)
		else:
			players.append(0)
		return players
	else:
		var can_use = false
		for i in range(3):
			var player = state.persist.players[i]
			if player.avail:
				if player.faint:
					if effect.has("heal"):
						can_use = true
				if !player.faint:
					if effect.has("hp"):
						if player.hp < player.hp_max:
							can_use = true
					if effect.has("cure"):
						if player.poison:
							can_use = true
		return can_use

func magic_use_one(player_id, id, player):
	var effect = master.magic_dict[player_id][id].effect
	var used = false
	if player.faint:
		if effect.has("heal"):
			player.faint = false
			player.poison = false
			player.hp = round(effect["heal"] * player.hp_max / 100)
			used = true
	if !player.faint:
		if effect.has("hp"):
			if player.hp < player.hp_max:
				player.hp += round(effect["hp"] * player.hp_max / 100)
				if player.hp > player.hp_max:
					player.hp = player.hp_max
				used = true
		if effect.has("cure"):
			if player.poison:
				player.poison = false
				used = true
	if used:
		state.persist.players[player_id].mp -= master.usage_mp(player_id, id)
		return true
	else:
		return false

func magic_use_all(player_id, id):
	var used = false
	var effect = master.magic_dict[player_id][id].effect
	for i in range(3):
		var player = state.persist.players[i]
		if player.avail:
			if player.faint:
				if effect.has("heal"):
					player.faint = false
					player.poison = false
					player.hp = round(effect["heal"] * player.hp_max / 100)
					used = true
			if !player.faint:
				if effect.has("hp"):
					if player.hp < player.hp_max:
						player.hp += round(effect["hp"] * player.hp_max / 100)
						if player.hp > player.hp_max:
							player.hp = player.hp_max
						used = true
				if effect.has("cure"):
					if player.poison:
						player.poison = false
						used = true
	if used:
		state.persist.players[player_id].mp -= master.usage_mp(player_id, id)
		return true
	else:
		return false

