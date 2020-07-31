/// @description Increment string
if keyboard_check_pressed(global.jumpInput) {
    if current < message_end {
		//current += 1;
    }
}

if characters[textRows-1] < string_length(message[current,textRows-1]) { // If the last row is not filled
	if characters[rowCurrent] < string_length(message[current,rowCurrent]) {
		characters[rowCurrent] += increase;
		message_draw[rowCurrent] = string_copy(message[current,rowCurrent],0,characters[rowCurrent]);
	} else {
		characters[rowCurrent] = string_length(message[current,rowCurrent]);
		rowCurrent += 1;
	}
} else {
	//if freeDecay = 0 {
		if keyboard_check_pressed(global.jumpInput) {
		    if message_current < message_end {
	            message_current += 1;
	            message_length = string_length(message[current,message_current]);
	            characters = 0;
				rowCurrent = 0;
	            message_draw[0,0] = "";
		    } else {
				if !canMove {
					// Let the player move after being frozen in dialogue
					obj_player_overworld.canMove = true;
				}
				
				instance_destroy();
			}
		}
	//}
}
