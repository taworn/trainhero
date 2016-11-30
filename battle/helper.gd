
extends Container

var panel_text = null
var text = null

func _ready():
	panel_text = get_node("PanelText")
	text = get_node("PanelText/Text")
	panel_text.set_hidden(true)
	get_node("PanelGameOver").set_hidden(true)
	get_node("PanelWin").set_hidden(true)

func set_message(message = null):
	if message != null:
		text.set_text(message)
		panel_text.set_hidden(false)
	else:
		text.set_text("")
		panel_text.set_hidden(true)

func open_game_over():
	get_node("PanelGameOver").set_hidden(false)

func open_win(receive_item_count):
	var message
	if receive_item_count <= 0:
		message = "Gold and Exp received"
	else:
		if receive_item_count == 1:
			message = "Item received\nGold and Exp received"
		else:
			message = "Item(s) received\nGold and Exp received"
	get_node("PanelWin/TextWin").set_text(message)
	get_node("PanelWin").set_hidden(false)

