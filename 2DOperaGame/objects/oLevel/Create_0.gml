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

var number_of_chests = instance_number(oChest)

// make chests and enemies
if (number_of_chests == 0){
	for (var i = 2; i < width_ - 2; i+= 1){
		for (var j = 2; j < height_ - 2; j+= 1){
			var tile = tilemap_get_at_pixel(_wall_map_id, i * CELL_WIDTH, j * CELL_HEIGHT)
			if (tile == 0){
				if(random(1) < 0.01){
					instance_create_depth(i * CELL_WIDTH, j * CELL_HEIGHT, 0, oChest)
					var tileright = tilemap_get_at_pixel(_wall_map_id, (i + 1) * CELL_WIDTH, j * CELL_HEIGHT)
					if(tileright == 0)
						if(random(1) < 0.25)
							instance_create_layer((i + 1) * CELL_WIDTH, j * CELL_HEIGHT, "Instances", oEnemy1)
					var tileleft = tilemap_get_at_pixel(_wall_map_id, (i - 1) * CELL_WIDTH, j * CELL_HEIGHT)
					if(tileleft == 0)
						if(random(1) < 0.25)
							instance_create_layer((i - 1) * CELL_WIDTH, j * CELL_HEIGHT, "Instances", oEnemy1)
					var tiledown = tilemap_get_at_pixel(_wall_map_id, i * CELL_WIDTH, (j + 1) * CELL_HEIGHT)
					if(tiledown == 0)
						if(random(1) < 0.25)
							instance_create_layer(i * CELL_WIDTH, (j + 1) * CELL_HEIGHT, "Instances", oEnemy1)
					if(grid_[# i, j - 1] == 0)
						if (random(1) < 0.25)
							instance_create_layer(i * CELL_WIDTH, (j + 1) * CELL_HEIGHT, "Instances", oEnemy1)
				}
			}
		}
	}
}

var floors = ds_list_create();
for (var i = 2; i < width_ - 2; i += 1) {
  for (var j = 2; j < height_ - 2; j += 1) {
    var index = tilemap_get_at_pixel(_wall_map_id, i * CELL_WIDTH, j * CELL_HEIGHT);
    if (index == 0) {
      ds_list_add(floors, {x: i * CELL_WIDTH, y: j * CELL_HEIGHT});
    }
  }
}
ds_list_shuffle(floors);
var offset = CELL_HEIGHT / 2;
instance_create_layer
(floors[| 0].x + offset, floors[| 0].y + offset, "Instances", oPlayer);
ds_list_destroy(floors);


var number_of_finish = instance_number(oFinish)

// make finishing tile
while (number_of_finish != 1){
	for (var i = 2; i < width_ - 2; i+= 1){
		for (var j = 2; j < height_ - 2; j+= 1){
			var tile = tilemap_get_at_pixel(_wall_map_id, i * CELL_WIDTH, j * CELL_HEIGHT)
			if (instance_number(oFinish) == 1)
				return;
			if (tile == 0){
				if(random(1) < 0.02){
					instance_create_depth(i * CELL_WIDTH, j * CELL_HEIGHT, 0, oFinish)
				}
			}
		}
	}
}