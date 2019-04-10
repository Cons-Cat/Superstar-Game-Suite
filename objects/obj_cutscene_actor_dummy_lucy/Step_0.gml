/// @description 
if !instance_exists(trg) {
	instance_destroy();
} else {
	if trg.select {
		//depth = trg.depth - 3;
		zfloor = trg.zfloor;
		depth = obj_editor_gui.depth -(trg.y + zfloor*20 + 20) - zfloor - room_height - 104;
	} else {
		instance_destroy();
	}
}

// Do not obstruct higher level interfaces
if canSelect {
	image_alpha = 1;
} else {
	image_alpha = 0.5;
}

canSelect = true;

event_inherited();
