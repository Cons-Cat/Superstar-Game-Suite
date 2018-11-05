/// @description Manipulating dimensions
event_inherited();

// Tile array
if resetArray {
	resetArray = false;
	sprMaterial = spr_tls_rectangle_default // Reset material
	
	// Iterate across the width diagonally
	for (i = 0; i <= width + 2; i += 1) {
		// Iterate across the z height
		for (j = zfloor + 2; j >= zcieling; j -= 1) {
			tileArrayDrawX[i,j] = 0;
			tileArrayDrawY[i,j] = 120;
			
			// Assign unflipped tiles
			if i = 1 {
				if !flip {
					if !mirror {
						if zfloor > zcieling + 1 {
							if j > zcieling + 1 {
								if j = zfloor + 1 {
									tileArrayDrawX[i,j] = 200;
									tileArrayDrawY[i,j] = 40;
								}
								if j = zfloor {
									tileArrayDrawX[i,j] = 200;
									tileArrayDrawY[i,j] = 60;
								}
								if j < zfloor {
									tileArrayDrawX[i,j] = 80;
									tileArrayDrawY[i,j] = 100;
								}
							} else if j > zcieling {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 0;
							} else {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 20;
							}
						} else if zfloor > zcieling {
							if j = zfloor + 1 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 80;
							}
							if j = zfloor {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 100;
							}
							if j = zcieling {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 20;
							}
						} else {
							if j = zfloor + 1 {
								tileArrayDrawX[i,j] = 160;
								tileArrayDrawY[i,j] = 200;
							}
							if j = zfloor {
								tileArrayDrawX[i,j] = 160;
								tileArrayDrawY[i,j] = 220;
							}
						}
					} else {
						if zfloor > zcieling + 1 {
							if j > zcieling + 1 {
								if j = zfloor + 1 {
									tileArrayDrawX[i,j] = 180;
									tileArrayDrawY[i,j] = 40;
								}
								if j = zfloor {
									tileArrayDrawX[i,j] = 180;
									tileArrayDrawY[i,j] = 60;
								}
								if j < zfloor {
									tileArrayDrawX[i,j] = 80;
									tileArrayDrawY[i,j] = 100;
								}
							} else if j > zcieling {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 0;
							} else {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 20;
							}
						} else if zfloor > zcieling {
							if j = zfloor + 1 {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 80;
							}
							if j = zfloor {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 100;
							}
							if j = zcieling {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 20;
							}
						} else {
							if j = zfloor + 1 {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 200;
							}
							if j = zfloor {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 220;
							}
						}
					}
				} else {
					if !mirror {
						if zfloor > zcieling {
							// Assign flipped tiles
							if j = zfloor + 1 {
									tileArrayDrawX[i,j] = 180;
									tileArrayDrawY[i,j] = 120;
							}
							if j = zfloor {
									tileArrayDrawX[i,j] = 180;
									tileArrayDrawY[i,j] = 140;
							}
							if j < zfloor {
									tileArrayDrawX[i,j] = 80;
									tileArrayDrawY[i,j] = 100;
							}
							if j = zcieling {
									tileArrayDrawX[i,j] = 80;
									tileArrayDrawY[i,j] = 120;
							}
						} else {
							if j = zfloor + 1 {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 120;
							}
							if j = zfloor {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 140;
							}
						}
					} else {
						// Assign flipped tiles
						if zfloor > zcieling {
							if j = zfloor + 1 {
									tileArrayDrawX[i,j] = 200;
									tileArrayDrawY[i,j] = 120;
							}
							if j = zfloor {
									tileArrayDrawX[i,j] = 200;
									tileArrayDrawY[i,j] = 140;
							}
							if j < zfloor {
									tileArrayDrawX[i,j] = 80;
									tileArrayDrawY[i,j] = 100;
							}
							if j = zcieling {
									tileArrayDrawX[i,j] = 80;
									tileArrayDrawY[i,j] = 120;
							}
						} else {
							if j = zfloor + 1 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 120;
							}
							if j = zfloor {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 140;
							}
						}
					}
				}
			}
			dummyTop.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
			dummyTop.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
		
			dummyBot.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
			dummyBot.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
		}
	}
}

if slope3MustUpdate {
	// Pass in updated tiles to dummies
	for (i = 0; i <= width + 2; i += 1) {
		for (j = zfloor + 2; j >= zcieling; j -= 1) {
			dummyTop.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
			dummyTop.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
		
			dummyBot.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
			dummyBot.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
		}
	}
}

if (obj_editor_gui.mode = 2 || obj_editor_gui.mode = 3 || obj_editor_gui.mode = 4) && !flip {
	visible = false;
} else {
	visible = true;
}
