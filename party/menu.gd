
extends Container

var container = null
var menu_level = 0
var menu_list = null
var save_list = null

func _ready():
	container = get_node(".")
	container.set_hidden(true)	
	
	menu_list = get_node("MenuList")
	menu_list.add_item("Item", null)
	menu_list.add_item("Magic", null)
	menu_list.add_item("Equip", null)
	menu_list.add_item("Save", null)
	menu_list.add_item("Exit", null)

	save_list = get_node("SaveList")
	save_list.add_item("Save #0", null)
	save_list.add_item("Save #1", null)
	set_process_input(true)

func _input(event):
	if !container.is_hidden():
		if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
			pass
		if Input.is_action_pressed("ui_accept"):
			if menu_level == 0:
				var index = menu_list.get_selected_items()
				print("select(0) ", index)
				if index[0] == 3:
					menu_list.set_hidden(true)
					save_list.set_hidden(false)
					save_list.grab_focus()
					menu_level += 1
				if index[0] == 4:
					get_tree().change_scene("res://title.tscn")
					party.paused = false
			elif menu_level == 1:
				var index = save_list.get_selected_items()
				var save = "user://game-%d.save" % index[0]
				party.save_game(save)
				cancel()

func open():
	menu_level = 0
	menu_list.select(0)
	save_list.select(0)
	save_list.set_hidden(true)
	menu_list.grab_focus()
	container.set_hidden(false)

func cancel():
	if menu_level > 0:
		save_list.set_hidden(true)
		menu_list.set_hidden(false)
		menu_list.grab_focus()
		menu_level -= 1
		return false
	else:
		container.set_hidden(true)
		return true

