
extends Panel

var party = null
var list = null

func _ready():
	party = get_node("/root/party")
	list = get_node("Menu")
	list.add_item("New Game", null)
	list.add_item("Save Game #0", null)
	list.add_item("Save Game #1", null)
	list.select(0)
	list.grab_focus()
	get_node("MusicPlayer").play()

func _on_Menu_item_activated(index):
	list.release_focus()
	list.hide()
	if index == 0:
		party.start_game()
	elif index == 1:
		party.load_game("user://game-0.save")
	elif index == 2:
		party.load_game("user://game-1.save")

