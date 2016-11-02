
extends Panel

var party = null

func _ready():
	party = get_node("/root/party")
	party.set_current_scene(self)
	var list = get_node("ItemList")
	list.add_item("Save #0", null)
	list.add_item("Save #1", null)
	list.select(0)
	list.grab_focus()
	set_process_input(true)

func _exit_tree():
	party.set_current_scene(null)
	
func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		party.back()

func _on_ItemList_item_activated( index ):
	var list = get_node("ItemList")
	if index == 0:
		party.save_game("user://game-0.save")
	elif index == 1:
		party.save_game("user://game-1.save")
	party.back()

func warp_to(nodeName):
	return null

func scene_name():
	return "Menu"

