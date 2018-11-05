/// @description Manipulating dimensions
event_inherited();

// Tile array
if resetArray {
	resetArray = false;
	sprMaterial = spr_tls_rectangle_default // Reset material
	
	// Iterate across the width diagonally
	for (i = 0; i < width + 2; i += 1) {
		// Iterate across the z height
		for (j = (zfloor) + 1; j >= zcieling; j -= 1) {
			tileArrayDrawX[i,j] = 0;
			tileArrayDrawY[i,j] = 120;
			
			if i = 1 {
				if !flip {
					if !mirror {
						if zfloor > zcieling {
							if j = zfloor {
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 200;
							}
							if j < zfloor && j > zcieling {
								tileArrayDrawX[i,j] = 80;
								tileArrayDrawY[i,j] = 100;
							}
							if j = zcieling {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 140;
							}
						} else {
							if j = zfloor {
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 140;
							}
						}
					} else {
						if zfloor > zcieling {
							if j = zfloor {
								tileArrayDrawX[i,j] = 140;
								tileArrayDrawY[i,j] = 200;
							}
							if j < zfloor && j > zcieling {
								tileArrayDrawX[i,j] = 80;
								tileArrayDrawY[i,j] = 100;
							}
							if j = zcieling {
								tileArrayDrawX[i,j] = 160;
								tileArrayDrawY[i,j] = 140;
							}
						} else {
							if j = zfloor {
								tileArrayDrawX[i,j] = 140;
								tileArrayDrawY[i,j] = 140;
							}
						}
					}
				} else {
					if !mirror {
						if zfloor > zcieling {
							if j = zfloor {
								tileArrayDrawX[i,j] = 140;
								tileArrayDrawY[i,j] = 220;
							}
							if j < zfloor && j > zcieling {
								tileArrayDrawX[i,j] = 80;
								tileArrayDrawY[i,j] = 100;
							}
							if j = zcieling {
								tileArrayDrawX[i,j] = 80;
								tileArrayDrawY[i,j] = 120;
							}
						} else {
							if j = zfloor {
								tileArrayDrawX[i,j] = 140;
								tileArrayDrawY[i,j] = 220;
							}
						}
					} else {
						if zfloor > zcieling {
							if j = zfloor {
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 220;
							}
							if j < zfloor && j > zcieling {
								tileArrayDrawX[i,j] = 80;
								tileArrayDrawY[i,j] = 100;
							}
							if j = zcieling {
								tileArrayDrawX[i,j] = 80;
								tileArrayDrawY[i,j] = 120;
							}
						} else {
							if j = zfloor {
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 220;
							}
						}
					}
				}
			}
		}
	}
}

if keyboard_check_pressed(ord("S")) {
	show_message(string(depth));
	show_message(string(obj_player_overworld.depth));
}
