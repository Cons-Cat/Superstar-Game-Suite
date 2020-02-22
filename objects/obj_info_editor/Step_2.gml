/// @description 
event_inherited();

if instance_exists(trg) {
	if select = 0 {
		// Top left corner
		y = trg.floorY - 20;
		
		if str2 = "" {
			if trg.width > 2 {
				x = trg.x;
			} else {
				x = trg.x - 20;
			}
		} else {
			if str2 = "mirror" {
				if trg.width > 2 {
					x = trg.x;
				} else {
					x = trg.x - 20;
				}
			}
			if str2 = "flip" {
				if trg.width > 2 {
					x = trg.x + 20;
				} else {
					x = trg.x;
				}
			}
		}
	}
}
