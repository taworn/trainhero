
extends Container

const FORMAT_MAGIC_STOCK = "%s (-%dMP)"
const FORMAT_ITEM_STOCK = "%s x%d"

var deep_level = 0
var battle = null
var player_id = null
var result = null

var command_panel = null
var command_list = null
var magic_list = null
var magic_target_list = null
var item_list_data = null
var item_list = null
var item_target_list = null

func _ready():
	command_panel = get_node("PanelCommand")
	command_list = get_node("PanelCommand/CommandList")
	command_list.add_item("Attack")
	command_list.add_item("Magic")
	command_list.add_item("Item")
	command_list.add_item("Wait")
	command_list.add_item("Runaway")

	magic_list = get_node("PanelCommand/MagicList")
	magic_target_list = get_node("PanelCommand/MagicTargetList")
	item_list_data = []
	item_list = get_node("PanelCommand/ItemList")
	item_target_list = get_node("PanelCommand/ItemTargetList")

	set_hidden(true)

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		pass
	elif Input.is_action_pressed("ui_cancel"):
		if deep_level > 0:
			cancel()

func _on_CommandList_item_activated(index):
	magic_list.set_hidden(true)
	magic_target_list.set_hidden(true)
	item_list.set_hidden(true)
	item_target_list.set_hidden(true)

	deep_level = 1
	if index == 0:
		result = {
			"name": "attack",
			"take_time": 1,
			"target": "unknown",
		}
		close()

	elif index == 1:
		magic_list.clear()
		for i in state.persist.players[player_id].magics:
			magic_list.add_item(FORMAT_MAGIC_STOCK % [master.magic_dict[player_id][i].name, master.magic_dict[player_id][i].mp])
		magic_list.set_hidden(false)
		magic_list.select(0)
		magic_list.grab_focus()

	elif index == 2:
		item_list_data.clear()
		item_list.clear()
		for i in master.item_list_sort:
			if state.persist.items[i] > 0:
				item_list_data.append(i)
				item_list.add_item(FORMAT_ITEM_STOCK % [master.item_dict[i].name, state.persist.items[i]])
		item_list.set_hidden(false)
		item_list.select(0)
		item_list.grab_focus()

	elif index == 3:
		result = {
			"name": "wait",
			"take_time": 5,
		}
		close()

	elif index == 4:
		result = {
			"name": "runaway",
			"take_time": 10,
		}
		close()

func _on_MagicList_item_activated(index):
	var id = state.persist.players[player_id].magics[index]
	var players = magic_check(player_id, id)
	if typeof(players) == TYPE_ARRAY:
		if players.size() > 0:
			magic_target_list.clear()
			for i in players:
				magic_target_list.add_item(state.persist.players[i].name)
			magic_target_list.set_hidden(false)
			magic_target_list.select(0)
			magic_target_list.grab_focus()
			return
	else:
		if players:
			result = {
				"name": "magic",
				"take_time": master.magic_dict[player_id][id].time,
				"magic": id,
				"side": "party",
				"target": "all",
			}
			close()
			return
	battle.sound.play("error")

func _on_MagicTargetList_item_activated(index):
	var name = magic_target_list.get_item_text(index)
	var player = state.persist.players[state.player_dict[name]]
	var selected = magic_list.get_selected_items()
	var id = state.persist.players[player_id].magics[selected[0]]
	result = {
		"name": "magic",
		"take_time": master.magic_dict[player_id][id].time,
		"magic": id,
		"side": "party",
		"target": state.player_dict[player.name],
	}
	close()

func _on_ItemList_item_activated(index):
	var id = item_list_data[index]
	item_target_list.clear()
	var players = item_check(id)
	if players.size() > 0:
		for i in players:
			item_target_list.add_item(state.persist.players[i].name)
		item_target_list.set_hidden(false)
		item_target_list.select(0)
		item_target_list.grab_focus()
	else:
		battle.sound.play("error")

func _on_ItemPlayerList_item_activated(index):
	var name = item_target_list.get_item_text(index)
	var player = state.persist.players[state.player_dict[name]]
	var selected = item_list.get_selected_items()
	result = {
		"name": "item",
		"take_time": 1,
		"item": item_list_data[selected[0]],
		"target": state.player_dict[name],
	}
	close()

func refresh():
	cancel()

func cancel():
	deep_level = 0
	magic_list.set_hidden(true)
	magic_target_list.set_hidden(true)
	item_list.set_hidden(true)
	item_target_list.set_hidden(true)
	command_list.set_hidden(false)
	command_list.grab_focus()

func close():
	set_hidden(true)
	set_process_input(false)
	battle.set_process(true)
	battle = null

func open(battle, player_id):
	self.battle = battle
	self.player_id = player_id
	battle.set_process(false)
	set_process_input(true)
	set_hidden(false)
	refresh()
	command_list.select(0)

func is_opened():
	return battle != null

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

func magic_check(player_id, id):
	if state.persist.players[player_id].mp < master.magic_dict[player_id][id].mp:
		return false
	var players = []
	var effect = master.magic_dict[player_id][id].effect
	if !effect.has("all"):
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

