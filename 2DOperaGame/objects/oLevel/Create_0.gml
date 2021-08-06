randomize();

// Get the tile layer map id
var _wall_map_id = layer_tilemap_get_id("WallTiles");

// Set up the grid
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;
grid_ = ds_grid_create(width_, height_);
ds_grid_set_region(grid_, 0, 0, width_ - 1, height_ - 1, VOID);

// Create the controller
var _controller_x = width_ div 2;
var _controller_y = height_ div 2;
var _controller_direction = irandom(3);
var _steps = 400;

// Choose the direction change odds
var _direction_change_odds = 1;

// Generate the level
repeat (_steps) {
	grid_[# _controller_x, _controller_y] = FLOOR;
	
	
	// Rnadomize the direction
	if (irandom(_direction_change_odds) == _direction_change_odds) {
		_controller_direction = irandom(3);	
	}
	
	// Move the controller
	var _x_direction = lengthdir_x(1, _controller_direction * 90);
	var _y_direction = lengthdir_y(1, _controller_direction * 90);
	_controller_x += _x_direction;
	_controller_y += _y_direction;
	
	// Make sure we don't move outside the room
	if (_controller_x < 2 || _controller_x >= width_ - 2) {
		_controller_x += -_x_direction * 2;
	}
	if (_controller_y < 2 || _controller_y >= height_ - 2) {
		_controller_y += -_y_direction * 2;
	}
}

// Create the walls tiles
for (var _y = 1; _y < height_-1; _y++) {
	for (var _x = 1; _x < width_-1; _x++) {
		if (grid_[# _x, _y] != FLOOR) {
			var _north_tile = grid_[# _x, _y-1] == VOID;
			var _west_tile = grid_[# _x-1, _y] == VOID;
			var _east_tile = grid_[# _x+1, _y] == VOID;
			var _south_tile = grid_[# _x, _y+1] == VOID;
		
			var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
			if (_tile_index == 1) {
				grid_[# _x, _y] = FLOOR	
			}
		}
	}
}

// Create the walls tiles
for (var _y = 1; _y < height_-1; _y++) {
	for (var _x = 1; _x < width_-1; _x++) {
		if (grid_[# _x, _y] != FLOOR) {
			var _north_tile = grid_[# _x, _y-1] == VOID;
			var _west_tile = grid_[# _x-1, _y] == VOID;
			var _east_tile = grid_[# _x+1, _y] == VOID;
			var _south_tile = grid_[# _x, _y+1] == VOID;
		
			var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
			tilemap_set(_wall_map_id, _tile_index, _x, _y);
		}
	}
}

// make chests
for (var _y = 1; _y < height_-1; _y++) {
	for (var _x = 1; _x < width_-1; _x++) {
		if (grid_[# _x, _y] == FLOOR) {
			show_debug_message("started")
			var _chest_tile = 1;
			var _floor_tile = 2;
			
			var i = irandom_range(1,10)
			
			if (i > 1){i = _floor_tile}
			
			else if (i == 1){i = _chest_tile}
			
			if i == 2{
				grid_[# _x, _y] = FLOOR
				show_debug_message("floor")
			}
			else if (i == 1){
				
				show_debug_message("chest")
				grid_[# _x, _y] = CHESTFLOOR
			}
		}
		if grid_[# _x, _y] == CHESTFLOOR{
			show_debug_message("chest formed")
			instance_create_layer(_x, _y, "Instances", oChest)
		}
	}
}

//create the player on non wall tiles by checking the one it wants to spawn on and moving it if it is a wall
while (tile_get_index(tilemap_get(_wall_map_id, _controller_x, _controller_y)) > 0) {
    var directions = [];
    if (_controller_x > 1)
        array_push(directions, { x: -1, y: 0 });
    if (_controller_x < tilemap_get_width(_wall_map_id) - 1)
        array_push(directions, { x: 1, y: 0 });
    if (_controller_y > 1)
        array_push(directions, { x: 0, y: -1 });
    if (_controller_y < tilemap_get_height(_wall_map_id) - 1)
        array_push(directions, { x: 0, y: 1 });
        
    var dir = directions[irandom(array_length(directions) - 1)];
    _controller_x += dir.x;
    _controller_y += dir.y;
}

var _player_start_x = _controller_x * CELL_WIDTH + CELL_WIDTH / 2;
var _player_start_y = _controller_y * CELL_HEIGHT + CELL_HEIGHT / 2;
instance_create_layer(_player_start_x, _player_start_y, "Instances", oPlayer);
instance_create_layer(_controller_x, _controller_y, "Instances", oChest);