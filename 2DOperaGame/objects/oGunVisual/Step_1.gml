x = oPlayer.x + 16
y = oPlayer.y


var firing_delay = 0
image_angle = point_direction(x,y,mouse_x,mouse_y)

firing_delay = firing_delay - 1
if (mouse_check_button_released(mb_left) && (firing_delay < 0)){
	firing_delay = 1000
	audio_play_sound(sndShoot, 1, false)
	with (instance_create_layer(x,y,"Instances",oDamage)){
		speed = 25
		direction = other.image_angle
		image_angle = direction
	}
	
}

if (mouse_check_button_released(vk_shift) && (firing_delay < 0)){
	firing_delay = 1000
	audio_play_sound(sndShoot, 1, false)
	with (instance_create_layer(x,y,"Instances",oDamage)){
		speed = 25
		direction = other.image_angle
		image_angle = direction
	}
	
}