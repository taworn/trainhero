
extends Panel

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var list = get_node("ItemList")
	list.add_item("New Game", null)
	list.add_item("Save Data #1", null)
	list.add_item("Save Data #2", null)
	list.add_item("Save Data #3", null)
	list.select(0)
	list.grab_focus()

func _on_ItemList_item_activated(index):
	var list = get_node("ItemList")
	list.release_focus()
	list.hide()
	get_tree().change_scene("res://map.tscn")

