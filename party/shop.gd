
extends Container

const FORMAT_MONEY = "%d G"
const FORMAT_ITEM_STOCK = "%s x%d"
const FORMAT_ITEM_SALE = "%s  %d G"

var party = null

var money = null
var list = null
var sale_list = null
var current = null

func _ready():
	set_hidden(true)
	money = get_node("PanelGold/Gold")
	sale_list = get_node("SaleList")
	current = get_node("PanelCurrent/Current")

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		var selected = sale_list.get_selected_items()
		if selected.size() > 0:
			var index = selected[0]
			if index >= 0 && index < list.size():
				buy(index)
			else:
				close()
	elif Input.is_action_pressed("ui_cancel"):
		close()

func _on_SaleList_item_selected(index):
	if index >= 0 && index < list.size():
		var id = list[index]
		current.set_text(FORMAT_ITEM_STOCK % [master.item_dict[id].name, state.persist.items[id]])
	else:
		current.set_text("")

func close():
	set_hidden(true)
	set_process_input(false)
	party.scripting.set_process_input(true)
	party = null

func open(party, list):
	self.party = party
	self.list = list
	party.scripting.set_process_input(false)
	set_process_input(true)
	set_hidden(false)

	money.set_text(FORMAT_MONEY % state.persist.gold)
	sale_list.clear()
	for i in list:
		var s = FORMAT_ITEM_SALE % [master.item_dict[i].name, master.item_dict[i].money]
		sale_list.add_item(s, null)
	sale_list.add_item("Return Game", null)
	sale_list.select(0)
	sale_list.grab_focus()
	_on_SaleList_item_selected(0)

func is_opened():
	return party != null

func buy(index):
	var id = list[index]
	if state.persist.gold >= master.item_dict[id].money:
		if state.persist.items[id] < state.LIMIT_ITEMS:
			party.sound.play("coin")
			state.persist.items[id] += 1
			state.persist.gold -= master.item_dict[id].money
			current.set_text(FORMAT_ITEM_STOCK % [master.item_dict[id].name, state.persist.items[id]])
			money.set_text(FORMAT_MONEY % state.persist.gold)
			print("buy item: " + id)
			return
	party.sound.play("error")
	print("cannot buy item: " + id)

