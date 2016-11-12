
extends Container

const WAIT_ACCEPT = 1
const WAIT_PROCESS = 2

var panel_title = null
var panel_text = null
var title = null
var text = null

var party = null
var with = null

var dialog = null
var wait = 0

func _ready():
	panel_title = get_node("PanelTitle")
	panel_text = get_node("PanelText")
	title = get_node("PanelTitle/Title")
	text = get_node("PanelText/Text")
	set_hidden(true)

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		if wait == WAIT_ACCEPT:
			if dialog.size() > 0:
				execute()
			else:
				close()
	elif Input.is_action_pressed("ui_cancel"):
		close()

func _process(delta):
	if wait == WAIT_PROCESS:
		if !party.shop.is_opened():
			panel_title.set_hidden(false)
			panel_text.set_hidden(false)
			wait = 0
			if dialog.size() > 0:
				execute()
			else:
				close()

func is_opened():
	return party != null

func open(party, with, source):
	self.party = party
	self.with = with
	with.set_pause(true)
	party.set_process(false)
	party.set_process_input(false)
	set_process_input(true)
	set_hidden(false)
	var face = party.hero.get_face()
	if face == "down":
		with.set_face("up")
	elif face == "left":
		with.set_face("right")
	elif face == "right":
		with.set_face("left")
	elif face == "up":
		with.set_face("down")

	dialog = []
	for i in source:
		dialog.append(i)

	panel_title.set_hidden(false)
	panel_text.set_hidden(false)
	title.set_text(with.get_name())
	text.set_text("")
	execute()

func open_treasure(party, with, pickup_items):
	self.party = party
	self.with = with
	party.set_process(false)
	party.set_process_input(false)
	set_process_input(true)
	set_hidden(false)

	dialog = ["%s found" % pickup_items]
	panel_title.set_hidden(true)
	panel_text.set_hidden(false)
	title.set_text("")
	execute()

func close():
	set_hidden(true)
	set_process_input(false)
	party.set_process_input(true)
	party.set_process(true)
	party = null

func execute():
	var d = dialog[0]
	dialog.remove(0)
	if typeof(d) == TYPE_STRING:
		# display string
		text.set_text(d)
		wait = WAIT_ACCEPT

	elif typeof(d) == TYPE_INT:
		# command
		if d == global.SCRIPT_OPEN_SHOP:
			panel_title.set_hidden(true)
			panel_text.set_hidden(true)
			party.shop.open(party, party.get_sale_list(with.get_name()))

		wait = WAIT_PROCESS
		set_process(true)

