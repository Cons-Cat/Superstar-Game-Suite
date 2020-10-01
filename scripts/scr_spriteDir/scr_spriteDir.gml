function scr_spriteDir() {
	var dirIso = argument[0];

	if dirIso = 0 {
		image_xscale = 1;
	
		if moving = false {
			return sprR;
		} else {
			return sprRWalk;
		}
	
		if jumping = true {
			return sprRJ;
		}
	}
	if dirIso = 0.5 {
		image_xscale = 1;
	
		if moving = false {
			return sprURR;
		} else {
			return sprURRWalk;
		}
	
		if jumping = true {
			return sprURJ;
		}
	
		image_xscale = 1;
	}
	if dirIso = 1 {
		image_xscale = 1;
	
		if moving = false {
			return sprUR;
		} else {
			return sprURWalk;
		}
	
		if jumping = true {
			return sprURJ;
		}
	}
	if dirIso = 1.5 {
		image_xscale = 1;
	
		if moving = false {
			return sprUUR;
		} else {
			return sprUURWalk;
		}
	
		if jumping = true {
			return sprURJ;
		}
	}
	if dirIso = 2 {
		image_xscale = 1;
	
		if moving = false {
			return sprU;
		} else {
			return sprUWalk;
		}
	
		if jumping = true {
			return sprUJ;
		}
	}
	if dirIso = 2.5 {
		image_xscale = -1;
	
		if moving = false {
			return sprUUR;
		} else {
			return sprUURWalk;
		}
	
		if jumping = true {
			return sprUURJ;
		}
	}
	if dirIso = 3 {
		image_xscale = -1;
	
		if moving = false {
			return sprUR;
		} else {
			return sprURWalk;
		}
	
		if jumping = true {
			return sprURJ;
		}
	}
	if dirIso = 3.5 {
		image_xscale = -1;
	
		if moving = false {
			return sprURR;
		} else {
			return sprURRWalk;
		}
	
		if jumping = true {
			return sprURJ;
		}
	}
	if dirIso = 4 {
		image_xscale = -1;
	
		if moving = false {
			return sprR;
		} else {
			return sprRWalk;
		}
	
		if jumping = true {
			return sprRJ;
		}
	}
	if dirIso = 4.5 {
		image_xscale = -1;
	
		if moving = false {
			return sprDRR;
		} else {
			return sprDRRWalk;
		}
	
		if jumping = true {
			return sprDRJ;
		}
	}
	if dirIso = 5 {
		image_xscale = -1;
	
		if moving = false {
			return sprDR;
		} else {
			return sprDRWalk;
		}
	
		if jumping = true {
			return sprDRJ;
		}
	}
	if dirIso = 5.5 {
		image_xscale = -1;
	
		if moving = false {
			return sprDDR;
		} else {
			return sprDDRWalk;
		}
	
		if jumping = true {
			return sprDRJ;
		}
	}
	if dirIso = 6 {
		image_xscale = 1;
	
		if moving = false {
			return sprD;
		} else {
			return sprDWalk;
		}
	
		if jumping = true {
			return sprDJ;
		}
	}
	if dirIso = 6.5 {
		image_xscale = 1;
	
		if moving = false {
			return sprDDR;
		} else {
			return sprDDRWalk;
		}
	
		if jumping = true {
			return sprDRJ;
		}
	}
	if dirIso = 7 {
		image_xscale = 1;
	
		if moving = false {
			return sprDR;
		} else {
			return sprDRWalk;
		}
	
		if jumping = true {
			return sprDRJ;
		}
	}
	if dirIso = 7.5 {
		image_xscale = 1;
	
		if moving = false {
			return sprDRR;
		} else {
			return sprDRRWalk;
		}
	
		if jumping = true {
			return sprDRJ;
		}
	}

	// Return current sprite last
	return spr;



}
