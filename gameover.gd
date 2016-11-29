
extends Container

var next = null

func _ready():
	get_node("CanvasModulate").set_color(Color(0, 0, 0))

func _input(event):
	if Input.is_action_pressed("ui_accept") || Input.is_action_pressed("ui_cancel"):
		set_process_input(false)
		var animation = get_node("AnimationPlayer")
		animation.set_current_animation("fade_out")
		animation.play()

func _on_AnimationPlayer_finished():
	if next != null:
		print("game over, reset game")
		state.persist = state.restart_game()
		get_tree().change_scene("res://title.tscn")
	else:
		next = 0
		set_process_input(true)

