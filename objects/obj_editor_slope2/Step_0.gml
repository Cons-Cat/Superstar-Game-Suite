/// @description Manipulating dimensions
event_inherited();

// Tile array
if resetArray {
	resetArray = false;
	sprMaterial = spr_tls_rectangle_default // Reset material
	
	// Iterate across the width diagonally
	for (i = 0; i <= width + 2; i += 1) {
		// Iterate across the z height
		for (j = (zfloor) + 1; j >= zcieling; j -= 1) {
			tileArrayDrawX[i,j] = 0;
			tileArrayDrawY[i,j] = 120;
			
			// Assign unflipped tiles
			if !flip {
				if !mirror {
					if zfloor > zcieling + 1 {
						if j = zfloor {
							if i = 1 {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 0;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 160;
								tileArrayDrawY[i,j] = 0;
							}
						}
						if j < zfloor && j > zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 20;
								tileArrayDrawY[i,j] = 100;
							}
							if i = 2 {
								if j < zcieling + 1 {
									tileArrayDrawX[i,j] = 60;
									tileArrayDrawY[i,j] = 100;
								} else {
									tileArrayDrawX[i,j] = 100;
									tileArrayDrawY[i,j] = 180;
								}
							}
						}
						if j = zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 140;
								tileArrayDrawY[i,j] = 40;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 40;
							}
						}
					} else if zfloor > zcieling {
						if j = zfloor {
							if i = 1 {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 0;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 160;
								tileArrayDrawY[i,j] = 20;
							}
						}
						if j = zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 140;
								tileArrayDrawY[i,j] = 40;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 40;
							}
						}
					} else {
						if j = zfloor {
							if i = 1 {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 220;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 220;
							}
						}
					}
				} else {
					if zfloor > zcieling + 1 {
						if j = zfloor {
							if i = 1 {
								tileArrayDrawX[i,j] = 140;
								tileArrayDrawY[i,j] = 60;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 60;
							}
						}
						if j < zfloor && j > zcieling {
							if i = 1 {
								if j < zcieling + 2 {
									tileArrayDrawX[i,j] = 160;
									tileArrayDrawY[i,j] = 180;
								} else {
									tileArrayDrawX[i,j] = 20;
									tileArrayDrawY[i,j] = 100;
								}
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 60;
								tileArrayDrawY[i,j] = 100;
							}
						}
						if j = zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 100;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 160;
								tileArrayDrawY[i,j] = 100;
							}
						}
					} else if zfloor > zcieling {
						if j = zfloor {
							if i = 1 {
								tileArrayDrawX[i,j] = 140;
								tileArrayDrawY[i,j] = 80;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 60;
							}
						}
						if j = zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 100;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 160;
								tileArrayDrawY[i,j] = 100;
							}
						}
					} else {
						if j = zfloor {
							if i = 1 {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 200;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 200;
							}
						}
					}
				}
			} else {
				if !mirror {
					// Assign flipped tiles
					if j = zfloor {
						if i = 1 {
							tileArrayDrawX[i,j] = 180;
							tileArrayDrawY[i,j] = 160;
						}
						if i = 2 {
							tileArrayDrawX[i,j] = 200;
							tileArrayDrawY[i,j] = 160;
						}
					}
					if zfloor > zcieling + 1 {
						if j < zfloor && j > zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 20;
								tileArrayDrawY[i,j] = 100;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 60;
								tileArrayDrawY[i,j] = 100;
							}
						}
						if j = zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 20;
								tileArrayDrawY[i,j] = 120;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 60;
								tileArrayDrawY[i,j] = 120;
							}
						}
					} else if zfloor > zcieling {
						if j = zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 20;
								tileArrayDrawY[i,j] = 120;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 60;
								tileArrayDrawY[i,j] = 120;
							}
						}
					} else {
						if j = zfloor {
							if i = 1 {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 160;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 160;
							}
						}
					}
				} else {
					// Assign flipped tiles
					if j = zfloor {
						if i = 1 {
							tileArrayDrawX[i,j] = 180;
							tileArrayDrawY[i,j] = 180;
						}
						if i = 2 {
							tileArrayDrawX[i,j] = 200;
							tileArrayDrawY[i,j] = 180;
						}
					}
					if zfloor > zcieling + 1 {
						if j < zfloor && j > zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 20;
								tileArrayDrawY[i,j] = 100;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 60;
								tileArrayDrawY[i,j] = 100;
							}
						}
						if j = zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 20;
								tileArrayDrawY[i,j] = 120;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 60;
								tileArrayDrawY[i,j] = 120;
							}
						}
					} else if zfloor > zcieling {
						if j = zcieling {
							if i = 1 {
								tileArrayDrawX[i,j] = 20;
								tileArrayDrawY[i,j] = 120;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 60;
								tileArrayDrawY[i,j] = 120;
							}
						}
					} else {
						if j = zfloor {
							if i = 1 {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 180;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 180;
							}
						}
					}
				}
			}
		}
	}
}
