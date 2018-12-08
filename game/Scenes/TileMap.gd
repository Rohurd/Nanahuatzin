extends TileMap

const WATER = 11

func _ready():
	var water_nav = tile_set.tile_get_navigation_polygon(WATER)
	for x in LevelStatus.size.x:
		for y in LevelStatus.size.y:
			var c = get_cell(x, y)
			if c == -1:
				set_cell(x, y, WATER)
	update_dirty_quadrants()
	_recreate_quadrants()
	update_dirty_quadrants()
	#$"..".update()
