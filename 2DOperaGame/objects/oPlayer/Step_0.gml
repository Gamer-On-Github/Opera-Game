var _x_input = keyboard_check(vk_right) - keyboard_check(vk_left);
var _y_input = keyboard_check(vk_down) - keyboard_check(vk_up);

global.x_speed_ += _x_input * global.accelaration;
global.y_speed_ += _y_input * global.accelaration;
var _speed = point_distance(0, 0, global.x_speed_, global.y_speed_);
var _direction = point_direction(0, 0, global.x_speed_, global.y_speed_);
if (_speed > global.max_speed_) {
	global.x_speed_ = lengthdir_x(global.max_speed_, _direction);
	global.y_speed_ = lengthdir_y(global.max_speed_, _direction);
}

if (_x_input == 0) {
	global.x_speed_ = lerp(global.x_speed_, 0, .3);
}
if (_y_input == 0) {
	global.y_speed_ = lerp(global.y_speed_, 0, .3);
}

if (_x_input == 0 && _y_input == 0) {
	image_speed = 0;
	image_index = 0;
} else {
	image_speed = .7;	
}

if (global.x_speed_ > 0) {
	image_xscale = 1;	
} else if (global.x_speed_ < 0) {
	image_xscale = -1;	
}

// Move horizontally
x += global.x_speed_;

// Right collisions
if global.x_speed_ > 0 {
	if (grid_place_meeting(self, oLevel.grid_)) {
		x = bbox_right&~(CELL_WIDTH-1);
		x -= bbox_right-x;
		global.x_speed_ = 0;
	}
} else if global.x_speed_ < 0 {
	// Left collisions
	if (grid_place_meeting(self, oLevel.grid_)) {
		x = bbox_left&~(CELL_WIDTH-1);
		x += CELL_WIDTH+x-bbox_left;
		global.x_speed_ = 0;
	}
}

// Move vertically
y += global.y_speed_;

// Vertical collisions
if global.y_speed_ > 0 {
	// Bottom collisions
	if (grid_place_meeting(self, oLevel.grid_)) {
		y = bbox_bottom&~(CELL_HEIGHT-1);
		y -= bbox_bottom-y;
		global.y_speed_ = 0;
	}
} else if global.y_speed_ < 0 {
	// Top collisions
	if (grid_place_meeting(self, oLevel.grid_)) {
		y = bbox_top&~(CELL_HEIGHT-1);
		y += CELL_HEIGHT+y-bbox_top;
		global.y_speed_ = 0;
	}
}

