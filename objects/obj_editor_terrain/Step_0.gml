/// @description Manipulating dimensions
event_inherited();

if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 || obj_editor_gui.mode = 3 {
	modeForSelectVal = obj_editor_gui.mode;
}

// Merge like instances
if canMerge {
	if collision_point(bbox_right+10,y+10,obj_editor_terrain,false,true) { // Merge rightward
		for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
			tempInst = instance_find(obj_editor_terrain,i);
			
			if tempInst.zfloor = self.zfloor && tempInst.zcieling = self.zcieling && tempInst.y = self.y && tempInst.x = self.x + self.width*20 {
				width += tempInst.width;
				resetArray = true;
				
				with tempInst {
					instance_destroy();
				}
				
				break;
			}
		}
	}
	
	if collision_point(bbox_left-10,y+10,obj_editor_terrain,false,true) { // Merge leftward
		for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
			tempInst = instance_find(obj_editor_terrain,i);
			
			if tempInst.zfloor = self.zfloor && tempInst.zcieling = self.zcieling && tempInst.y = self.y && tempInst.x = self.x - tempInst.width*20 {
				x = tempInst.x;
				width += tempInst.width;
				resetArray = true;
				
				with tempInst {
					instance_destroy();
				}
				
				break;
			}
		}
	}
	
	canMerge = false;
}

// Dimensional manipulation
if spawnButtons {
	#region
	
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
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_right) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_left) {
		trg = other.id;
	}
	
	#endregion
}

// Tile array
if resetArray && obj_editor_gui.mode != 3 {
	#region
	
	resetArray = false;
	calculateSub = true;
	sprMaterial = spr_tls_rectangle_default // Reset material
	tileArrayHeight = height + zfloor - zcieling + 1;
	tileLayerCount = 0;
	
	for (i = 0; i < width + 2; i += 1) {
		for (j = 0; j < height + zfloor - zcieling + 1; j += 1) {
			hasTile[scr_array_xy(i,j,tileArrayHeight),0] = true;
			hasTile[scr_array_xy(i,j,tileArrayHeight),1] = false;
			
			// Default to the designated coordinates of an empty tile
			tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 0;
			tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 120;
			
			if i = 1 && j = 1 {
				if width > 1 && height > 1 {
					// Top left floor corner index
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 20;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 20;
				} else if width > 1 {
					// Left beam edge
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 0;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 220;
				} else if height > 1 {
					// Vertical top beam edge
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 80;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 180;
				} else {
					// Center edge
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 0;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 100;
				}
			}
			if i = width && j = 1 {
				if height > 1 && width > 1 {
					// Top right floor corner index
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 60;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 20;
				} else if width > 1 {
					// Right beam edge
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 40;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 220;
				}
			}
			if i = 1 && j = height {
				if height > 1 && width > 1 {
					// Bottom left floor corner index
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 20;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 60;
				} else if height > 1 {
					// Vertical bottom beam edge
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 80;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 220;
				}
			}
			if i = width && j = height {
				if width > 1 && height > 1 {
					// Bottom right floor corner index
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 60;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 60;
				}
			}
			if i > 1 && i < width && j = 1 {
				if height > 1 {
					// Top floor edge index
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 40;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 20;
				}
			}
			if i > 1 && i < width && j = height {
				if width > 1 {
					if height > 1 {
						// Bottom floor edge index
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 40;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 60;
					} else {
						// Center horizontal beam center edge index
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 20;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 220;
					}
				}
			}
			if j > 1 && j < height && i = 1 {
				if width > 1 && height > 1 {
					// Left floor edge index
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 20;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 40;
				} else if height > 1 {
					// Center vertical beam edge index
					tileArrayDrawX[1,j] = 80;
					tileArrayDrawY[1,j] = 200;
				}
			}
			if height = 1 && width >= 2 {
				// Right horizontal beam edge index
				tileArrayDrawX[width,1] = 40;
				tileArrayDrawY[width,1] = 220;
			}
			if j > 1 && j < height && i = width {
				if width > 1 {
					// Right floor edge index
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 60;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 40;
				}
			}
			if i > 1 && i < width && j > 1 && j < height {
				if width > 1 && height > 1 {
					// Center floor index
					tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 40;
					tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 40;
				}
			}
			
			if j > height {
				if i = 1 {
					if width > 1 {
						// Left wall edge
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 20;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 100;
					} else {
						// Vertical beam center wall edge
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 80;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 100;
					}
				}
				if i = width {
					if width > 1 {
						// Right wall edge
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 60;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 100;
					}
				}
				if i > 1 && i < width && j = image_yscale {
					if width > 1 {
						// Bottom wall edge
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 40;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 120;
					}
				}
				if i > 1 && i < width && j < image_yscale {
					if width > 1 {
						// Center wall
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 40;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 100;
					}
				}
				if i = 1 && j = image_yscale {
					if width > 1 {
						// Bottom left wall corner
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 20;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 120;
					}
				}
				if i = width && j = image_yscale {
					if width > 1 {
						// Bottom right wall corner
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 60;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 120;
					}
				}
				if i = 1 && j = image_yscale {
					if width = 1 && image_yscale > 1 {
						// Vertical beam bottom edge
						tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = 80;
						tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = 120;
					}
				}
			}
		}
	}
	
	#endregion
	
	// Update the minimap
	with obj_panel_bot {
		//scr_editor_map(other.x, other.y, other.x + other.width * 20, other.y + (other.zfloor - other.zcieling + other.height) * 20);
	}
}
