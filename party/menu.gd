
extends Container

const FORMAT_MONEY = "%d G"
const FORMAT_ITEM_STOCK = "%s x%d"

const SAVE_COUNT = 2

var party = null

var money = null
var status0 = null
var status1 = null
var status2 = null
var menu_list = null
var save_list = null

var item_list_data = null
var item_list = null
var item_player_list = null

func _ready():
	set_hidden(true)

	money = get_node("PanelGold/Gold")
	status0 = get_node("Status0")
	status1 = get_node("Status1")
	status2 = get_node("Status2")

	menu_list = get_node("MenuList")
	menu_list.add_item("Items", null)
	menu_list.add_item("Magics", null)
	menu_list.add_item("Equipment", null)
	menu_list.add_item("Save Game", null)
	menu_list.add_item("Exit Game", null)
	menu_list.add_item("Return Game", null)

	save_list = get_node("SaveList")
	for i in range(SAVE_COUNT):
		save_list.add_item("Save Game #%d" % i, null)

	item_list_data = Array()
	item_list = get_node("Container/ItemList")
	item_player_list = get_node("Container/ItemPlayerList")

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		pass
	elif Input.is_action_pressed("ui_cancel"):
		close()

func _on_MenuList_item_activated(index):
	save_list.set_hidden(true)
	item_list.set_hidden(true)
	item_player_list.set_hidden(true)

	if index == 0:
		item_list.set_hidden(false)
		item_list.select(0)
		item_list.grab_focus()
	elif index == 1:
		pass
	elif index == 2:
		pass
	elif index == 3:
		save_list.set_hidden(false)
		save_list.select(0)
		save_list.grab_focus()
	elif index == 4:
		state.persist = state.restart_game()
		get_tree().change_scene("res://title.tscn")
	elif index == 5:
		close()

func _on_SaveList_item_activated(index):
	var save = "user://game%d.save" % index
	state.save_game(save)
	close()

func _on_ItemList_item_activated(index):
	var id = item_list_data[index]
	item_player_list.clear()
	var players = state.item_check(id)
	if players.size() > 0:
		for i in players:
			item_player_list.add_item(state.persist.players[i].name)
		item_player_list.set_hidden(false)
		item_player_list.select(0)
		item_player_list.grab_focus()
	else:
		party.sound.play("error")

func _on_ItemPlayerList_item_activated( index ):
	var name = item_player_list.get_item_text(index)
	var player = state.persist.players[state.players_dict[name]]
	var selected = item_list.get_selected_items()
	if state.item_use(item_list_data[selected[0]], player):
		party.sound.play("heal")
		refresh()

func open(party):
	self.party = party
	party.paused = true
	party.set_process(false)
	party.set_process_input(false)
	set_process_input(true)
	set_hidden(false)
	refresh()

func close():
	set_hidden(true)
	set_process_input(false)
	party.set_process_input(true)
	party.set_process(true)
	party.paused = false

func refresh():
	money.set_text(FORMAT_MONEY % state.persist.gold)
	status0.update(0)
	status1.update(1)
	status2.update(2)

	item_list_data.clear()
	item_list.clear()
	for i in master.item_list_sort:
		if state.persist.items[i] > 0:
			item_list_data.append(i)
			item_list.add_item(FORMAT_ITEM_STOCK % [master.item_dict[i].name, state.persist.items[i]]);

	item_list.set_hidden(true)
	item_player_list.set_hidden(true)
	save_list.set_hidden(true)
	menu_list.select(0)
	menu_list.grab_focus()

