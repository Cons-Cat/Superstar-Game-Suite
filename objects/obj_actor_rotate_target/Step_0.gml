/// @description Insert description here
event_inherited();

if (mouse_check_button_released(mb_left)) {
	if canRelease {
		if canDel {
			if instance_exists(obj_actor_button_rotate) {
				obj_actor_button_rotate.angle = trg.angle;
			}
			
			with trg {
				angle = other.angleExport;
				trg.dirIsoDefault = other.angleExport;
				canDeSelect = true;
			}
			
			instance_destroy();
		} else {
			canDrag = true;
			canPlace = false;
			
			alarm[0] = 18;
		}
	} else {
		// The first mouse button release does not count
		canRelease = true;
	}
}
