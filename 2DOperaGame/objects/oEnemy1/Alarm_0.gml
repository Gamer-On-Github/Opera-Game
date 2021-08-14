
if(distance_to_object(oPlayer) < 128){
	instance_create_layer(x+16, y+16, "Instances",oEnemyDamage); // Create a bullet and store its ID in the variable "bullet". We need its ID b/c we want to do a few more things with it.
	with(oEnemyDamage){
		direction = point_direction(x, y, oPlayer.x, oPlayer.y); // Give the bullet a direction
		image_angle = direction
		speed = 6;
		
		audio_play_sound(sndShoot, 1, false)
	}
}
alarm[0] = room_speed * 3; // Reset this alarm so the enemy will shoot after 5 more seconds. This will loop.