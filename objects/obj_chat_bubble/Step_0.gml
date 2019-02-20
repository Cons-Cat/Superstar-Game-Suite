/// @description Flicker continue notification
if canScrawl {
	event_inherited();
}

if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode != 2 {
		instance_destroy();
	}
}

if instance_exists(trg) {
	placex = trg.x - xOffDialogue - 10;
	placey = trg.y - yOffDialogue - 5 - bounceYOff;
}

// Top left corner
lSide = placex + (width*5) - (width*5)*scale;
rSide = placex + (width*10) - (width*5) + (width*5)*scale;
tSide = placey + (height*10) - (height*10)*scale;
bSide = placey + (height*10) - (height*10)*scale + (height*10)*scale;

// Scaling effect
if scaleState = 0 {
	if scale < 1.07 {
		scale += 0.062;
	} else {
		scale = 1.07;
		scaleState = 1;
	}
}
if scaleState = 1 {
	if scale > 1 {
		scale -= 0.018;
	} else {
		scale = 1;
	}
}
if arrowScale < 1 {
	arrowScale += 0.068;
} else {
	arrowScale = 1;
}

// Fading effect
if outAlpha < 1 {
	outAlpha += 0.45;
} else {
	outAlpha = 1;
}
if inAlpha < 1 {
	inAlpha += 0.08;
} else {
	inAlpha = 1;
}

// Bouncing effect
bounceYOff -= bounceYSpd;

if bounceState = 0 {
	bounceYSpd += 0.28;
	
	if bounceYOff < 0 {
		bounceYOff = 0;
		bounceYSpd = -0.88;
		bounceState = 1;
	}
}
if bounceState = 1 {
	bounceYSpd += 0.12;
	
	if bounceYOff < 7 {
		canScrawl = true;
	}
	
	if bounceYOff < 0 {
		bounceYOff = 0;
		bounceYSpd = 0;
		bounceState = 2;
	}
}

/*if characters[i] >= message_length {
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
