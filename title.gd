
extends Panel

const SAVE_COUNT = 2

var menu = null
var party = null

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"World": {"x": 128, "y": 128, "map": "maps/test0"},
}

var dialog_dict = {
}

func _ready():
	menu = get_node("Menu")
	menu.add_item("New Game", null)
	for i in range(SAVE_COUNT):
		menu.add_item("Save Game #%d" % i, null)
	menu.select(0)
	menu.grab_focus()
	party = get_node("Node/TileMap/Party")
	party.set_process_input(false)
	party.set_process(false)
	party.set_current_scene(self)
	get_node("MusicPlayer").play()

func _on_Menu_item_activated(index):
	menu.release_focus()
	menu.hide()
	party.set_process_input(true)
	party.set_process(true)
	if index == 0:
		state.new_game()
	else:
		var save = "user://game%d.save" % (index - 1)
		state.load_game(save)

