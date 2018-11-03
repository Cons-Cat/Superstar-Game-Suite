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
			
			// Assign unflipped tiles
			if !flip {
				if !mirror {
					if i = 1 {
						if j = 0 {
							// Left edge
							tileArrayDrawX[i-0,j] = 100;
							tileArrayDrawY[i-0,j] = 140;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Left edge
							tileArrayDrawX[i-0,j] = 100;
							tileArrayDrawY[i-0,j] = 120;
						}
						if j > 1 && j < zfloor {
							// Left edge
							tileArrayDrawX[i-0,j] = 20;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Left edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 180;
							} else {
								// Left edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 140;
							}
						}
					}
					
					if i > 1 && i < width {
						if j = 0 {
							// Left edge
							tileArrayDrawX[i-0,j] = 120;
							tileArrayDrawY[i-0,j] = 120;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Left edge
							tileArrayDrawX[i-0,j] = 100;
							tileArrayDrawY[i-0,j] = 160;
						}
						if j > 1 && j < zfloor {
							// Left edge
							tileArrayDrawX[i-0,j] = 40;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Left edge
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 160;
							} else {
								// Left edge
								tileArrayDrawX[i,j] = 120;
								tileArrayDrawY[i,j] = 140;
							}
						}
					}
					
					if i = width {
						if j = 0 {
							// Left edge
							tileArrayDrawX[i-0,j] = 120;
							tileArrayDrawY[i-0,j] = 120;
							
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Left edge
							tileArrayDrawX[i-0,j] = 60;
							tileArrayDrawY[i-0,j] = 100;
							
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j > 1 && j < zfloor {
							// Left edge
							tileArrayDrawX[i-0,j] = 60;
							tileArrayDrawY[i-0,j] = 100;
							
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Left edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 200;
							} else {
								// Left edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 140;
							}
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
					}
				} else {
					if i = 1 {
						if j = 0 {
							// Right edge
							tileArrayDrawX[i-0,j] = 140;
							tileArrayDrawY[i-0,j] = 120;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Right edge
							tileArrayDrawX[i-0,j] = 20;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j > 1 && j < zfloor {
							// Right edge
							tileArrayDrawX[i-0,j] = 20;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Right edge
								tileArrayDrawX[i-0,j] = 140;
								tileArrayDrawY[i-0,j] = 200;
							} else {
								// Right edge
								tileArrayDrawX[i-0,j] = 140;
								tileArrayDrawY[i-0,j] = 140;
							}
						}
					}
			
					if i > 1 && i < width {
						if j = 0 {
							// Right edge
							tileArrayDrawX[i-0,j] = 140;
							tileArrayDrawY[i-0,j] = 120;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Right edge
							tileArrayDrawX[i-0,j] = 160;
							tileArrayDrawY[i-0,j] = 160;
						}
						if j > 1 && j < zfloor {
							// Right edge
							tileArrayDrawX[i-0,j] = 40;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Right edge
								tileArrayDrawX[i-0,j] = 140;
								tileArrayDrawY[i-0,j] = 160;
							} else {
								// Right edge
								tileArrayDrawX[i-0,j] = 140;
								tileArrayDrawY[i-0,j] = 140;
							}
						}
					}
			
					if i = width {
						if j = 0 {
							// Right edge
							tileArrayDrawX[i-0,j] = 160;
							tileArrayDrawY[i-0,j] = 140;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Right edge
							tileArrayDrawX[i-0,j] = 160;
							tileArrayDrawY[i-0,j] = 120;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j > 1 && j < zfloor {
							// Right edge
							tileArrayDrawX[i-0,j] = 60;
							tileArrayDrawY[i-0,j] = 100;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Right edge
								tileArrayDrawX[i-0,j] = 140;
								tileArrayDrawY[i-0,j] = 180;
							} else {
								// Right edge
								tileArrayDrawX[i-0,j] = 140;
								tileArrayDrawY[i-0,j] = 140;
							}
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
					}
				}
			} else {
				if !mirror {
					// Assign flipped tiles
					if i = 1 {
						if j = 0 {
							// Left edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 120;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j >= 1 && j < zfloor {
							// Left edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Left edge
								tileArrayDrawX[i-0,j] = 140;
								tileArrayDrawY[i-0,j] = 220;
							} else {
								// Left edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 140;
							}
						}
					}
					
					if i > 1 && i < width {
						if j = 0 {
							// Left edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 120;
							
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j >= 1 && j < zfloor {
							// Left edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j = zfloor {
							tileArrayDrawX[i,j] = 140;
							tileArrayDrawY[i,j] = 220;
						}
					}
					
					if i = width {
						if j = 0 {
							// Left edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 120;
						}
						if j > 0 && j < zfloor {
							// Left edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Left edge
								tileArrayDrawX[i-0,j] = 140;
								tileArrayDrawY[i-0,j] = 220;
							} else {
								// Left edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 140;
							}
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
					}
				} else {
					if i = 1 {
						if j = 0 {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 120;
							
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j > 1 && j < zfloor {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Right edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 220;
							} else {
								// Right edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 220;
							}
						}
					}
					
					if i > 1 && i < width {
						if j = 0 {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 120;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j > 1 && j < zfloor {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
						}
						if j = zfloor {
							if zfloor > 0 {
								// Right edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 220;
							} else {
								// Right edge
								tileArrayDrawX[i-0,j] = 120;
								tileArrayDrawY[i-0,j] = 220;
							}
						}
					}
					
					if i = width {
						if j = 0 {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 120;
							
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = 1 {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j > 1 && j < zfloor {
							// Right edge
							tileArrayDrawX[i-0,j] = 80;
							tileArrayDrawY[i-0,j] = 100;
							
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
						if j = zfloor {
							// Right edge
							tileArrayDrawX[i-0,j] = 120;
							tileArrayDrawY[i-0,j] = 220;
					
							// Empty space
							tileArrayDrawX[i+1,j] = 0;
							tileArrayDrawY[i+1,j] = 120;
						}
					}
				}
			}
		}
	}
}
