
extends Panel

var icon = null
var name = null
var hp = null
var mp = null

var data = null  # link to state.persist.players[data_id]
var data_id = -1

func _ready():
	icon = get_node("Icon")
	name = get_node("Container/Name")
	hp = get_node("Container/HP")
	mp = get_node("Container/MP")

func update(index):
	var unusual = false
	var player = state.persist.players[index]
	if player.avail:
		if player.faint:
			icon.set_animation("faint")
			unusual = true
		elif player.poison:
			icon.set_animation("wound")
			unusual = true
		else:
			icon.set_animation("up")
		if !unusual:
			name.set("custom_colors/font_color", Color(1, 1, 1))
			hp.set("custom_colors/font_color", Color(1, 1, 1))
			mp.set("custom_colors/font_color", Color(1, 1, 1))
		else:
			name.set("custom_colors/font_color", Color(1, 0.2, 0.2))
			hp.set("custom_colors/font_color", Color(1, 0.2, 0.2))
			mp.set("custom_colors/font_color", Color(1, 0.2, 0.2))
		name.set_text(player.name)
		hp.set_text("HP %d/%d" % [player.hp, player.hp_max])
		mp.set_text("MP %d/%d" % [player.mp, player.mp_max])
	else:
		icon.set_animation("")
		name.set_text("")
		hp.set_text("")
		mp.set_text("")
	data = player
	data_id = index

func set_active(b):
	get_node("Active").set_hidden(!b)

