
extends Node

# type of player in tilemap
const TAG_HERO = 1
const TAG_SHIP = 2
const TAG_NPC = 3
const TAG_DOOR = 4
const TAG_TREASURE = 5

# type of map scene
const TAG_NO_DUNGEON = 0
const TAG_DUNGEON = 1
const TAG_WORLD = 2

# scripting to use in dialogs
const SCRIPT_OPEN_SHOP = 1
const SCRIPT_OPEN_INN = 2
const SCRIPT_HPMP_FULL = 3
const SCRIPT_BE_FRIEND = 4
const SCRIPT_TITLE_VISIBLE = 11
const SCRIPT_TITLE_SET = 12
const SCRIPT_HERO_ACTION = 21
const SCRIPT_NPC_ACTION = 22
const SCRIPT_NPC_ACTION_ = 23
const SCRIPT_HERO_WALK = 24
const SCRIPT_NPC_WALK = 25
const SCRIPT_NPC_WALK_ = 26
const SCRIPT_NPC_HIDDEN = 30
const SCRIPT_HIDDEN_SCRIPT = 31
const SCRIPT_NO_CANCEL = 32
const SCRIPT_BATTLE = 41
const SCRIPT_READ_QUEST = 51
const SCRIPT_READ_QUEST_ = 52
const SCRIPT_WRITE_QUEST = 53
const SCRIPT_CONTINUE_IF = 54
const SCRIPT_IF_ELSE = 55

# move in direction
const MOVE_DOWN = 1
const MOVE_LEFT = 2
const MOVE_RIGHT = 3
const MOVE_UP = 4

# one step size, in pixels
const STEP_X = 64
const STEP_Y = 64

# screen size, in pixel
var screen_size = {
	"x": Globals.get("display/width"),
	"y": Globals.get("display/height"),
}
var half_screen_size = {
	"x": screen_size.x >> 1,
	"y": screen_size.y >> 1,
}

# passable walking map
var passable_walk_dict = {
	"01": 1, "04": 1, "07": 1,

	"Grass0": 1, "Grass1": 1, "Grass2": 1, "Grass3": 1,
	"Tree1": 1,
	"Town0": 1,
	"Castle0": 1, "Castle1": 1, "Castle2": 1, "Castle3": 1,
	"Mountain01": 1, "Mountain04": 1, "Mountain11": 1, "Mountain14": 1,
	"Cave0": 1, "Cave1": 1,
	"Tower0": 1,

	"Sand0": 1, "Snow0": 1,
	"Floor0": 1, "Floor1": 1, "Floor2": 1, "Floor3": 1,
	"Stair0": 1, "Stair1": 1,
	"StairDown0": 1, "StairUp0": 1,
	"StairDown1": 1, "StairUp1": 1,
	"StairDown2": 1, "StairUp2": 1,
	"StairDown3": 1, "StairUp3": 1,
	"Chair0": 1, "Bed0": 1,
	"Gate0": 1, "BigGate2": 1, "BigGate3": 1,
	"Decor0": 1,
}

# passable sailing map
var passable_sail_dict = {
	"Water0": 1,
}

# passable scripting map
var passable_script_dict = {
	"Table0": 1, "Table1": 1,
}

# converts pixel position to map position
func pixel_to_map(pixel_pos):
	return Vector2(floor(pixel_pos.x / STEP_X), floor(pixel_pos.y / STEP_Y))

# converts map position to pixel position
func map_to_pixel(map_pos):
	return Vector2(map_pos.x * STEP_X, map_pos.y * STEP_Y)

# converts position to aligh in (STEP_X, STEP_Y)
func normalize(pixel_pos):
	return map_to_pixel(pixel_to_map(pixel_pos))

