if(place_meeting(x,y,oPlayer)) && (chestTriggered == false){
	if(keyboard_check_pressed(vk_space)){
		chestTriggered = true
		if(loot == 1) && chestOpened == false{ instance_create_depth(x,y,-1000,oGunVisual) chestOpened = true}
		/*if(loot = 2) && chestOpened == false{ instance_create_depth(x,y,-1000,oShootyshooty) chestOpened = true}
		if(loot = 3) && chestOpened == false{ instance_create_depth(x,y,-1000,onotimetoreactboi) chestOpened = true}*/
		global.currentscore += 100
		alarm[1] = 10;
	}
}