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
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z2) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_finite_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_info_editor) {
		trg = other.id;
		str2 = "mirror";
	}
	with instance_create_layer(x,y+20,"Instances",obj_info_editor) {
		trg = other.id;
		str2 = "flip";
	}
}

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
