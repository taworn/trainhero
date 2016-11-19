
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
		if enemy_count > 0:
			var template = load("res://enemies/" + enemy_to_load + ".tscn")
			var enemy = template.instance()
			if enemy.data.has("on_air"):
				monsters_on_air.add_child(enemy)
			else:
				monsters_on_floor.add_child(enemy)

	setup_layout(monsters_on_floor)
	setup_layout(monsters_on_air)
	var pos
	pos = monsters_on_floor.get_pos()
	monsters_on_floor.set_pos(Vector2(pos.x, 300))
	pos = monsters_on_air.get_pos()
	monsters_on_air.set_pos(Vector2(pos.x, 100))

func setup_layout(monsters):
	var y = monsters.get_pos().y
	var x = 0
	var i = 0
	while i < monsters.get_child_count():
		var child = monsters.get_child(i)
		var filename = child.get_filename().basename() + ".png"
		var image = load(filename)
		var pos = child.get_pos()
		child.set_pos(Vector2(x, y))
		x += image.get_width()
		i += 1
	monsters.set_pos(Vector2(global.half_screen_size.x - round(x / 2), y))

