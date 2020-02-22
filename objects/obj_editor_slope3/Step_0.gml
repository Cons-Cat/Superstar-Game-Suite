/// @description Manipulating dimensions
event_inherited();

if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 || obj_editor_gui.mode = 3 {
	modeForSelectVal = obj_editor_gui.mode;
}

// Dimensional manipulation
if spawnButtons {
	#region
	
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	if obj_z_mode.mode = 0 || zfloor <= obj_z_max.z {
		with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z) {
			trg = other.id;
		}
	}
	if obj_z_mode.mode = 0 || zcieling >= obj_z_min.z {
		with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z2) {
			trg = other.id;
		}
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
	
	#endregion
}

// Update angle
if mirror {
	angleSlope = -2;
	angleStartY = 0;
} else {
	angleSlope = 2;
	angleStartY = height * 20 - 1;
}

// Tile array
if resetArray {
	#region
	
	resetArray = false;
	calculateSub = true;
	sprMaterial = spr_tls_rectangle_default; // Reset 
	tileArrayHeight = height + zfloor - zcieling + 1;
	
	if zfloor > zcieling {
		// Pillar
		tileLayerCount = 2;
	} else {
		// Flat floor
		tileLayerCount = 0;
	}
	
	for (k = 0; k <= tileLayerCount; k += 2) {
		layerVisible[k] = true;
		layerType[k] = 0;
		layerOrder[k] = k;
		layerName[k] = "layer_" + string(k div 2);
		layerName[k+1] = "sublayer_" + string((k div 2) + 1);
		
		// Iterate across the width diagonally
		for (i = 0; i < width + 2; i += 1) {
			// Iterate across the z height
			for (j = 0; j < height + zfloor - zcieling + 1; j += 1) {
				hasTile[scr_array_xy(i,j,tileArrayHeight),k] = true;
				hasTile[scr_array_xy(i,j,tileArrayHeight),k+1] = false;
				
				// Default to the designated coordinates of an empty tile
				tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 0;
				tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 120;
				
				// Layer_0
				if k = 0 {
					#region
					
					if i = 1 {
						if ( ( j >= 1 && !flip) || ( j > height && flip ) ) && j < zfloor - zcieling + height + 1 {
							if zfloor > zcieling {
								// Pillar center
								tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 80;
								tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 100;
							}
						}
						
						if flip {
							if zfloor > zcieling {
								if j = height + zfloor - zcieling {
									// Pillar base
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 80;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 120;
								}
							} else {
								// Flat floor
								if mirror {
									if j = height + zfloor - zcieling {
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 240;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 60;
									}
									if j = height + zfloor - zcieling - 1 {
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 240;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 40;
									}
								} else {
									if j = height + zfloor - zcieling {
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 180;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 60;
									}
									if j = height + zfloor - zcieling - 1 {
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 180;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 40;
									}
								}
							}
						} else {
							if mirror {
								if j = height + zfloor - zcieling {
									if zfloor > zcieling {
										// Pillar base
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 160;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 60;
									} else {
										// Flat floor
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 180;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
									}
								}
								if j = height + zfloor - zcieling - 1 {
									if zfloor > zcieling {
										// Pillar base
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 160;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 40;
									} else {
										// Flat floor
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 180;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 120;
									}
								}
							} else {
								if j = height + zfloor - zcieling {
									if zfloor > zcieling {
										// Pillar base
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 100;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 60;
									} else {
										// Flat floor
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 240;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
									}
								}
								if j = height + zfloor - zcieling - 1 {
									if zfloor > zcieling {
										// Pillar base
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 100;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 40;
									} else {
										// Flat floor
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 240;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 120;
									}
								}
							}
						}
					}
					
					#endregion
				}
				
				// Layer_1
				if k = 2 {
					#region
					
					if i = 1 {
						if flip {
							if mirror {
								if j = 2 {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 240;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 60;
								}
								if j = 1 {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 240;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 40;
								}
							} else {
								if j = 2 {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 180;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 60;
								}
								if j = 1 {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 180;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 40;
								}
							}
						} else {
							if mirror {
								if j = 2 {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 180;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
								}
								if j = 1 {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 180;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 120;
								}
							} else {
								if j = 2 {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 240;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
								}
								if j = 1 {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 240;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 120;
								}
							}
						}
					}
					
					#endregion
				}
				
				/*dummyTop.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
				dummyTop.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];
		
				dummyBot.tileArrayDrawX[i,j] = self.tileArrayDrawX[i,j];
				dummyBot.tileArrayDrawY[i,j] = self.tileArrayDrawY[i,j];*/
			}
		}
	}
	
	#endregion
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
