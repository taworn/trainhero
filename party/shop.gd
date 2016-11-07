
extends Container

var container = null
var items = null

func _ready():
	container = get_node(".")
	container.set_hidden(true)	
	set_process_input(true)

func _input(event):
	if !container.is_hidden():
		if Input.is_action_pressed("ui_accept"):
			var list = get_node("SaleList")
			print("buy ", list.get_selected_items());
	
func open(items):
	self.items = items
	var list = get_node("SaleList")
	list.clear()	
	for i in self.items:
		list.add_item(i, null)
	list.select(0)
	list.grab_focus()
	container.set_hidden(false)

func close():
	container.set_hidden(true)

