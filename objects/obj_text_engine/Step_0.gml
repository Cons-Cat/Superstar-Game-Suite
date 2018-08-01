/// @description Increment string
message_draw = (message[current]);
message_length = string_length(message[current]);

if keyboard_check_pressed(_A) {
    if current < message_end {
        current += 1;
    }
}

if characters < message_length {
    characters += increase;
    message_draw = string_copy(message[message_current],0,characters);
} else {
	if freeDecay = 0 {
		if keyboard_check_pressed(_A) {
		    if message_current < message_end {
	            message_current += 1;
	            message_length = string_length(message[message_current]);
	            characters = 0;
	            message_draw = "";
		    } else {
				if !canMove {
					// Let the player move after being frozen in dialogue
					obj_player_overworld.canMove = true;
				}
				instance_destroy();
			}
		}
	}
}
