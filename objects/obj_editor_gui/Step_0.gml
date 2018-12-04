/// @description Change room state for mode
var lay_id = layer_get_id("Background");
var back_id = layer_background_get_id(lay_id);

if mode = 1 {
	// Dark grid
	layer_background_sprite(back_id,spr_grid_dark_editor);
} else {
	// Light grid
	layer_background_sprite(back_id,spr_grid_editor);
}

// Spawn collisions
if mode = 2 {
	if !spawnedCollisions {
		spawnedCollisions = true;
		alarm[0] = 2;
		
		with obj_editor_terrain {
			if zfloor > 0 || !finite {
				// Front collision
				with instance_create_layer(x,y,"Instances",obj_solid) {
					y = other.y+(other.zfloor+other.height-1)*20;
					x = other.x;
					image_xscale = other.width;
					zplace = other.zplace;
					zcieling = other.zcieling;
					finite = other.finite;
				}
				if height > 1 {
					// Back collision
					with instance_create_layer(x,y,"Instances",obj_solid) {
						y = other.y+(other.zfloor)*20;
						x = other.x;
						image_xscale = other.width;
						zplace = other.zplace;
						zcieling = other.zcieling;
						finite = other.finite;
					}
				}
				// Left collision
				with instance_create_layer(x,y,"Instances",obj_solid_side) {
					zplace = other.zplace;
					zcieling = other.zcieling;
					height = other.height;
					finite = other.finite;
					
					image_yscale = other.height;
					y = other.y+(other.zfloor)*20
				}
				if width > 1 {
					// Right collision
					with instance_create_layer(x,y,"Instances",obj_solid_side) {
						zplace = other.zplace;
						zcieling = other.zcieling;
						height = other.height;
						finite = other.finite;
						
						image_yscale = other.height;
						y = other.y+(other.zfloor)*20
					}
				}
			}
			if finite {
				// Floor collision
				with instance_create_layer(x,y,"Instances",obj_floor) {
					y = other.y;
					x = other.x;
					image_xscale = other.width;
					image_yscale = other.height;
					zfloor = other.zfloor;
					zcieling = other.zcieling;
					depthOffset = other.depthOffset;
					finite = other.finite;
				}
			}
		}
		with obj_editor_slope1 {
			if zfloor > 0 || !finite {
				for (i = 0; i < width; i += 1) {
					// Right slopes collision
					if !flip {
						if !mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeL_1x_bot) {
								y = other.y+(other.zfloor)*20+(other.height-1)*20-(other.i)*20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
						if mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeR_1x_bot) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
					} else {
						if !mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeR_1x) {
								y = other.y+(other.zfloor)*20+(other.height-1)*20-(other.i)*20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
						if mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeL_1x) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
					}
				}
			}
			if finite {
				with instance_create_layer(x,y,"Instances",obj_floor) {
					// Floor collision
					zfloor = other.zfloor;
					zcieling = other.zcieling;
					depthOffset = other.depthOffset;
					finite = other.finite;
					
					if other.mirror {
						if other.flip {
							sprite_index = spr_slopeL_1x;
						} else {
							sprite_index = spr_slopeR_1x_bot;
						}
					} else {
						if other.flip {
							sprite_index = spr_slopeR_1x;
						} else {
							sprite_index = spr_slopeL_1x_bot;
						}
					}
				}
			}
		}
		with obj_editor_slope2 {
			if zfloor > 0 || !finite {
				for (i = 0; i < width; i += 1) {
					// Right slopes collision
					if !flip {
						if !mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeL_2x_bot) {
								y = other.y+(other.zfloor)*20+(other.height-1)*20-(other.i)*20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
						if mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeR_2x_bot) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
					} else {
						if !mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeR_2x) {
								y = other.y+(other.zfloor)*20+(other.height-1)*20-(other.i)*20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
						if mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeL_2x) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
					}
				}
			}
			if finite {
				with instance_create_layer(x,y,"Instances",obj_floor) {
					// Floor collision
					zfloor = other.zfloor;
					zcieling = other.zcieling;
					depthOffset = other.depthOffset;
					finite = other.finite;
					
					if other.mirror {
						if other.flip {
							sprite_index = spr_slopeL_2x;
						} else {
							sprite_index = spr_slopeR_2x_bot;
						}
					} else {
						if other.flip {
							sprite_index = spr_slopeR_2x;
						} else {
							sprite_index = spr_slopeL_2x_bot;
						}
					}
				}
			}
		}
		with obj_editor_slope3 {
			if zfloor > 0 || !finite {
				for (i = 0; i < width; i += 1) {
					// Right slopes collision
					if !flip {
						if !mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeL_05x_bot) {
								y = other.y+(other.zfloor)*20+(other.height-1)*20-(other.i)*20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
						if mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeR_05x_bot) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
					} else {
						if !mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeR_05x) {
								y = other.y+(other.zfloor)*20+(other.height-1)*20-(other.i)*20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
						if mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeL_05x) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								zplace = other.zplace;
								zcieling = other.zcieling;
								finite = other.finite;
							}
						}
					}
				}
			}
			if finite {
				with instance_create_layer(x,y,"Instances",obj_floor) {
					// Floor collision
					zfloor = other.zfloor;
					zcieling = other.zcieling;
					depthOffset = other.depthOffset;
					finite = other.finite;
					
					if other.mirror {
						if other.flip {
							sprite_index = spr_slopeL_05x;
						} else {
							sprite_index = spr_slopeR_05x_bot;
						}
					} else {
						if other.flip {
							sprite_index = spr_slopeR_05x;
						} else {
							sprite_index = spr_slopeL_05x_bot;
						}
					}
				}
			}
		}
		with obj_editor_staircase {
			for (j = 0; j <= 4; j += 1) {
				if j = 4 {
					if sprCreate[j] = -1 {
						// Not all staircase sets use this iteration
						break;
					}
				}
				
				if staircaseRotation = 3 {
					#region
					iIncrement = 1;
					
					if j = 0 {
						// Bottom right
						xCreateOff = 0;
						yCreateOff = 0;
					}
					if j = 1 {
						// Bottom left
						xCreateOff = 40;
						yCreateOff = 0;
					}
					if j = 2 {
						// Top left
						xCreateOff = 40;
						yCreateOff = 20;
					}
					if j = 3 {
						// Top right
						xCreateOff = 20;
						yCreateOff = 40;
					}
					if j = 4 {
						// Top right
						xCreateOff = 20;
						yCreateOff = 20;
					}
					#endregion
				}
				if staircaseRotation = 4 {
					#region
					iIncrement = 1;
					
					if j = 0 {
						// Bottom right
						xCreateOff = 0;
						yCreateOff = 0;
					}
					if j = 1 {
						// Bottom left
						xCreateOff = 20;
						yCreateOff = 0;
					}
					if j = 2 {
						// Top left
						xCreateOff = 20;
						yCreateOff = 20;
					}
					if j = 3 {
						// Top right
						xCreateOff = 0;
						yCreateOff = 20;
					}
					#endregion
				}
				
				for (i = 2; i < widthIterate - widthIterateCollisionOff; i += iIncrement) {
					if staircaseType = 0 {
						#region
						if staircaseRotation = 4 {
							#region
							with instance_create_layer(x+(i-1)*20-xCreateOff,y-(i-2)*20-yCreateOff,"Instances",obj_staircase_collision) {
								zfloor = other.zfloor;
								staircaseType = other.staircaseType;
								staircaseRotation = other.staircaseRotation;
								staircaseRun = other.staircaseRun;
								staircaseRise = other.staircaseRise;
								
								sprite_index = other.sprCreate[other.j];
							}
							#endregion
						}
						#endregion
					}
					if staircaseType = 1 {
						#region
						if staircaseRotation = 3 {
							#region
							with instance_create_layer(x+(i-1)*20-xCreateOff+20,y-(i-2)*40-yCreateOff,"Instances",obj_staircase_collision) {
								zfloor = other.zfloor;
								staircaseType = other.staircaseType;
								staircaseRotation = other.staircaseRotation;
								staircaseRun = other.staircaseRun;
								staircaseRise = other.staircaseRise;
								
								sprite_index = other.sprCreate[other.j];
							}
							#endregion
						}
						if staircaseRotation = 4 {
							#region
							with instance_create_layer(x+(i-1)*20-xCreateOff+20,y-(i-2)*20-yCreateOff,"Instances",obj_staircase_collision) {
								zfloor = other.zfloor;
								staircaseType = other.staircaseType;
								staircaseRotation = other.staircaseRotation;
								staircaseRun = other.staircaseRun;
								staircaseRise = other.staircaseRise;
								
								sprite_index = other.sprCreate[other.j];
							}
							with instance_create_layer(x+(i-1)*20-xCreateOff,y-(i-2)*20-yCreateOff-20,"Instances",obj_staircase_collision) {
								zfloor = other.zfloor;
								staircaseType = other.staircaseType;
								staircaseRotation = other.staircaseRotation;
								staircaseRun = other.staircaseRun;
								staircaseRise = other.staircaseRise;
								
								sprite_index = other.sprCreate[other.j];
							}
							#endregion
						}
						#endregion
					}
					if staircaseType = 2 {
						#region
						if staircaseRotation = 4 {
							#region
							with instance_create_layer(x+(i-1)*20-xCreateOff,y-(i-2)*20-yCreateOff,"Instances",obj_staircase_collision) {
								zfloor = other.zfloor;
								staircaseType = other.staircaseType;
								staircaseRotation = other.staircaseRotation;
								staircaseRun = other.staircaseRun;
								staircaseRise = other.staircaseRise;
								
								sprite_index = other.sprCreate[other.j];
							}
							#endregion
						}
						#endregion
					}
				}
			}
		}
	}
} else {
	if spawnedCollisions {
		spawnedCollisions = false;
		
		with obj_solid_parent {
			instance_destroy();
		}
		with obj_floor {
			instance_destroy();
		}
		with obj_staircase_collision {
			instance_destroy();
		}
		with obj_trigger_dialogue_region_level {
			instance_destroy();
		}
		with obj_player_overworld {
			instance_destroy();
		}
		with obj_npc_position {
			xNode[0] = -1;
			yNode[0] = -1;
			i = 0;
			maxI = 0;
		}
	}
}

if mode = 3 {
	if keyboard_check_pressed(vk_enter) {
		if instance_exists(obj_tiles_grid) {
			view_visible[1] = false;
			view_visible[2] = false;
			
			obj_tiles_grid.close = true;
			global.pieceSelected = -1;
		}
	}
}
