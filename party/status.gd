
extends Panel

var icon = null
var name = null
var hp = null
var mp = null
var att = null
var mag = null
var def = null
var spd = null

func _ready():
	icon = get_node("Icon")
	name = get_node("Container/Name")
	hp = get_node("Container/HP")
	mp = get_node("Container/MP")
	att = get_node("Container/Att")
	mag = get_node("Container/Mag")
	def = get_node("Container/Def")
	spd = get_node("Container/Spd")

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
			icon.set_animation("down")
		if !unusual:
			name.set("custom_colors/font_color", Color(1, 1, 1))
			hp.set("custom_colors/font_color", Color(1, 1, 1))
			mp.set("custom_colors/font_color", Color(1, 1, 1))
			att.set("custom_colors/font_color", Color(1, 1, 1))
			mag.set("custom_colors/font_color", Color(1, 1, 1))
			def.set("custom_colors/font_color", Color(1, 1, 1))
			spd.set("custom_colors/font_color", Color(1, 1, 1))
		else:
			name.set("custom_colors/font_color", Color(1, 0.2, 0.2))
			hp.set("custom_colors/font_color", Color(1, 0.2, 0.2))
			mp.set("custom_colors/font_color", Color(1, 0.2, 0.2))
			att.set("custom_colors/font_color", Color(1, 0.2, 0.2))
			mag.set("custom_colors/font_color", Color(1, 0.2, 0.2))
			def.set("custom_colors/font_color", Color(1, 0.2, 0.2))
			spd.set("custom_colors/font_color", Color(1, 0.2, 0.2))
		name.set_text(player.name)
		hp.set_text("HP %d/%d" % [player.hp, player.hp_max])
		mp.set_text("MP %d/%d" % [player.mp, player.mp_max])
		att.set_text("ATT %d" % (player.att + master.equip_dict[index][player.weapon].att))
		mag.set_text("MAG %d" % (player.mag + master.equip_dict[index][player.weapon].mag))
		def.set_text("DEF %d" % (player.def + master.equip_dict[index][player.armor].def + master.equip_dict[index][player.accessory].def))
		spd.set_text("SPD %d" % player.spd)
	else:
		icon.set_animation("")
		name.set_text("")
		hp.set_text("")
		mp.set_text("")
		att.set_text("")
		mag.set_text("")
		def.set_text("")
		spd.set_text("")

