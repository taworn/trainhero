
extends Node2D

var party = null

func _ready():
	party = get_node("/root/party")
	var list = get_node("ItemList")
	list.add_item("Attack", null)
	list.add_item("End", null)
	list.select(0)
	list.grab_focus()
	get_node("MusicPlayer").play()

func _on_ItemList_item_activated(index):
	var list = get_node("ItemList")
	if index == 1:
		party.back()

