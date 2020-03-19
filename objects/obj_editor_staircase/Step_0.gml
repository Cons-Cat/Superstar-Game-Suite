/// @description Manipulating dimensions
event_inherited();

if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 || obj_editor_gui.mode = 3 {
	modeForSelectVal = obj_editor_gui.mode;
}

// Dimensional manipulation
if spawnButtons {
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_left) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_right) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z2) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_info_editor) {
		trg = other.id;
		str2 = "flip";
	}
}

// Initialize and update dimensional variables
if obj_editor_gui.mode != 2 {
	// See obj_editor_gui (Step) for comments on what these variables do
	if staircaseType = 0 {
		widthIterateCollisionOff = 1;
		
		#region
		zIterate = 2;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			#region
			
			widthIterate = 3;
			heightIterate = width + 1;
			
			#endregion
		}
		if staircaseRotation = 1 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = width + 2;
			heightIterate = width + 1;
			
			staircaseRun = 0;
			staircaseRise = -1;
			
			#endregion
		}
		if staircaseRotation = 4 {
			#region
			
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
			sprCreate[4] = -1;
					
			widthIterate = width + 2;
			heightIterate = width + 2;
			
			// Origin varies for every staircase variant
			slopeOriginOffsetX = x;
			slopeOriginOffsetY = y;
			
			staircaseRun = 0.5;
			staircaseRise = 0.5;
			
			rayXComponent = 21;
			rayYComponent = 21;
			
			#endregion
		}
		#endregion
	}
	if staircaseType = 1 {
		widthIterateCollisionOff = 2;
		
		#region
		zIterate = 2;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = 4;
			heightIterate = width + 1;
			
			if staircaseRotation = 2 {
				staircaseRun = 0.5;
				collisionMaskRun = 1;
				rayXComponent = 45;
				slopeOriginOffsetX = x - 2;
			} else {
				staircaseRun = -0.5;
				collisionMaskRun = -1;
				rayXComponent = -45;
				slopeOriginOffsetX = x + 40;
			}
			
			staircaseRise = 0;
			collisionMaskRise = 1;
			rayYComponent = 0;
			slopeOriginOffsetY = y+20;
			widthIterateCollisionOff = 1;
			
			#endregion
		}
		if staircaseRotation = 1 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = width + 2;
			heightIterate = 2;
			
			staircaseRun = 0;
			staircaseRise = -0.5;
			
			collisionMaskRun = 1;
			collisionMaskRise = 0;
			
			// Origin varies for every staircase variant
			slopeOriginOffsetX = x;
			slopeOriginOffsetY = y+20;
			
			rayXComponent = 0;
			rayYComponent = -45;
			
			widthIterateCollisionOff = 2;
			
			#endregion
		}
		if staircaseRotation = 3 || staircaseRotation = 9 {
			#region
			
			widthIterate = round(width/2) + 4;
			heightIterate = width + 2;
			
			if staircaseRotation = 3 {
				sprCreate[0] = spr_slopeL_05x_bot;
				sprCreate[1] = spr_slopeR_2x_bot;
				sprCreate[2] = spr_slopeR_05x;
				sprCreate[3] = spr_slopeL_2x;
				sprCreate[4] = spr_solid;
				staircaseRun = 0.4;
				collisionMaskRun = 1;
				rayXComponent = 45;
				slopeOriginOffsetX = x;
			} else {
				sprCreate[0] = spr_slopeL_2x_bot;
				sprCreate[1] = spr_slopeR_05x_bot;
				sprCreate[2] = spr_slopeR_2x;
				sprCreate[3] = spr_slopeL_05x;
				sprCreate[4] = spr_solid;
				staircaseRun = -0.4;
				collisionMaskRun = -1;
				rayXComponent = -45;
				slopeOriginOffsetX = x + width * 10 + 40;
			}
			
			staircaseRise = 0.2;
			collisionMaskRise = 2;
			rayYComponent = 25;
			slopeOriginOffsetY = y;
			
			#endregion
		}
		if staircaseRotation = 4 || staircaseRotation = 8 {
			#region
			
			widthIterate = width + 4;
			heightIterate = width + 3;
			
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
			sprCreate[4] = -1;
			
			if staircaseRotation = 4 {
				staircaseRun = 0.25;
				collisionMaskRun = 1;
				slopeOriginOffsetX = x;
				rayXComponent = 42;
			} else {
				staircaseRun = -0.25;
				collisionMaskRun = -1;
				slopeOriginOffsetX = x + width * 20 + 40;
				rayXComponent = -42;
			}
			
			staircaseRise = 0.25;
			collisionMaskRise = 1;
			slopeOriginOffsetY = y - 20;
			rayYComponent = 42;
			
			#endregion
		}
		if staircaseRotation = 5 || staircaseRotation = 7 {
			#region
			
			sprCreate[4] = spr_solid;
			
			widthIterate = width + 3;
			heightIterate = floor(width/2) + 3;
			
			if staircaseRotation = 5 {
				sprCreate[0] = spr_slopeL_2x_bot;
				sprCreate[1] = spr_slopeR_05x_bot;
				sprCreate[2] = spr_slopeR_2x;
				sprCreate[3] = spr_slopeL_05x;
				sprCreate[4] = spr_solid;
				staircaseRun = 0.2;
				rayXComponent = 25;
				collisionMaskRun = 2;
				slopeOriginOffsetX = x;
			} else {
				sprCreate[0] = spr_slopeL_05x_bot;
				sprCreate[1] = spr_slopeR_2x_bot;
				sprCreate[2] = spr_slopeR_05x;
				sprCreate[3] = spr_slopeL_2x;
				staircaseRun = -0.2;
				rayXComponent = -25;
				collisionMaskRun = -2;
				slopeOriginOffsetX = x + width * 20 + 20;
			}
			
			staircaseRise = 0.4;
			rayYComponent = 45;
			collisionMaskRise = 1;
			slopeOriginOffsetY = y - 20;
			
			#endregion
		}
		if staircaseRotation = 6 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			
			widthIterate = width + 2;
			heightIterate = 3;
			
			staircaseRun = 0;
			staircaseRise = 0.5;
			
			collisionMaskRun = 1;
			collisionMaskRise = 0;
			
			// Origin varies for every staircase variant
			slopeOriginOffsetX = x;
			slopeOriginOffsetY = y - 26;
			
			rayXComponent = 0;
			rayYComponent = 45;
			
			widthIterateCollisionOff = 2;
			
			#endregion
		}
		
		#endregion
	}
	if staircaseType = 2 {
		widthIterateCollisionOff = 1;
		
		#region
		zIterate = 3;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			#region
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = 3;
			heightIterate = width + 2;
			
			if staircaseRotation = 0 {
				// Cast westward
				staircaseRun = -2;
				collisionMaskRun = 0;
				rayXComponent = -25;
				slopeOriginOffsetX = x+22; // IDK it just works .. largely
			} else {
				// Cast eastward
				staircaseRun = 2;
				collisionMaskRun = 0;
				rayXComponent = 22;
				slopeOriginOffsetX = x-1;
			}
			
			staircaseRise = 0;
			collisionMaskRise = 1;
			slopeOriginOffsetY = y+20;
			rayYComponent = 0;
			widthIterateCollisionOff = 1;
			
			#endregion
		}
		if staircaseRotation = 1 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = width + 2;
			heightIterate = 2;
			
			staircaseRun = 0;
			staircaseRise = -2;
			
			collisionMaskRun = 1;
			collisionMaskRise = 0;
			
			// Origin varies for every staircase variant
			slopeOriginOffsetX = x;
			slopeOriginOffsetY = y+20;
			
			rayXComponent = 0;
			rayYComponent = -25;
			
			widthIterateCollisionOff = 2;
			
			#endregion
		}
		if staircaseRotation = 3 || staircaseRotation = 9 {
			#region
			
			widthIterate = round(width/2) + 2;
			heightIterate = floor(width/2) * 2 + 1;
			
			if staircaseRotation = 3 {
				sprCreate[0] = spr_slopeL_05x_bot;
				sprCreate[1] = spr_slopeR_2x_bot;
				sprCreate[2] = spr_slopeR_05x;
				sprCreate[3] = spr_slopeL_2x;
				sprCreate[4] = spr_solid;
				staircaseRun = 0.8;
				collisionMaskRun = 1;
				rayXComponent = 45;
				slopeOriginOffsetX = x;
			} else {
				sprCreate[0] = spr_slopeL_2x_bot;
				sprCreate[1] = spr_slopeR_05x_bot;
				sprCreate[2] = spr_slopeR_2x;
				sprCreate[3] = spr_slopeL_05x;
				sprCreate[4] = spr_solid;
				staircaseRun = -0.8;
				collisionMaskRun = -1;
				rayXComponent = -45;
				slopeOriginOffsetX = x + width * 10 + 40;
			}
			
			staircaseRise = 0.4;
			collisionMaskRise = 2;
			rayYComponent = 25;
			slopeOriginOffsetY = y;
			
			#endregion
		}
		if staircaseRotation = 4 {
			#region
			
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
			sprCreate[4] = -1;
					
			widthIterate = width + 2;
			heightIterate = width + 2;
			
			staircaseRun = 1;
			staircaseRise = 1;
			
			#endregion
		}
		
		#endregion
	}
}

