
extends Panel

var icon = null
var name = null
var hp = null
var mp = null

func _ready():
	icon = get_node("Icon")
	name = get_node("Container/Name")
	hp = get_node("Container/HP")
	mp = get_node("Container/MP")

func update(index):
	var player = state.persist.players[index]
	if player.avail:
		if player.faint:
			icon.set_animation("faint")
		elif player.poison:
			icon.set_animation("wound")
		else:
			icon.set_animation("down")
		name.set_text(player.name)
		hp.set_text("HP %d/%d" % [player.hp, player.hp_max])
		mp.set_text("MP %d/%d" % [player.mp, player.mp_max])
	else:
		icon.set_animation("")
		name.set_text("")
		hp.set_text("")
		mp.set_text("")

