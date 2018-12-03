/// @description Manipulating dimensions
event_inherited();

// Tile array
if resetArray {
	resetArray = false;
	sprMaterial = spr_tls_staircase_default // Reset material
	
	if staircaseType = 0 {
		widthIterateCollisionOff = 1;
		
		#region
		zIterate = 2;
		staircaseSlope = 2;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			widthIterate = 3;
			heightIterate = width + 1;
		}
		if staircaseRotation = 1 {
			widthIterate = width + 2;
			heightIterate = width + 1;
		}
		if staircaseRotation = 4 {
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
					
			widthIterate = width + 2;
			heightIterate = width + 2;
			
			xOrigin = x + width*10 + 10;
			yOrigin = y - width*10 + 30;
		}
		#endregion
	}
	if staircaseType = 1 {
		widthIterateCollisionOff = 2;
		
		#region
		zIterate = 2;
		staircaseSlope = 4;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			widthIterate = 4;
			heightIterate = width + 1;
		}
		if staircaseRotation = 1 {
			widthIterate = width + 2;
			heightIterate = 1;
		}
		if staircaseRotation = 3 || staircaseRotation = 9 {
			widthIterate = round(width/2) + 4;
			heightIterate = width + 2;
		}
		if staircaseRotation = 4 || staircaseRotation = 8 {
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
			
			widthIterate = width + 4;
			heightIterate = width + 3;
		}
		if staircaseRotation = 5 || staircaseRotation = 7 {
			widthIterate = width + 2;
			heightIterate = floor(width/2) + 3;
		}
		if staircaseRotation = 6 {
			widthIterate = width + 2;
			heightIterate = 3;
		}
		#endregion
	}
	if staircaseType = 2 {
		widthIterateCollisionOff = 0;
		
		#region
		zIterate = 3;
		staircaseSlope = 0.5;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			widthIterate = 3;
			heightIterate = width + 2;
		}
		if staircaseRotation = 1 || staircaseRotation = 6 {
			widthIterate = width + 2;
			heightIterate = 2;
		}
		if staircaseRotation = 3 || staircaseRotation = 9 {
			widthIterate = round(width/2) + 2;
			heightIterate = floor(width/2) * 2 + 1;
		}
		if staircaseRotation = 4 {
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
		}
		#endregion
	}
	
	// Iterate across the width diagonally
	for (i = 0; i < widthIterate; i += 1) {
		// Iterate across the z height
		for (j = heightIterate; j >= zfloor; j -= 1) {
			tileArrayDrawX[i,j] = 0;
			tileArrayDrawY[i,j] = 40;
			
			// 1x1x1 staircase
			if staircaseType = 0 {
				#region
				if staircaseRotation = 0 {
					#region
					if i = 1 {
						if j = width {
							tileArrayDrawX[i,j] = 680;
							tileArrayDrawY[i,j] = 0;
						}
						if j < width {
							tileArrayDrawX[i,j] = 680;
							tileArrayDrawY[i,j] = 20;
						}
					}
					#endregion
				}
				if staircaseRotation = 1 {
					#region
					if i > 0 && i <= width {
						if j = 0 {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 0;
						}
					}
					#endregion
				}
				if staircaseRotation = 2 {
					#region
					if i = 1 {
						if j = width {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 0;
						}
						if j < width {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 20;
						}
					}
					#endregion
				}
				if staircaseRotation = 4 {
					#region
					if i = 1 {
						if j = 0 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 320;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 300;
						}
						if j = 2 {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 260;
						}
					}
					if i > 1 && i < width {
						if j = i - 2 {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 320;
						}
						if j = i - 1 {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 300;
						}
						if j = i {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 280;
						}
						if j = i + 1 {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 260;
						}
					}
					if i = width {
						if j = i - 2 {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 300;
						}
						if j = i - 1 {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 280;
						}
						if j = i {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 260;
						}
						if j = i + 1 {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 240;
						}
					}
					#endregion
				}
				if staircaseRotation = 6 {
					#region
					if i = 1 {
						if j = 0 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 20;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 0;
						}
					}
					#endregion
				}
				#endregion
			}
			// 1x2x1 staircase
			if staircaseType = 1 {
				#region
				if staircaseRotation = 0 {
					#region
					if i = 1 {
						if j < width {
							tileArrayDrawX[i,j] = 660;
							tileArrayDrawY[i,j] = 80;
						}
						if j = width {
							tileArrayDrawX[i,j] = 660;
							tileArrayDrawY[i,j] = 60;
						}
					}
					if i = 2 {
						if j < width {
							tileArrayDrawX[i,j] = 680;
							tileArrayDrawY[i,j] = 80;
						}
						if j = width {
							tileArrayDrawX[i,j] = 680;
							tileArrayDrawY[i,j] = 60;
						}
					}
					#endregion
				}
				if staircaseRotation = 1 {
					#region
					if i > 0 && i < width + 1 && j = 0 {
						tileArrayDrawX[i,j] = 40;
						tileArrayDrawY[i,j] = 0;
					}
					#endregion
				}
				if staircaseRotation = 2 {
					#region
					if i = 1 {
						if j < width {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 80;
						}
						if j = width {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 60;
						}
					}
					if i = 2 {
						if j < width {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 80;
						}
						if j = width {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 60;
						}
					}
					#endregion
				}
				if staircaseRotation = 3 {
					#region
					if i = 1 {
						if j = 3 {
							tileArrayDrawX[i,j] = 280;
							tileArrayDrawY[i,j] = 40;
						}
						if j = 2 {
							tileArrayDrawX[i,j] = 280;
							tileArrayDrawY[i,j] = 60;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 280;
							tileArrayDrawY[i,j] = 80;
						}
					}
					if i = 2 {
						if j = 1 {
							tileArrayDrawX[i,j] = 300;
							tileArrayDrawY[i,j] = 80;
						}
						if j = 0 {
							tileArrayDrawX[i,j] = 300;
							tileArrayDrawY[i,j] = 100;
						}
					}
					if i > 1 && i < width {
						if i = 2 && j > 1 {
							if j = (i - 2)*2 + 5 {
								tileArrayDrawX[i,j] = 280;
								tileArrayDrawY[i,j] = 40;
							}
							if j = (i - 2)*2 + 4 {
								tileArrayDrawX[i,j] = 280;
								tileArrayDrawY[i,j] = 60;
							}
							if j = (i - 2)*2 + 3 {
								tileArrayDrawX[i,j] = 300;
								tileArrayDrawY[i,j] = 40;
							}
						}
						if i > 1 && j > 0 {
							if j = (i - 2)*2 + 5 && j < ceil(width) {
								tileArrayDrawX[i,j] = 280;
								tileArrayDrawY[i,j] = 40;
							}
							if j = (i - 2)*2 + 4 && j < ceil(width) + 1 {
								tileArrayDrawX[i,j] = 280;
								tileArrayDrawY[i,j] = 60;
							}
							if j = (i - 2)*2 + 3 && j < ceil(width) {
								tileArrayDrawX[i,j] = 300;
								tileArrayDrawY[i,j] = 40;
							}
							if j = (i - 2)*2 + 2 && j < ceil(width) {
								tileArrayDrawX[i,j] = 300;
								tileArrayDrawY[i,j] = 60;
							}
							if j = (i - 2)*2 + 1 && j > 1 && j < ceil(width) {
								tileArrayDrawX[i,j] = 320;
								tileArrayDrawY[i,j] = 40;
							}
							if j = (i - 2)*2 && j < ceil(width) {
								tileArrayDrawX[i,j] = 320;
								tileArrayDrawY[i,j] = 60;
							}
						}
						if i > 2 {
							if j = (i - 2)*2 - 1 {
								tileArrayDrawX[i,j] = 320;
								tileArrayDrawY[i,j] = 80;
							}
							if j = (i - 2)*2 - 2 {
								tileArrayDrawX[i,j] = 340;
								tileArrayDrawY[i,j] = 60;
							}
						}
					}
					if i = (width/2) {
						if j = round(width) + 1 {
							tileArrayDrawX[i,j] = 300;
							tileArrayDrawY[i,j] = 0;
						}
					}
					if i = round(width/2) + 1 {
						if j = round(width) + 1 {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 0;
						}
						if j = round(width) {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 20;
						}
					}
					if i = round(width/2) + 2 {
						if j = round(width) {
							tileArrayDrawX[i,j] = 340;
							tileArrayDrawY[i,j] = 20;
						}
						if j = round(width) - 1 {
							tileArrayDrawX[i,j] = 340;
							tileArrayDrawY[i,j] = 40;
						}
						if j = round(width) - 2 {
							tileArrayDrawX[i,j] = 340;
							tileArrayDrawY[i,j] = 60;
						}
					}
					#endregion
				}
				if staircaseRotation = 4 {
					#region
					if i < width + 3 {
						if i = 1 {
							if j = 1 {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 40;
								tileArrayDrawX[i,j+1] = 80;
								tileArrayDrawY[i,j+1] = 60;
								tileArrayDrawX[i,j+2] = 80;
								tileArrayDrawY[i,j+2] = 40;
							}
						}
						if i = 2 {
							if j = 0 {
								tileArrayDrawX[i,j] = 100;
								tileArrayDrawY[i,j] = 100;
								tileArrayDrawX[i,j+1] = 100;
								tileArrayDrawY[i,j+1] = 80;
								tileArrayDrawX[i,j+2] = 100;
								tileArrayDrawY[i,j+2] = 60;
								tileArrayDrawX[i,j+3] = 120;
								tileArrayDrawY[i,j+3] = 60;
								tileArrayDrawX[i,j+4] = 80;
								tileArrayDrawY[i,j+4] = 40;
							}
						}
						if i = j + 3 {
							if j < i - 2 {
								if i < (width - (j - width - 1)) + 1 {
									tileArrayDrawX[i,j] = 120;
									tileArrayDrawY[i,j] = 100;
								}
								if i < (width - (j - width)) + 1 {
									tileArrayDrawX[i,j+1] = 120;
									tileArrayDrawY[i,j+1] = 80;
								}
								if i < (width - (j - width + 1)) + 1 {
									tileArrayDrawX[i,j+2] = 120;
									tileArrayDrawY[i,j+2] = 60;
								}
								if i < (width - (j - width + 2)) + 1 {
									tileArrayDrawX[i,j+3] = 100;
									tileArrayDrawY[i,j+3] = 60;
								}
								if i < (width - (j - width + 3)) + 1 {
									tileArrayDrawX[i,j+4] = 120;
									tileArrayDrawY[i,j+4] = 60;
								}
								if i < (width - (j - width + 4)) + 1 {
									tileArrayDrawX[i,j+5] = 80;
									tileArrayDrawY[i,j+5] = 40;
								}
							}
						}
					}
					if i = width - (j - width - 1) + 2 && i < width + 3 {
						if i = width + 1 {
							tileArrayDrawX[i-1,j] = 100;
							tileArrayDrawY[i-1,j] = 20;
							tileArrayDrawX[i,j] = 120;
							tileArrayDrawY[i,j] = 20;
						}
					}
					if i = width - (j - width) + 2 && i < width + 3 {
						if i = width + 1 {
							tileArrayDrawX[i,j] = 120;
							tileArrayDrawY[i,j] = 40;
						}
					}
					if i = width - (j - width + 2) + 3 && i < width + 3 {
						if i = width + 2 {
							tileArrayDrawX[i,j+1] = 140;
							tileArrayDrawY[i,j+1] = 60;
							tileArrayDrawX[i,j+2] = 140;
							tileArrayDrawY[i,j+2] = 40;
						}
					}
					#endregion
				}
				if staircaseRotation = 5 {
					#region
					if i = 1 {
						if j = 0 {
							tileArrayDrawX[i,j] = 180;
							tileArrayDrawY[i,j] = 100;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 180;
							tileArrayDrawY[i,j] = 80;
						}
						if j = 2 {
							tileArrayDrawX[i,j] = 180;
							tileArrayDrawY[i,j] = 60;
						}
						if j = 3 {
							tileArrayDrawX[i,j] = 180;
							tileArrayDrawY[i,j] = 40;
						}
					}
					if i > 1 && i < width {
						if i % 2 = 0 {
							if j = i div 2 - 1 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 100;
							}
							if j = i div 2 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 80;
							}
							if j = i div 2 + 1 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 60;
							}
							if j = i div 2 + 2 {
								tileArrayDrawX[i,j] = 200;
								tileArrayDrawY[i,j] = 40;
							}
						} else {
							if j = i div 2 - 1 {
								tileArrayDrawX[i,j] = 220;
								tileArrayDrawY[i,j] = 100;
							}
							if j = i div 2 {
								tileArrayDrawX[i,j] = 240;
								tileArrayDrawY[i,j] = 40;
							}
							if j = i div 2 + 1 {
								tileArrayDrawX[i,j] = 240;
								tileArrayDrawY[i,j] = 20;
							}
							if j = i div 2 + 2 {
								tileArrayDrawX[i,j] = 240;
								tileArrayDrawY[i,j] = 0;
							}
							if j = i div 2 + 3 {
								tileArrayDrawX[i,j] = 180;
								tileArrayDrawY[i,j] = 40;
							}
						}
					}
					if i = width {
						if j = i div 2 - 1 {
							tileArrayDrawX[i,j] = 220;
							tileArrayDrawY[i,j] = 100;
						}
						if j = i div 2 {
							tileArrayDrawX[i,j] = 220;
							tileArrayDrawY[i,j] = 80;
						}
						if j = i div 2 + 1 {
							tileArrayDrawX[i,j] = 220;
							tileArrayDrawY[i,j] = 60;
						}
						if j = i div 2 + 2 {
							tileArrayDrawX[i,j] = 220;
							tileArrayDrawY[i,j] = 40;
						}
					}
					#endregion
				}
				if staircaseRotation = 6 {
					#region
					if i > 0 && i <= width {
						if j = 2 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 60;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 80;
						}
						if j = 0 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 100;
						}
					}
					#endregion
				}
				if staircaseRotation = 7 {
					#region
					if i = 1 {
						if j = floor(width/2) - 1 {
							tileArrayDrawX[i,j] = 480;
							tileArrayDrawY[i,j] = 100;
						}
						if j = floor(width/2) {
							tileArrayDrawX[i,j] = 480;
							tileArrayDrawY[i,j] = 80;
						}
						if j = floor(width/2) + 1 {
							tileArrayDrawX[i,j] = 480;
							tileArrayDrawY[i,j] = 60;
						}
						if j = floor(width/2) + 2 {
							tileArrayDrawX[i,j] = 480;
							tileArrayDrawY[i,j] = 40;
						}
					}
					if i > 1 && i < width {
						if i % 2 = 0 {
							if j = floor(width/2) - ceil(i/2) {
								tileArrayDrawX[i,j] = 500;
								tileArrayDrawY[i,j] = 100;
							}
							if j = floor(width/2) - ceil(i/2) + 1 {
								tileArrayDrawX[i,j] = 500;
								tileArrayDrawY[i,j] = 80;
							}
							if j = floor(width/2) - ceil(i/2) + 2 {
								tileArrayDrawX[i,j] = 500;
								tileArrayDrawY[i,j] = 60;
							}
							if j = floor(width/2) - ceil(i/2) + 3 {
								tileArrayDrawX[i,j] = 500;
								tileArrayDrawY[i,j] = 40;
							}
						} else {
							if j = floor(width/2) - ceil(i/2) {
								tileArrayDrawX[i,j] = 480;
								tileArrayDrawY[i,j] = 100;
							}
							if j = floor(width/2) - ceil(i/2) + 1 {
								tileArrayDrawX[i,j] = 460;
								tileArrayDrawY[i,j] = 40;
							}
							if j = floor(width/2) - ceil(i/2) + 2 {
								tileArrayDrawX[i,j] = 460;
								tileArrayDrawY[i,j] = 20;
							}
							if j = floor(width/2) - ceil(i/2) + 3 {
								tileArrayDrawX[i,j] = 460;
								tileArrayDrawY[i,j] = 0;
							}
							if j = floor(width/2) - ceil(i/2) + 4 {
								tileArrayDrawX[i,j] = 520;
								tileArrayDrawY[i,j] = 40;
							}
						}
					}
					if i = width {
						if j = 0 {
							tileArrayDrawX[i,j] = 520;
							tileArrayDrawY[i,j] = 100;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 520;
							tileArrayDrawY[i,j] = 80;
						}
						if j = 2 {
							tileArrayDrawX[i,j] = 520;
							tileArrayDrawY[i,j] = 60;
						}
						if j = 3 {
							tileArrayDrawX[i,j] = 520;
							tileArrayDrawY[i,j] = 40;
						}
					}
					#endregion
				}
				if staircaseRotation = 8 {
					#region
					if j = i + width - 2 {
						if i = 1 {
							tileArrayDrawX[i,j] = 560;
							tileArrayDrawY[i,j] = 80;
							tileArrayDrawX[i,j+1] = 560;
							tileArrayDrawY[i,j+1] = 60;
							tileArrayDrawX[i,j+2] = 560;
							tileArrayDrawY[i,j+2] = 40;
						}
						if i = 2 {
							tileArrayDrawX[i,j+1] = 580;
							tileArrayDrawY[i,j+1] = 40;
							tileArrayDrawX[i,j+2] = 580;
							tileArrayDrawY[i,j+2] = 20;
						}
					}
					if j = width - i {
						if i > 1 {
							if i % 2 = 0 {
								tileArrayDrawX[i,j] = 580;
								tileArrayDrawY[i,j] = 100;
								tileArrayDrawX[i,j+1] = 580;
								tileArrayDrawY[i,j+1] = 80;
								tileArrayDrawX[i,j+2] = 580;
								tileArrayDrawY[i,j+2] = 60;
								
								if i > 2 {
									tileArrayDrawX[i,j+3] = 600;
									tileArrayDrawY[i,j+3] = 60;
								}
								if i > 3 {
									tileArrayDrawX[i,j+4] = 580;
									tileArrayDrawY[i,j+4] = 60;
									tileArrayDrawX[i,j+5] = 620;
									tileArrayDrawY[i,j+5] = 40;
								}
							} else {
								tileArrayDrawX[i,j] = 560;
								tileArrayDrawY[i,j] = 80;
								tileArrayDrawX[i,j+1] = 580;
								tileArrayDrawY[i,j+1] = 80;
								tileArrayDrawX[i,j+2] = 580;
								tileArrayDrawY[i,j+2] = 60;
								tileArrayDrawX[i,j+3] = 600;
								tileArrayDrawY[i,j+3] = 60;
								tileArrayDrawX[i,j+4] = 580;
								tileArrayDrawY[i,j+4] = 60;
								tileArrayDrawX[i,j+5] = 600;
								tileArrayDrawY[i,j+5] = 20;
							}
						}
					}
					if i > width && i < width + 3 {
						if j = i - width - 1 {
							if j = 0 {
								tileArrayDrawX[i,j] = 600;
								tileArrayDrawY[i,j] = 100;
								tileArrayDrawX[i,j+1] = 600;
								tileArrayDrawY[i,j+1] = 80;
								tileArrayDrawX[i,j+2] = 600;
								tileArrayDrawY[i,j+2] = 60;
								tileArrayDrawX[i,j+3] = 580;
								tileArrayDrawY[i,j+3] = 60;
								tileArrayDrawX[i,j+4] = 620;
								tileArrayDrawY[i,j+4] = 40;
							}
							if j = 1 {
								tileArrayDrawX[i,j] = 600;
								tileArrayDrawY[i,j] = 40;
								tileArrayDrawX[i,j+1] = 620;
								tileArrayDrawY[i,j+1] = 60
								tileArrayDrawX[i,j+2] = 620;
								tileArrayDrawY[i,j+2] = 40;
							}
						}
					}
				}
				if staircaseRotation = 9 {
					if i > 0 && (i < round(width/2) + 1 || j > 1) {
						if j = round(width) - i*2 {
							tileArrayDrawX[i,j] = 360;
							tileArrayDrawY[i,j] = 60;
						}
						if j = round(width) - i*2 + 1 {
							tileArrayDrawX[i,j] = 380;
							tileArrayDrawY[i,j] = 80;
						}
						if j = i + width - 1 {
							if i = 1 {
								tileArrayDrawX[i,j] = 360;
								tileArrayDrawY[i,j] = 20;
							}
							if i = 2 {
								tileArrayDrawX[i,j] = 380;
								tileArrayDrawY[i,j] = 0;
							}
						}
						if j = i + width - 2 {
							if i = 2 {
								tileArrayDrawX[i,j] = 380;
								tileArrayDrawY[i,j] = 20;
							}
						}
						if i > 1 {
							if j = round(width) - i*2 + 2 {
								tileArrayDrawX[i,j] = 380;
								tileArrayDrawY[i,j] = 60;
							}
							if j = round(width) - i*2 + 3 {
								tileArrayDrawX[i,j] = 380;
								tileArrayDrawY[i,j] = 40;
							}
							
							if i > 2 {
								if j = round(width) - i*2 + 4 {
									tileArrayDrawX[i,j] = 400;
									tileArrayDrawY[i,j] = 60;
								}
								if j = round(width) - i*2 + 5 {
									tileArrayDrawX[i,j] = 400;
									tileArrayDrawY[i,j] = 40;
								}
								if j = round(width) - i*2 + 6 {
									tileArrayDrawX[i,j] = 420;
									tileArrayDrawY[i,j] = 60;
								}
								if j = round(width) - i*2 + 7 {
									if i = 3 {
										tileArrayDrawX[i,j] = 400;
										tileArrayDrawY[i,j] = 0;
									} else {
										tileArrayDrawX[i,j] = 420;
										tileArrayDrawY[i,j] = 40;
									}
								}
							}
						}
					}
					if i = round(width/2) + 1 {
						if j = 0 {
							tileArrayDrawX[i,j] = 400;
							tileArrayDrawY[i,j] = 100;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 400;
							tileArrayDrawY[i,j] = 80;
						}
					}
					if i = round(width/2) + 2 {
						if j = 1 {
							tileArrayDrawX[i,j] = 420;
							tileArrayDrawY[i,j] = 80;
						}
					}
					#endregion
				}
				#endregion
			}
			//1x1x2 staircase
			if staircaseType = 2 {
				#region
				if staircaseRotation = 0 {
					#region
					if i = 1 {
						if j = width + 1 {
							tileArrayDrawX[i,j] = 680;
							tileArrayDrawY[i,j] = 120;
						}
						if j = width {
							tileArrayDrawX[i,j] = 680;
							tileArrayDrawY[i,j] = 140;
						}
						if j < width {
							tileArrayDrawX[i,j] = 680;
							tileArrayDrawY[i,j] = 160;
						}
					}
					#endregion
				}
				if staircaseRotation = 1 {
					#region
					if i > 0 && i <= width {
						if j = 0 {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 20;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 40;
							tileArrayDrawY[i,j] = 0;
						}
					}
					#endregion
				}
				if staircaseRotation = 2 {
					#region
					if i = 1 {
						if j = width + 1 {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 120;
						}
						if j = width {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 140;
						}
						if j < width {
							tileArrayDrawX[i,j] = 20;
							tileArrayDrawY[i,j] = 160;
						}
					}
					#endregion
				}
				if staircaseRotation = 3 {
					#region
					if i > 0 && i < round(width/2) {
						if j = (i - 2)*2 + 0 {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 220;
						}
						if j = (i - 2)*2 + 1 {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 200;
						}
						if j = (i - 2)*2 + 2 {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 180;
						}
						if j = (i - 2)*2 + 3 {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 160;
						}
						if j = (i - 2)*2 + 4 {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 140;
						}
						if j = (i - 2)*2 + 5 {
							tileArrayDrawX[i,j] = 300;
							tileArrayDrawY[i,j] = 160;
						}
						if j = (i - 2)*2 + 6 {
							if i < round(width/2) - 1 {
								tileArrayDrawX[i,j] = 300;
								tileArrayDrawY[i,j] = 140;
							} else {
								tileArrayDrawX[i,j] = 320;
								tileArrayDrawY[i,j] = 100;
							}
						}
					}
					if i = 1 {
						if j = 0 {
							tileArrayDrawX[i,j] = 300;
							tileArrayDrawY[i,j] = 220;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 300;
							tileArrayDrawY[i,j] = 200;
						}
						if j = 2 {
							tileArrayDrawX[i,j] = 300;
							tileArrayDrawY[i,j] = 180;
						}
					}
					if i = round(width/2) {
						if j = (i - 2)*2 + 0 {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 220;
						}
						if j = (i - 2)*2 + 1 {
							tileArrayDrawX[i,j] = 320;
							tileArrayDrawY[i,j] = 200;
						}
						if j = (i - 2)*2 + 2 {
							tileArrayDrawX[i,j] = 340;
							tileArrayDrawY[i,j] = 140;
						}
						if j = (i - 2)*2 + 3 {
							tileArrayDrawX[i,j] = 340;
							tileArrayDrawY[i,j] = 120;
						}
						if j = (i - 2)*2 + 4 {
							tileArrayDrawX[i,j] = 340;
							tileArrayDrawY[i,j] = 100;
						}
					}
					#endregion
				}
				if staircaseRotation = 6 {
					#region
					if i > 0 && i <= width {
						if j = 0 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 160;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 140;
						}
						if j = 2 {
							tileArrayDrawX[i,j] = 0;
							tileArrayDrawY[i,j] = 120;
						}
					}
					#endregion
				}
				#endregion
			}
			/*
			dummyTop.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
			dummyTop.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
			
			dummyBot.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
			dummyBot.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
			*/
		}
	}
}

/*if slope3MustUpdate {
	// Pass in updated tiles to dummies
	for (i = 0; i <= width + 2; i += 1) {
		for (j = zfloor + 2; j >= zcieling; j -= 1) {
			dummyTop.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
			dummyTop.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
		
			dummyBot.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
			dummyBot.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
		}
	}
}*/

zcieling = zfloor;
