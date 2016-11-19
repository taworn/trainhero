
extends Container

const TIME_LIMIT = 32
const TIME_TICK = 100

var command_panel = null
var command_list = null
var text_panel = null
var text_label = null

var status = []
var monsters_on_floor = null
var monsters_on_air = null

var sound = null      # sound sample
var animation = null  # animation
var after_effect = null

var time_cumulative = 0
var menu_player = null

var player_speed_list = [
	TIME_LIMIT - state.persist.players[0].spd,
	TIME_LIMIT - state.persist.players[1].spd,
	TIME_LIMIT - state.persist.players[2].spd,
]

func _ready():
	command_panel = get_node("UI/PanelCommand")
	command_list = command_panel.get_node("CommandList")
	command_list.add_item("Attack", null)
	command_list.add_item("End", null)
	command_list.select(0)
	command_list.grab_focus()
	text_panel = get_node("UI/PanelText")
	text_label = text_panel.get_node("Text")
	status.append(get_node("UI/Status0"))
	status.append(get_node("UI/Status1"))
	status.append(get_node("UI/Status2"))

	command_panel.set_hidden(true)
	text_panel.set_hidden(true)
	status[0].set_active(false)
	status[1].set_active(false)
	status[2].set_active(false)
	status[0].update(0)
	status[1].update(1)
	status[2].update(2)

	monsters_on_floor = get_node("UI/Monsters On Floor")
	monsters_on_air = get_node("UI/Monsters On Air")
	get_node("UI/Loader").execute("res://enemies/groups/" + state.enemies_group_file + ".txt")

	get_node("MusicPlayer").play()
	animation = get_node("Effect/AnimationPlayer")
	animation.connect("finished", self, "_on_AnimationPlayer_finished")
	animation.get_node("../CanvasModulate").set_color(Color(0, 0, 0, 0))

	set_process(true)

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		pass
	elif Input.is_action_pressed("ui_cancel"):
		pass

func _process(delta):
	time_cumulative += round(delta * 1000)
	if time_cumulative > TIME_TICK:
		time_cumulative = 0
		process_wait()

func _on_AnimationPlayer_finished():
	if after_effect != null:
		after_effect = null
		state.back()

func _on_CommandList_item_activated(index):
	if index == 0:
		status[menu_player].set_active(false)
		player_speed_list[menu_player] = TIME_LIMIT - state.persist.players[menu_player].spd
		menu_player = null
		command_panel.set_hidden(true)
		set_process_input(false)
		set_process(true)

	elif index == 1:
		after_effect = {}
		animation.set_current_animation("fade_out")
		animation.play()

func process_wait():
	for i in range(3):
		if player_update(i):
			print(state.persist.players[i].name + " turn")

func player_update(index):
	if state.persist.players[index].avail:
		if !state.persist.players[index].faint:
			if player_speed_list[index] <= 0:
				set_process_input(true)
				set_process(false)
				command_panel.set_hidden(false)
				command_list.select(0)
				command_list.grab_focus()
				menu_player = index
				status[menu_player].set_active(true)
				return true
			else:
				player_speed_list[index] -= 1
				return false

