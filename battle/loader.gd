
extends Node

func execute(group_file):
	print("open enemies group file: " + group_file)
	var lines = []
	var f = File.new()
	f.open(group_file, File.READ)
	while (!f.eof_reached()):
		var line = f.get_csv_line()
		lines.append(line)
	f.close()

	var monsters_on_floor = get_node("../Monsters On Floor")
	var monsters_on_air = get_node("../Monsters On Air")
	for i in lines:
		var enemy_to_load = null
		var enemy_count = 0
		if i.size() == 1:
			if i[0] != "":
				enemy_to_load = i[0]
				enemy_count = 1
		elif i.size() > 1:
			enemy_to_load = i[0]
			randomize()
			enemy_count = randi() % (int(i[1]) + 1)
		while enemy_count > 0:
			var template = load("res://enemies/" + enemy_to_load + ".tscn")
			var enemy = template.instance()
			if enemy.data.has("on_air"):
				monsters_on_air.add_child(enemy)
			else:
				monsters_on_floor.add_child(enemy)
			enemy_count -= 1

	var h0 = setup_layout(monsters_on_floor, 0)
	var h1 = setup_layout(monsters_on_air, 1)
	var pos
	pos = monsters_on_floor.get_pos()
	monsters_on_floor.set_pos(Vector2(pos.x, 410 - h0))
	pos = monsters_on_air.get_pos()
	monsters_on_air.set_pos(Vector2(pos.x, 50))
	if monsters_on_air.get_child_count() <= 0:
		pos = monsters_on_floor.get_pos()
		monsters_on_floor.set_pos(Vector2(pos.x, 375 - h0))
	if monsters_on_floor.get_child_count() <= 0:
		pos = monsters_on_air.get_pos()
		monsters_on_air.set_pos(Vector2(pos.x, 100))

func setup_layout(monsters, on_air):
	var x = 0
	var y = 0
	var count = monsters.get_child_count()
	var space = 0
	var i = 0

	# first round, get positions
	while i < count:
		var child = monsters.get_child(i)
		var filename = child.get_filename().basename() + ".png"
		var image = load(filename)
		child.data.width = image.get_width()
		child.data.height = image.get_height()
		x += child.data.width
		if y < child.data.height:
			y = child.data.height
		i += 1
	if count > 1:
		# align with spaces
		var border = global.screen_size.x - 64
		var widths = (count - 1) * 24 + x
		if widths <= border:
			space = 24

	# second round, align positions
	x = 0
	i = 0
	while i < count:
		var child = monsters.get_child(i)
		var pos = child.get_pos()
		if !on_air:
			child.set_pos(Vector2(x, y - child.data.height))
		else:
			child.set_pos(Vector2(x, 0))
		x += child.data.width + space
		i += 1
	if count > 1:
		x -= space
	monsters.set_pos(Vector2(global.half_screen_size.x - round(x / 2), y))

	return y

