
extends Object

var roll = 0

func _init():
	roll = 0

func reset():
	roll = 0

func random():
	if roll <= 0:
		roll = 1
		return false
	else:
		var i = randi() % 100
		print(roll, "-", i)
		if i > roll:
			#roll += 1
			roll += 1
			if roll > 10:
				roll = 10
			return false
		else:
			roll = 0
			return true

