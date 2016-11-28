
extends Node

func usage_mp(player_id, magic_id):
	var mp = master.magic_dict[player_id][magic_id].mp
	var effect = master.equip_dict[player_id][state.persist.players[player_id].weapon].effect
	if effect.has("usage_mp"):
		var cut = ceil(mp * effect["usage_mp"] / 100)
		mp -= cut
	return mp

func player_attack_monster(player_id, target):
	var player = state.persist.players[player_id]
	var attack = player.att + master.equip_dict[player_id][player.weapon].att + state.persist.level
	return attack

func player_magic_monster(player_id, magic_id, target):
	var player = state.persist.players[player_id]
	var magic = master.magic_dict[player_id][magic_id]
	var power = magic.effect.power
	# [0] base power
	# [1] player att
	# [2] player mag
	# [3] x level
	# [4] element (optional)
	var attack = power[0] + power[1] + power[2] + (power[3] * state.persist.level)
	return attack

