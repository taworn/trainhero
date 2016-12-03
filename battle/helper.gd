
extends Container

var panel_text = null
var text = null

func _ready():
	panel_text = get_node("PanelText")
	text = get_node("PanelText/Text")
	panel_text.set_hidden(true)
	get_node("PanelGameOver").set_hidden(true)
	get_node("PanelWin").set_hidden(true)

func set_message(message = null):
	if message != null:
		text.set_text(message)
		panel_text.set_hidden(false)
	else:
		text.set_text("")
		panel_text.set_hidden(true)

func open_game_over():
	get_node("PanelGameOver").set_hidden(false)

func open_win(message):
	get_node("PanelWin/TextWin").set_text(message)
	get_node("PanelWin").set_hidden(false)

func received_after_win(monsters):
	var g = 0
	var e = 0
	var receive_item_count = 0
	var receive_key_count = 0
	var receive_equipment_count = 0
	for i in monsters:
		e += i.data["exp"]
		g += i.data["gold"]

		if i.data.has("items"):
			randomize()
			for j in i.data["items"]:
				var random = randi() % 100
				if random < i.data["items"][j]:
					if state.persist.items[j] < state.LIMIT_ITEMS:
						state.persist.items[j] += 1
						receive_item_count += 1

		if i.data.has("keys"):
			for j in i.data["keys"]:
				if !state.persist.keys.has(j):
					state.persist.keys.append(j)
					receive_key_count += 1

		if i.data.has("equips"):
			for j in i.data["equips"]:
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
		message += " received\n"
	message += "%d Gold received\n" % g
	message += "%d Exp received\n" % e

	state.persist.gold += g
	state.persist.experience += e

	var lv = levelup.exp_to_level(state.persist.experience)
	if lv - state.persist.level == 1:
		message += "Level up :)"
	elif lv - state.persist.level > 1:
		message += "%d Levels up ^_^" % (lv - state.persist.level)
	while state.persist.level < lv:
		print("level up :)")
		for i in range(3):
			state.persist.players[i].hp_max += levelup.level_hpmp[i].hp_add
			state.persist.players[i].mp_max += levelup.level_hpmp[i].mp_add
			if levelup.list[state.persist.level].has(i):
				var magics = levelup.list[state.persist.level][i]
				for j in magics:
					if !state.persist.players[i].magics.has(j):
						state.persist.players[i].magics.append(j)
		state.persist.level += 1

	open_win(message)

