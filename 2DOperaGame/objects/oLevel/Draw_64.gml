//draw_text(10, 25, "chests: " + string(instance_number(oChest)));

var hp = global.currentHealth

draw_text(10, 10, "hearts:")
if(hp == 3){
	draw_sprite_ext(Heart, 0, 87, 22, 2, 2, 0, c_white, 1)
	draw_sprite_ext(Heart, 0, 120, 22, 2, 2, 0, c_white, 1)
	draw_sprite_ext(Heart, 0, 153, 22, 2, 2, 0, c_white, 1)
}
if(hp == 2){
	draw_sprite_ext(Heart, 0, 87, 22, 2, 2, 0, c_white, 1)
	draw_sprite_ext(Heart, 0, 120, 22, 2, 2, 0, c_white, 1)
	draw_sprite_ext(Heart, 1, 153, 22, 2, 2, 0, c_white, 1)
}
if(hp == 1){
	draw_sprite_ext(Heart, 0, 87, 22, 2, 2, 0, c_white, 1)
	draw_sprite_ext(Heart, 1, 120, 22, 2, 2, 0, c_white, 1)
	draw_sprite_ext(Heart, 1, 153, 22, 2, 2, 0, c_white, 1)
}

draw_text(10, 30, "level: " + string(global.level))
draw_text(10, 45, "chests: " + string(instance_number(oChest)))