// Assign default tile array
if resetArray {
	resetArray = false;
	sprMaterial = spr_tls_staircase_default // Reset material
	
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
					slopeOriginOffsetX = 0;
					slopeOriginOffsetY = -20;
					
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
					if i > 0 && i < width + 1 && j = 1 {
						tileArrayDrawX[i,j] = 60;
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
					if i > 1 && i < width + 1 {
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
					if i = width + 1 {
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
					if i > 1 && i < width + 1 {
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
					if i = width + 1 {
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
				if staircaseRotation = 4 {
					#region
					if i = 1 {
						if j = 0 {
							tileArrayDrawX[i,j] = 60;
							tileArrayDrawY[i,j] = 200;
						}
						if j = 1 {
							tileArrayDrawX[i,j] = 60;
							tileArrayDrawY[i,j] = 180;
						}
						if j = 2 {
							tileArrayDrawX[i,j] = 60;
							tileArrayDrawY[i,j] = 160;
						}
						if j = 3 {
							tileArrayDrawX[i,j] = 60;
							tileArrayDrawY[i,j] = 140;
						}
					}
					if i > 1 && i < width {
						if j = i - 2 {
							tileArrayDrawX[i,j] = 80;
							tileArrayDrawY[i,j] = 200;
						}
						if j = i - 1 {
							tileArrayDrawX[i,j] = 80;
							tileArrayDrawY[i,j] = 180;
						}
						if j = i {
							tileArrayDrawX[i,j] = 80;
							tileArrayDrawY[i,j] = 160;
						}
						if j = i + 1 {
							tileArrayDrawX[i,j] = 80;
							tileArrayDrawY[i,j] = 140;
						}
						if j = i + 2 {
							tileArrayDrawX[i,j] = 80;
							tileArrayDrawY[i,j] = 120;
						}
					}
					if i = width {
						if j = i - 2 {
							tileArrayDrawX[i,j] = 80;
							tileArrayDrawY[i,j] = 200;
						}
						if j = i - 1 {
							tileArrayDrawX[i,j] = 100;
							tileArrayDrawY[i,j] = 160;
						}
						if j = i {
							tileArrayDrawX[i,j] = 100;
							tileArrayDrawY[i,j] = 140;
						}
						if j = i + 1 {
							tileArrayDrawX[i,j] = 100;
							tileArrayDrawY[i,j] = 120;
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

//if select {
	if mouse_check_button(mb_right) {
		angleRun = mouseCheckX - (x + 10);
		angleRise = mouseCheckY - (y + (zfloor - zcieling)*20 + 10); 
		
		if angleRun != 0 {
			angleRise /= abs(angleRun);
			angleRun /= abs(angleRun);
		} else {
			angleRise /= abs(angleRise);
		}
		
		staircaseL = width * 20 + width*2;
		normalAng = point_direction( 0, 0, angleRun, angleRise );
		ang = (normalAng + 90 + 360) % 360;
		stepLength = staircaseN / 5;
		altW = lengthdir_x( stepLength, normalAng );
		altH = lengthdir_y( stepLength, normalAng );
		
		stepPriority = normalAng > 180 && normalAng < 360;
		
		x1 = x;
		y1 = y;
		yy1 = y1 + altH;
		x2 = x1 + lengthdir_x( staircaseL, ang );
		y2 = y1 + lengthdir_y( staircaseL, ang );
		yy2 = y2 + altH;
		x3 = x1 + lengthdir_x( staircaseN, normalAng );
		y3 = y1 + lengthdir_y( staircaseN, normalAng ) + (zfloor-zcieling)*20;
		yy3 = y3 + altH;
		x4 = x2 + lengthdir_x( staircaseN, normalAng );
		y4 = y2 + lengthdir_y( staircaseN, normalAng ) + (zfloor-zcieling)*20;
		yy4 = y4 + altH;
		
		 staircaseRasterX0 = floor(min(x1, x2, x3, x4)) - 1;
		 staircaseRasterY0 = floor(min(y1, y2, y3, y4, yy1, yy2, yy3, yy4));
		
		staircaseW = ceil(max(x1, x2, x3, x4)) - staircaseRasterX0 + 2;
		staircaseH = ceil(max(y1, y2, y3, y4, yy1, yy2, yy3, yy4)) - staircaseRasterY0 + 1;
		
		// Clear staircase raster.
		for ( var i = 0; i < staircaseW; i++ ) {
			for ( var j = 0; j < staircaseH; j++ ) {
				staircaseRasterInd[i,j] = -1; // Empty pixel
				staircaseRasterTempInd[i,j] = -1;
			}
		}
	}
//}
