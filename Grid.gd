extends TileMap

enum {EMPTY, PLAYER, OBSTACLE, INSIDE, COLLECTIBLE}

var Blocks = []

var tile_size = get_cell_size() #Vector2(63, 37) #
var half_tile_size = tile_size / 2

#var grid_size = Vector2(cell_quadrant_size, cell_quadrant_size)
var grid_size = Vector2(63, 37)

var grid = []
onready var Obstacle = preload("res://Obstacle.tscn")
onready var Player = preload("res://Player.tscn")
const PLAYER_STARTPOS = Vector2(1, 1)

func _ready():
#	print(get_cell_size(), tile_size, half_tile_size)
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
		var Row = n / 9
		var Col = n % 9
		var RealRow = Row * 6
		var RealCol = Col * 7
#		print('Row: ', RealRow, ' Col: ', RealCol)
		for c in Blocks[n]:
			for d in c:
				if d == '1' or d == '.':
					var grid_pos = Vector2(RealCol, RealRow)
					positions.append(grid_pos)
					var new_obstacle = Obstacle.instance()
					new_obstacle.position = map_to_world(grid_pos) + half_tile_size
					if d == '1':
						grid[grid_pos.x][grid_pos.y] = OBSTACLE
						add_child(new_obstacle)
					else:
						grid[grid_pos.x][grid_pos.y] = INSIDE

				RealCol += 1
				if RealCol % 7 == 0:
					RealCol = Col * 7
					RealRow += 1


