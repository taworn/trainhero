
extends Container

const WAIT_ACCEPT = 1
const WAIT_SHOP = 2
const WAIT_IDLE = 3
const WAIT_HERO = 4
const WAIT_NPC = 5

var panel_title = null
var panel_text = null
var title = null
var text = null

var party = null
var with = null

var dialog = null
var wait = 0
var title_hidden = false

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
	if wait != 0:
		if wait == WAIT_SHOP:
			if party.shop.is_opened():
				return
			panel_title.set_hidden(false)
			panel_text.set_hidden(false)

		elif wait == WAIT_IDLE:
			pass

		elif wait == WAIT_HERO:
			if party.hero.is_moving():
				return

		elif wait == WAIT_NPC:
			if with.is_moving():
				return

		set_process(false)
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
	party.set_process(false)
	party.set_process_input(false)
	with.set_pause(true)
	set_process_input(true)
	set_hidden(false)
	var face = party.check_face_to_hero()
	with.set_face(face)

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
	with.set_pause(false)
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

	elif typeof(d) == TYPE_ARRAY:
		# command
		if d[0] == global.SCRIPT_OPEN_SHOP:
			panel_title.set_hidden(true)
			panel_text.set_hidden(true)
			party.shop.open(party, party.get_sale_list(with.get_name()))
			wait = WAIT_SHOP

		elif d[0] == global.SCRIPT_TITLE_VISIBLE:
			panel_title.set_hidden(!d[1])
			wait = WAIT_IDLE

		elif d[0] == global.SCRIPT_TITLE_SET:
			var s
			if d[1] == 0:
				s = "Hero"
			elif d[1] == 1:
				s = with.get_name()
			else:
				s = d[1]
			title.set_text(s)
			wait = WAIT_IDLE

		elif d[0] == global.SCRIPT_HERO_FACE:
			party.hero.set_face(d[1])
			wait = WAIT_IDLE

		elif d[0] == global.SCRIPT_NPC_FACE:
			if d[1] == null:
				with.set_face(party.check_face_to_hero())
			else:
				with.set_face(d[1])
			wait = WAIT_IDLE

		elif d[0] == global.SCRIPT_HERO_WALK:
			party.hero.move(d[1])
			wait = WAIT_HERO

		elif d[0] == global.SCRIPT_NPC_WALK:
			with.move(d[1])
			wait = WAIT_NPC

		elif d[0] == global.SCRIPT_BATTLE:
			party.open_battle()
			wait = WAIT_IDLE

		set_process(true)

