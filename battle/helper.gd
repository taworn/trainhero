
extends Container

var panel_text = null
var text = null

func _ready():
	panel_text = get_node("PanelText")
	text = get_node("PanelText/Text")
	panel_text.set_hidden(true)

func set_message(message = null):
	if message != null:
		text.set_text(message)
		panel_text.set_hidden(false)
	else:
		text.set_text("")
		panel_text.set_hidden(true)

