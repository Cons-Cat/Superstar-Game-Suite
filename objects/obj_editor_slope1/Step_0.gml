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
	angleSlope = -1;
	angleStartY = 0;
} else {
	angleSlope = 1;
	angleStartY = height * 20 - 1;
}

// Tile array
if resetArray {
	#region
	
	resetArray = false;
	calculateSub = true;
	tileArrayHeight = height + zfloor - zcieling + 1;
	tilingWidth = width + 2;
	tilingHeight = height + zfloor - zcieling + 1;
	
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
		
		for (i = 0; i < tilingWidth; i += 1) {
			for (j = 0; j < tilingHeight; j += 1) {
				hasTile[scr_array_xy(i,j,tileArrayHeight),k] = true;
				hasTile[scr_array_xy(i,j,tileArrayHeight),k+1] = false;
				
				// Default to the designated coordinates of an empty tile
				tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 0;
				tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 120;
				
				if i = 1 {
					// Layer_0
					if k = 0 {
						#region
						
						if zfloor > zcieling {
							if ( ( j >= 1 && !flip) || ( j >= 2 && flip ) ) && j < zfloor - zcieling + 1 {
								// Pillar center
								tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 80;
								tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 100;
							}
						}
						
						if !flip {
							if !mirror {
								if j = zfloor - zcieling + 1 {
									if zfloor > zcieling {
										// Pillar base
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 100;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
									} else {
										// Flat floor
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 140;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 160;
									}
								}
							} else {
								if j = zfloor - zcieling + 1 {
									if zfloor > zcieling {
										// Pillar base
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 160;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
									} else {
										// Flat floor
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 120;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 160;
									}
								}
							}
						} else {
							if j = zfloor - zcieling + 1 {
								if zfloor > zcieling {
									// Pillar base, regardless of mirror
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 80;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 120;
								} else {
									// Flat floor
									if !mirror {
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 120;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
									} else {
										tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 140;
										tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
									}
								}
							}
						}
						
						#endregion
					}
					
					// Layer_1
					if k = 2 {
						#region
						
						if j = 1 {
							if !flip {
								if !mirror {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 140;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 160;
								} else {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 120;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 160;
								}
							} else {
								if !mirror {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 120;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
								} else {
									tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = 140;
									tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = 140;
								}
							}
						}
						
						#endregion
					}
				}
			}
		}
	}
	
	#endregion
}
