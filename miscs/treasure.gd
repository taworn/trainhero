
extends Node2D

var tag = global.TAG_TREASURE

var animate = null  # animation to act various tasks

func _ready():
	set_pos(global.normalize(get_pos()))
	animate = get_node("Animate")

func is_opened():
	return animate.get_animation() == "opened"

func set_opened():
	animate.set_animation("opened")

func set_pause(b):
	pass

func pickup(assets):
	var receive_item_count = 0
	var receive_key_count = 0
	var receive_equipment_count = 0
	if assets.has("items"):
		for j in assets["items"]:
			if state.persist.items[j] < state.LIMIT_ITEMS:
				state.persist.items[j] += 1
				receive_item_count += 1

	if assets.has("keys"):
		for j in assets["keys"]:
			if !state.persist.keys.has(j):
				state.persist.keys.append(j)
				receive_key_count += 1

	if assets.has("equips"):
		for j in assets["equips"]:
			for k in range(3):
				if master.equip_dict[k].has(j):
					if !state.persist.players[k].equips.has(j):
						state.persist.players[k].equips.append(j)
						receive_equipment_count += 1

	var message = ""
	if receive_item_count > 0:
		if receive_item_count == 1:
			message += "Item"
		else:
			message += "Items"
	if receive_key_count > 0:
		if message != "":
			message += ", "
		if receive_key_count == 1:
			message += "Key Item"
		else:
			message += "Key Items"
	if receive_equipment_count > 0:
		if message != "":
			message += ", "
		if receive_equipment_count == 1:
			message += "Equipment"
		else:
			message += "Equipments"
	if message != "":
		message += " found"

	return message

