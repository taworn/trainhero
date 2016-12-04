
extends Object

var roll = 0
var plus = 0

func _init():
	roll = 0

func reset():
	roll = 0

func random():
	if roll <= 0:
		roll = 0
		plus = 1
		return false
	else:
		var i = randi() % 100
		print(roll, "-", i)
		if i > roll:
			roll += plus
			plus += 1
			#roll *= 2
			if roll > 25:
				roll = 25
			return false
		else:
			roll = 0
			return true

