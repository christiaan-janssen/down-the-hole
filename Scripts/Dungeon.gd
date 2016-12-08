
extends Node2D

const BOARD_WIDTH = 10
const BOARD_HEIGHT = 10
const TILE_WIDTH = 32
const MIN_WALLS = 4
const MAX_WALLS = 15

var walls = [preload("res://Scenes/Wall1.tscn")]
var floors = [preload("res://Scenes/Floor1.tscn")]
var player = preload("res://Scenes/Player.tscn")
var obstacle = preload("res://Scenes/Obstacle1.tscn")
var tilemap
	
func _ready():
	tilemap = generate_tile_map(generate_map())
	populate_map(tilemap)
	
	
	# Add the nodes to the tree
	for x in range(tilemap.size()):
		for y in range(tilemap[x].size()):
				get_node("container").add_child(tilemap[x][y])
	
	spawn_player()

# add tiles to the 2d array
func generate_tile_map(map):
	for x in range(map.size()):
		for y in range(map[x].size()):
			# Check to see if it is a wall tile
			if (y == 0 or y == BOARD_HEIGHT -1 or x == 0 or x == BOARD_WIDTH -1):
				map[x][y] = spawn_wall_tile()
				move_x_pos()
			else:
				map[x][y] = spawn_floor_tile()
				move_x_pos()
		reset_x_pos()
		move_y_pos()
	return map

func populate_map(map):
	randomize()
	var obstacle_pos = Vector2()
	var walls = int(rand_range(MIN_WALLS, MAX_WALLS))
	for x in range(walls):
		obstacle_pos.x = int(rand_range(2, map.size() -2))
		obstacle_pos.y = int(rand_range(2, map.size() -2))
		map[obstacle_pos.y][obstacle_pos.x] = spawn_obstacle(obstacle_pos)
	
func spawn_obstacle(pos):
	var tile = obstacle.instance()
	var real_pos = Vector2()
	real_pos.x = pos.x * 32
	real_pos.y = pos.y * 32
	tile.set_pos(real_pos)
	return tile

func add_food():
	pass

func add_walls():
	pass

func build_level():
	pass

func spawn_player():
	var player_tile = player.instance()
	var player_pos = Vector2(TILE_WIDTH, BOARD_HEIGHT*TILE_WIDTH-TILE_WIDTH*2)
	player_tile.set_pos(player_pos)
	get_node("container").add_child(player_tile)

# generate a 2d array
func generate_map():
	var matrix=[]
	for x in range(BOARD_WIDTH):
		matrix.append([])
		for y in range(BOARD_HEIGHT):
			matrix[x].append(0)
	return matrix

func spawn_floor_tile():
	var new_tile = floors[0].instance()
	new_tile.set_pos(get_pos())
	return new_tile

func spawn_wall_tile():
	var new_tile = walls[0].instance()
	new_tile.set_pos(get_pos())
	return new_tile

func move_x_pos():
	var next_pos = get_pos()
	next_pos.x += TILE_WIDTH
	set_pos(next_pos)

func reset_x_pos():
	var next_pos = get_pos()
	next_pos.x = 0
	set_pos(next_pos)

func move_y_pos():
	var next_pos = get_pos()
	next_pos.y += TILE_WIDTH
	set_pos(next_pos)