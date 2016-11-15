
extends Panel

var name = null
var hp = null
var mp = null

func _ready():
	name = get_node("Container/Name")
	hp = get_node("Container/HP")
	mp = get_node("Container/MP")

func update(index):
	var entry = state.persist.players[index]
	name.set_text(entry.name)
	hp.set_text("HP %d/%d" % [entry.hp, entry.hp_max])
	mp.set_text("MP %d/%d" % [entry.mp, entry.mp_max])

