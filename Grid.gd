extends TileMap

enum {EMPTY, PLAYER, OBSTACLE, COLLECTIBLE}

var Blocks = []

var tile_size = Vector2(24, 24) #get_cell_size()
var half_tile_size = tile_size / 2

#var grid_size = Vector2(cell_quadrant_size, cell_quadrant_size)
var grid_size = Vector2(42, 25)

var grid = []
onready var Obstacle = preload("res://Obstacle.tscn")
onready var Player = preload("res://Player.tscn")
const PLAYER_STARTPOS = Vector2(4,4)


func _ready():
	print(get_cell_size(), tile_size, half_tile_size)
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(EMPTY)

	# Player
	var new_player = Player.instance()
	new_player.position = map_to_world(PLAYER_STARTPOS) + half_tile_size
	grid[PLAYER_STARTPOS.x][PLAYER_STARTPOS.y] = PLAYER
	add_child(new_player)

	#Llenado de los bloques que componen el laberinto
	FillBlocks()

	# Obstacles
	var positions = []
	for n in range(len(Blocks)):
		var Row = n / 4
		var Col = n % 4
		var RealRow = Row * 6
		var RealCol = Col * 8
#		print('Row: ', RealRow, ' Col: ', RealCol)
		for c in Blocks[n]:
			for d in c:
				if d == '1':
					var grid_pos = Vector2(RealCol, RealRow)
					positions.append(grid_pos)
				RealCol += 1
				if RealCol % 8 == 0:
					RealCol = Col * 8
					RealRow += 1


	for n in range(0):
		var placed = false
		while not placed:
			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos in positions:
					positions.append(grid_pos)
					placed = true

	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.position = map_to_world(pos) + half_tile_size
		grid[pos.x][pos.y] = OBSTACLE
		add_child(new_obstacle)


#func get_cell_entity_type(pos=Vector2()):
#	return grid[pos.x][pos.y]


# Check if cell at direction is vacant
func is_cell_vacant(this_grid_pos=Vector2(), direction=Vector2()):
	var target_grid_pos = world_to_map(this_grid_pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
			return true if grid[target_grid_pos.x][target_grid_pos.y] == EMPTY else false
	return false


# Remove node from current cell, add it to the new cell,
# returns the new world target position
func update_child_pos(this_world_pos, direction, type):

	var this_grid_pos = world_to_map(this_world_pos)
	var new_grid_pos = this_grid_pos + direction

	# remove player from current grid location
	grid[this_grid_pos.x][this_grid_pos.y] = EMPTY

	# place player on new grid location
	grid[new_grid_pos.x][new_grid_pos.y] = type

	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos


func FillBlocks():
	Blocks.append([])
	Blocks[0].append('00011000')
	Blocks[0].append('00100100')
	Blocks[0].append('01000010')
	Blocks[0].append('01111110')
	Blocks[0].append('01000010')
	Blocks[0].append('01000010')
	Blocks.append([])
	Blocks[1].append('01111110')
	Blocks[1].append('01000000')
	Blocks[1].append('01111100')
	Blocks[1].append('01000000')
	Blocks[1].append('01000000')
	Blocks[1].append('01111110')
	Blocks.append([])
	Blocks[2].append('01111100')
	Blocks[2].append('01000010')
	Blocks[2].append('01000010')
	Blocks[2].append('01000010')
	Blocks[2].append('01000010')
	Blocks[2].append('01111100')
	Blocks.append([])
	Blocks[3].append('01000010')
	Blocks[3].append('01000010')
	Blocks[3].append('01000010')
	Blocks[3].append('01111110')
	Blocks[3].append('01000010')
	Blocks[3].append('01000010')
#
#	Blocks.append([])
#	Blocks[0].append('00000000')
#	Blocks[0].append('01111100')
#	Blocks[0].append('01000000')
#	Blocks[0].append('01011100')
#	Blocks[0].append('01010100')
#	Blocks[0].append('00000000')
#	Blocks.append([])
#	Blocks[1].append('00000000')
#	Blocks[1].append('00011000')
#	Blocks[1].append('00100100')
#	Blocks[1].append('00110010')
#	Blocks[1].append('00100100')
#	Blocks[1].append('00000000')
#	Blocks.append([])
#	Blocks[2].append('00000000')
#	Blocks[2].append('01111110')
#	Blocks[2].append('01000010')
#	Blocks[2].append('00010010')
#	Blocks[2].append('01111110')
#	Blocks[2].append('00000000')
#	Blocks.append([])
#	Blocks[3].append('00000000')
#	Blocks[3].append('01000010')
#	Blocks[3].append('00100100')
#	Blocks[3].append('00110010')
#	Blocks[3].append('00100100')
#	Blocks[3].append('00000000')
#	Blocks.append([])
#	Blocks[4].append('00000000')
#	Blocks[4].append('01000010')
#	Blocks[4].append('00100100')
#	Blocks[4].append('00011000')
#	Blocks[4].append('01100110')
#	Blocks[4].append('00000000')
#	Blocks.append([])
#	Blocks[5].append('10101010')
#	Blocks[5].append('00000000')
#	Blocks[5].append('01010101')
#	Blocks[5].append('00000000')
#	Blocks[5].append('10101010')
#	Blocks[5].append('00000000')
#	Blocks.append([])
#	Blocks[6].append('11111111')
#	Blocks[6].append('10000001')
#	Blocks[6].append('10000001')
#	Blocks[6].append('10000001')
#	Blocks[6].append('10000001')
#	Blocks[6].append('11111111')
