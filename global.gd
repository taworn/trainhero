
extends Node

# move in direction
const MOVE_DOWN = 1
const MOVE_LEFT = 2
const MOVE_RIGHT = 3
const MOVE_UP = 4

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
var passable_walk_dict = {
	"Grass0": 1, "Grass1": 1, 
	"Tree1": 1,
	"Town0": 1,
	"Castle0": 1, "Castle1": 1, "Castle2": 1, "Castle3": 1,
}

# passable for sailing
var passable_sail_dict = {
	"Water0": 1,
}

# pass scripts
var pass_script_dict = {
	"Table0": 1, "Table1": 1,
}

# scripts in dialog
const SCRIPT_SWITCH_TITLE = 0
const SCRIPT_OPEN_SHOP = 1

func pixel_to_map(pixel_pos):
	return Vector2(round(pixel_pos.x / STEP_X), round(pixel_pos.y / STEP_Y))

func map_to_pixel(map_pos):
	return Vector2((map_pos.x - 1) * STEP_X + (STEP_X >> 1), (map_pos.y - 1) * STEP_Y + (STEP_Y >> 1))
