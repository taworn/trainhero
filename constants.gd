
extends Node

# one step size, in pixels
const STEP_X = 64
const STEP_Y = 64

# one step time, in milli-seconds
const STEP_TIME = 150

# screen size, in pixel
var screen_size = {
	"x": Globals.get("display/width"),
	"y": Globals.get("display/height"),
}
var half_screen_size = {
	"x": screen_size.x >> 1,
	"y": screen_size.y >> 1,
}

# passable for walking
var passable_walk = {
	"Grass0": 1,
	"Town0": 1,
	"Castle0": 1, "Castle1": 1, "Castle2": 1, "Castle3": 1,
}

# passable for sailing
var passable_sail = {
	"Water0": 1,
}

