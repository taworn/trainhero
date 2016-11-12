
extends Container

var party = null

var list = null
var sale_list = null

func _ready():
	sale_list = get_node("SaleList")
	set_hidden(true)

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		var selected = sale_list.get_selected_items()
		if selected.size() > 0:
			var index = selected[0]
			if index >= 0 && index < list.size():
				print("buy index: ", index)
			else:
				close()
	elif Input.is_action_pressed("ui_cancel"):
		close()

func is_opened():
	return party != null

func open(party, list):
	self.party = party
	self.list = list
	party.scripting.set_process_input(false)
	set_process_input(true)
	set_hidden(false)

	sale_list.clear()
	for i in list:
		sale_list.add_item(i, null)
	sale_list.add_item("Return Game", null)
	sale_list.select(0)
	sale_list.grab_focus()

func close():
	set_hidden(true)
	set_process_input(false)
	party.scripting.set_process_input(true)
	party = null