# Check if cell at direction is vacant
func is_cell_vacant(this_grid_pos=Vector2(), direction=Vector2()):
	var target_grid_pos = world_to_map(this_grid_pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
			return grid[target_grid_pos.x][target_grid_pos.y] == EMPTY
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
	Blocks[0].append('       ')
	Blocks[0].append('   1   ')
	Blocks[0].append('  1.1  ')
	Blocks[0].append(' 1...1 ')
	Blocks[0].append(' 11111 ')
	Blocks[0].append(' 1...1 ')
	Blocks.append([])
	Blocks[1].append('       ')
	Blocks[1].append(' 111   ')
	Blocks[1].append(' 1..1  ')
	Blocks[1].append(' 1111  ')
	Blocks[1].append(' 1...1 ')
	Blocks[1].append(' 11111 ')
	Blocks.append([])
	Blocks[2].append('       ')
	Blocks[2].append(' 11111 ')
	Blocks[2].append(' 1     ')
	Blocks[2].append(' 1     ')
	Blocks[2].append(' 1     ')
	Blocks[2].append(' 11111 ')
	Blocks.append([])
	Blocks[3].append('       ')
	Blocks[3].append(' 1111  ')
	Blocks[3].append(' 1...1 ')
	Blocks[3].append(' 1...1 ')
	Blocks[3].append(' 1...1 ')
	Blocks[3].append(' 1111  ')
	Blocks.append([])
	Blocks[4].append('       ')
	Blocks[4].append(' 11111 ')
	Blocks[4].append(' 1     ')
	Blocks[4].append(' 1111  ')
	Blocks[4].append(' 1     ')
	Blocks[4].append(' 11111 ')
	Blocks.append([])
	Blocks[5].append('       ')
	Blocks[5].append(' 11111 ')
	Blocks[5].append(' 1     ')
	Blocks[5].append(' 1111  ')
	Blocks[5].append(' 1     ')
	Blocks[5].append(' 1     ')
	Blocks.append([])
	Blocks[6].append('       ')
	Blocks[6].append(' 11111 ')
	Blocks[6].append(' 1     ')
	Blocks[6].append(' 1  11 ')
	Blocks[6].append(' 1   1 ')
	Blocks[6].append(' 11111 ')
	Blocks.append([])
	Blocks[7].append('       ')
	Blocks[7].append(' 1   1 ')
	Blocks[7].append(' 1   1 ')
	Blocks[7].append(' 11111 ')
	Blocks[7].append(' 1   1 ')
	Blocks[7].append(' 1   1 ')
	Blocks.append([])
	Blocks[8].append('       ')
	Blocks[8].append('  111  ')
	Blocks[8].append('   1   ')
	Blocks[8].append('   1   ')
	Blocks[8].append('   1   ')
	Blocks[8].append('  111  ')
	Blocks.append([])
	Blocks[9].append('       ')
	Blocks[9].append('   111 ')
	Blocks[9].append('    1  ')
	Blocks[9].append('    1  ')
	Blocks[9].append(' 1  1  ')
	Blocks[9].append('  111  ')
	Blocks.append([])
	Blocks[10].append('       ')
	Blocks[10].append(' 1   1 ')
	Blocks[10].append(' 1  1  ')
	Blocks[10].append(' 111   ')
	Blocks[10].append(' 1  1  ')
	Blocks[10].append(' 1   1 ')
	Blocks.append([])
	Blocks[11].append('       ')
	Blocks[11].append(' 1     ')
	Blocks[11].append(' 1     ')
	Blocks[11].append(' 1     ')
	Blocks[11].append(' 1     ')
	Blocks[11].append(' 11111 ')
	Blocks.append([])
	Blocks[12].append('       ')
	Blocks[12].append(' 1   1 ')
	Blocks[12].append(' 11 11 ')
	Blocks[12].append(' 1 1 1 ')
	Blocks[12].append(' 1   1 ')
	Blocks[12].append(' 1   1 ')
	Blocks.append([])
	Blocks[13].append('       ')
	Blocks[13].append(' 1   1 ')
	Blocks[13].append(' 11  1 ')
	Blocks[13].append(' 1 1 1 ')
	Blocks[13].append(' 1  11 ')
	Blocks[13].append(' 1   1 ')
	Blocks.append([])
	Blocks[14].append('       ')
	Blocks[14].append(' 11111 ')
	Blocks[14].append(' 1...1 ')
	Blocks[14].append(' 1...1 ')
	Blocks[14].append(' 1...1 ')
	Blocks[14].append(' 11111 ')
	Blocks.append([])
	Blocks[15].append('       ')
	Blocks[15].append(' 11111 ')
	Blocks[15].append(' 1...1 ')
	Blocks[15].append(' 11111 ')
	Blocks[15].append(' 1     ')
	Blocks[15].append(' 1     ')
	Blocks.append([])
	Blocks[16].append('       ')
	Blocks[16].append(' 11111 ')
	Blocks[16].append(' 1...1 ')
	Blocks[16].append(' 1.1.1 ')
	Blocks[16].append(' 11..1 ')
	Blocks[16].append(' 11111 ')
	Blocks.append([])
	Blocks[17].append('       ')
	Blocks[17].append(' 11111 ')
	Blocks[17].append(' 1...1 ')
	Blocks[17].append(' 1111  ')
	Blocks[17].append(' 1  1  ')
	Blocks[17].append(' 1   1 ')
	Blocks.append([])
	Blocks[18].append('       ')
	Blocks[18].append('  1111 ')
	Blocks[18].append(' 1     ')
	Blocks[18].append('  111  ')
	Blocks[18].append('     1 ')
	Blocks[18].append(' 1111  ')
	Blocks.append([])
	Blocks[19].append('       ')
	Blocks[19].append(' 11111 ')
	Blocks[19].append('   1   ')
	Blocks[19].append('   1   ')
	Blocks[19].append('   1   ')
	Blocks[19].append('   1   ')
	Blocks.append([])
	Blocks[20].append('       ')
	Blocks[20].append(' 1   1 ')
	Blocks[20].append(' 1   1 ')
	Blocks[20].append(' 1   1 ')
	Blocks[20].append(' 1   1 ')
	Blocks[20].append('  111  ')
	Blocks.append([])
	Blocks[21].append('       ')
	Blocks[21].append(' 1   1 ')
	Blocks[21].append(' 1   1 ')
	Blocks[21].append('  1 1  ')
	Blocks[21].append('  1 1  ')
	Blocks[21].append('   1   ')
	Blocks.append([])
	Blocks[22].append('       ')
	Blocks[22].append(' 1   1 ')
	Blocks[22].append(' 1   1 ')
	Blocks[22].append(' 1 1 1 ')
	Blocks[22].append(' 11 11 ')
	Blocks[22].append(' 1   1 ')
	Blocks.append([])
	Blocks[23].append('       ')
	Blocks[23].append(' 1   1 ')
	Blocks[23].append('  1 1  ')
	Blocks[23].append('   1   ')
	Blocks[23].append('  1 1  ')
	Blocks[23].append(' 1   1 ')
	Blocks.append([])
	Blocks[24].append('       ')
	Blocks[24].append(' 1   1 ')
	Blocks[24].append('  1 1  ')
	Blocks[24].append('   1   ')
	Blocks[24].append('   1   ')
	Blocks[24].append('   1   ')
	Blocks.append([])
	Blocks[25].append('       ')
	Blocks[25].append(' 11111 ')
	Blocks[25].append('    1  ')
	Blocks[25].append('   1   ')
	Blocks[25].append('  1    ')
	Blocks[25].append(' 11111 ')
	Blocks.append([])
	Blocks[26].append('       ')
	Blocks[26].append('  111  ')
	Blocks[26].append(' 1...1 ')
	Blocks[26].append(' 1.1.1 ')
	Blocks[26].append(' 1...1 ')
	Blocks[26].append('  111  ')
	Blocks.append([])
	Blocks[27].append('       ')
	Blocks[27].append('  11   ')
	Blocks[27].append('   1   ')
	Blocks[27].append('   1   ')
	Blocks[27].append('   1   ')
	Blocks[27].append('  111  ')
	Blocks.append([])
	Blocks[28].append('       ')
	Blocks[28].append('  111  ')
	Blocks[28].append(' 1   1 ')
	Blocks[28].append('   11  ')
	Blocks[28].append('  1    ')
	Blocks[28].append(' 11111 ')
	Blocks.append([])
	Blocks[29].append('       ')
	Blocks[29].append(' 1111  ')
	Blocks[29].append('     1 ')
	Blocks[29].append('   11  ')
	Blocks[29].append('     1 ')
	Blocks[29].append(' 1111  ')
	Blocks.append([])
	Blocks[30].append('       ')
	Blocks[30].append(' 1   1 ')
	Blocks[30].append(' 1   1 ')
	Blocks[30].append(' 11111 ')
	Blocks[30].append('     1 ')
	Blocks[30].append('     1 ')
	Blocks.append([])
	Blocks[31].append('       ')
	Blocks[31].append(' 11111 ')
	Blocks[31].append(' 1     ')
	Blocks[31].append(' 1111  ')
	Blocks[31].append('     1 ')
	Blocks[31].append(' 1111  ')
	Blocks.append([])
	Blocks[32].append('       ')
	Blocks[32].append('  111  ')
	Blocks[32].append(' 1     ')
	Blocks[32].append(' 1111  ')
	Blocks[32].append(' 1...1 ')
	Blocks[32].append('  111  ')
	Blocks.append([])
	Blocks[33].append('       ')
	Blocks[33].append(' 11111 ')
	Blocks[33].append('     1 ')
	Blocks[33].append('    1  ')
	Blocks[33].append('   1   ')
	Blocks[33].append('  1    ')
	Blocks.append([])
	Blocks[34].append('       ')
	Blocks[34].append('  111  ')
	Blocks[34].append(' 1...1 ')
	Blocks[34].append('  111  ')
	Blocks[34].append(' 1...1 ')
	Blocks[34].append('  111  ')
	Blocks.append([])
	Blocks[35].append('       ')
	Blocks[35].append('  111  ')
	Blocks[35].append(' 1...1 ')
	Blocks[35].append('  1111 ')
	Blocks[35].append('     1 ')
	Blocks[35].append('  111  ')
