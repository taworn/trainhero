
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
	var attack = round(player.att + master.equip_dict[player_id][player.weapon].att + state.persist.level)
	var defense = target.data.def
	var result = attack - defense
	if result > 0:
		return result
	elif result > -10 && result <= 0:
		return 1
	else:
		return 0

func player_magic_monster(player_id, magic_id, target):
	var player = state.persist.players[player_id]
	var magic = master.magic_dict[player_id][magic_id]
	var power = magic.effect.power
	# [0] base power
	# [1] player att
	# [2] player mag
	# [3] x level
	# [4] element (optional)
	var attack = round(power[0] + (power[1] * player.att) + (power[2] * player.mag) + (power[3] * state.persist.level))
	var defense = target.data.def
	var result = attack - defense
	if result > 0:
		return result
	elif result > -10 && result <= 0:
		return 1
	else:
		return 0

func monster_attack_player(enemy, attack, player):
	var power = round(enemy.data.att * attack.effect.power[0] + enemy.data.mag * attack.effect.power[1])
	var defense = player.data.def
	var result = power - defense
	if result > 0:
		return result
	elif result > -10 && result <= 0:
		return 1
	else:
		return 0

