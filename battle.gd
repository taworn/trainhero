
extends Container

var animation = null  # animation

var after_effect = null

var command_list = null

func _ready():
	animation = get_node("Effect/AnimationPlayer")
	animation.connect("finished", self, "_on_AnimationPlayer_finished")
	animation.get_node("../CanvasModulate").set_color(Color(0, 0, 0, 0))

	command_list = get_node("UI/CommandList")
	command_list.add_item("Attack", null)
	command_list.add_item("End", null)
	command_list.select(0)
	command_list.grab_focus()
	get_node("MusicPlayer").play()

func _on_AnimationPlayer_finished():
	if after_effect != null:
		after_effect = null
		state.back()

func _on_CommandList_item_activated(index):
	if index == 1:
		after_effect = {}
		animation.set_current_animation("fade_out")
		animation.play()

