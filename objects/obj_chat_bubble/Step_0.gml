/// @description Flicker continue notification
event_inherited();

if trg = -1 {
	// Center box at the x of speaker
	placex = x-width*5;
	// Place box at the y of the speaker, minus the box's height, minus the arrow's height, minus the speaker's height
	placey = y-(height+1)*10-21-speakerHeightY;
} else {
	placex = trg.x-width*5;
	placey = trg.y-(height+1)*10-21-speakerHeightY;
}

if characters >= message_length {
	if time > 0 {
		time -= 1;
	} else {
		if corner = 8 {
			corner = 8 // Flickers to 9;
		} else {
			corner = 8;
		}
		time = 25;
	}
	
	if freeDecay > 0 {
		freeDecay -= 1;
	} else {
		instance_destroy();
	}
} else {
	time = 2;
	corner = 8;
}
