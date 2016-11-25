
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

