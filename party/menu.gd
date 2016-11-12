
extends Container

const SAVE_COUNT = 2

var party = null

var menu_list = null
var save_list = null

func _ready():
	set_hidden(true)

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

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		pass
	elif Input.is_action_pressed("ui_cancel"):
		close()

func _on_MenuList_item_activated(index):
	save_list.set_hidden(true)

	print("activate: ", index)

	if index == 0:
		pass
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
	print("activate(save): ", index)
	var save = "user://game%d.save" % index
	state.save_game(save)
	close()

func open(party):
	self.party = party
	party.paused = true
	party.set_process(false)
	party.set_process_input(false)
	set_process_input(true)
	set_hidden(false)

	save_list.set_hidden(true)
	menu_list.select(0)
	menu_list.grab_focus()

func close():
	set_hidden(true)
	set_process_input(false)
	party.set_process_input(true)
	party.set_process(true)
	party.paused = false

