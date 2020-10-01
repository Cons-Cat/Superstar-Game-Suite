function angleFormConv() {
	// This script converts an angle in degrees to a form fed into scr_spriteDir()
	var angle = argument[0];
	var mirror = argument[1];
	var flip = argument[2];

	if mirror = 1 {
		if flip = 1 {
			if abs(angle % 90) = 0 && !abs(angle % 180) = 90 {
				return 0;
			}
			if abs(angle % 90) = 22.5 {
				return 0.5;
			}
			if abs(angle % 90) = 45 {
				return 1;
			}
			if abs(angle % 90) = 67.5 {
				return 1.5;
			}
			if abs(angle % 180) = 90 {
				return 2;
			}
		}
	
		if flip = -1 {
			if abs(angle % 90) = 0 {
				return 6;
			}
			if abs(angle % 90) = 22.5 {
				return 6.5;
			}
			if abs(angle % 90) = 45 {
				return 7;
			}
			if abs(angle % 90) = 67.5 {
				return 7.5;
			}
		}
	}
	if mirror = -1 {
		if flip = 1 {
			if abs(angle % 90) = 0 {
				return 4;
			}
			if abs(angle % 90) = 22.5 {
				return 2.5;
			}
			if abs(angle % 90) = 45 {
				return 3;
			}
			if abs(angle % 90) = 67.5 {
				return 3.5;
			}
		}
	
		if flip = -1 {
			if abs(angle % 180) = 90 {
				return 6;
			}
			if abs(angle % 90) = 22.5 {
				return 4.5;
			}
			if abs(angle % 90) = 45 {
				return 5;
			}
			if abs(angle % 90) = 67.5 {
				return 5.5;
			}
		}
	}



}
