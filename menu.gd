
extends Panel

var party = null

func _ready():
	party = get_node("/root/party")
	var list = get_node("ItemList")
	list.add_item("Save #0", null)
	list.add_item("Save #1", null)
	list.select(0)
	list.grab_focus()
	set_process_input(true)

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

