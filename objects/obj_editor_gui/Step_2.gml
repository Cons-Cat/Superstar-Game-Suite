/// @description Change room state for mode
if mode = 1 {
	// Dark grid
	modeGridSpr = spr_grid_dark_editor;
} else {
	// Light grid
	modeGridSpr = spr_grid_editor;
}

mouseCheckX = floor(mouse_x/2) + camera_get_view_x(cameraRealGame);
mouseCheckY = floor(mouse_y/2+596) + camera_get_view_y(cameraRealGame) - 596;

// Selecting instances
if canChangeSelect {
	tempDepth = 0;
	selectInstance = -1;
	
	for (i = 0; i < instance_number(obj_editor_terrain_par); i += 1) {
		with instance_find(obj_editor_terrain_par,i) {
			select = false;
			canSelect = false;
			
			other.tempSelectInstance = self.id;
		}
		
		if (mouseCheckX >= tempSelectInstance.x && mouseCheckX < tempSelectInstance.x + tempSelectInstance.width * 20 && mouseCheckY >= tempSelectInstance.y && mouseCheckY < tempSelectInstance.y + (tempSelectInstance.zfloor*20 - tempSelectInstance.zcieling*20) + 20 && (mode != 1 && tempSelectInstance.modeForSelect)) {
			if tempSelectInstance.modeForSelect {
				if tempSelectInstance.depth <= tempDepth {
					tempDepth = tempSelectInstance.depth;
					selectInstance = tempSelectInstance;
				}
			}
		}
	}
	
	if selectInstance != -1 {
		selectInstance.canSelect = true;
	}
}

if !instance_exists(obj_editor_terrain_par) {
	tempSelectInstance = -1;
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
			// Initialize variables
			trgCreated[0] = -1;
			trgCreated[1] = -1;
			doubledUp = false;
			
			for (j = 0; j <= 4; j += 1) {
				if sprCreate[j] = -1 {
					// Not all staircase sets use all iterations
					break;
				}
				
				if staircaseRotation = 0 || staircaseRotation = 2 {
					#region
					
					if staircaseType = 2 {
						// Tall staircase
						iterateLength = heightIterate - widthIterateCollisionOff - 1;
					} else {
						// Short staircases
						iterateLength = heightIterate - widthIterateCollisionOff;
					}
					
					if j = 0 {
						// Center
						xCreateOff = 0;
						yCreateOff = 0;
					}
					
					#endregion
				}
				if staircaseRotation = 1 {
					#region
					
					iterateLength = widthIterate - widthIterateCollisionOff;
					
					if j = 0 {
						// Center
						xCreateOff = 0;
						yCreateOff = 0;
					}
					
					#endregion
				}
				if staircaseRotation = 3 {
					#region
					
					iterateLength = widthIterate - widthIterateCollisionOff;
					
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
						// Center
						xCreateOff = 20;
						yCreateOff = 20;
					}
					
					#endregion
				}
				if staircaseRotation = 4 {
					#region
					
					iterateLength = widthIterate - widthIterateCollisionOff;
					
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
				if staircaseRotation = 5 {
					#region
					
					iterateLength = widthIterate - widthIterateCollisionOff;
					
					if j = 0 {
						// Bottom right
						xCreateOff = 20;
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
						yCreateOff = 40;
					}
					if j = 3 {
						// Top right
						xCreateOff = 0;
						yCreateOff = 20;
					}
					if j = 4 {
						// Center
						xCreateOff = 20;
						yCreateOff = 20;
					}
					
					#endregion
				}
				if staircaseRotation = 6 {
					#region
					
					iterateLength = widthIterate - widthIterateCollisionOff;
					
					if j = 0 {
						// Center
						xCreateOff = 0;
						yCreateOff = 0;
					}
					
					#endregion
				}
				if staircaseRotation = 7 {
					#region
					
					iterateLength = widthIterate - widthIterateCollisionOff;
					
					if j = 0 {
						// Bottom right
						xCreateOff = -40;
						yCreateOff = 0;
					}
					if j = 1 {
						// Bottom left
						xCreateOff = 0;
						yCreateOff = 0;
					}
					if j = 2 {
						// Top left
						xCreateOff = 0;
						yCreateOff = 20;
					}
					if j = 3 {
						// Top right
						xCreateOff = -20;
						yCreateOff = 40;
					}
					if j = 4 {
						// Center
						xCreateOff = -20;
						yCreateOff = 20;
					}
					
					#endregion
				}
				if staircaseRotation = 8 {
					#region
					
					iterateLength = widthIterate - widthIterateCollisionOff;
					
					if j = 0 {
						// Bottom right
						xCreateOff = -40;
						yCreateOff = 0;
					}
					if j = 1 {
						// Bottom left
						xCreateOff = -20;
						yCreateOff = 0;
					}
					if j = 2 {
						// Top left
						xCreateOff = -20;
						yCreateOff = 20;
					}
					if j = 3 {
						// Top right
						xCreateOff = -40;
						yCreateOff = 20;
					}
					
					#endregion
				}
				if staircaseRotation = 9 {
					#region
					
					iterateLength = widthIterate - widthIterateCollisionOff;
					
					if j = 0 {
						// Bottom right
						xCreateOff = -20;
						yCreateOff = 0;
					}
					if j = 1 {
						// Bottom left
						xCreateOff = 0;
						yCreateOff = 0;
					}
					if j = 2 {
						// Top left
						xCreateOff = 0;
						yCreateOff = 40;
					}
					if j = 3 {
						// Top right
						xCreateOff = -40;
						yCreateOff = 20;
					}
					if j = 4 {
						// Center
						xCreateOff = -20;
						yCreateOff = 20;
					}
					
					#endregion
				}
				
				for (i = 0; i < iterateLength; i += 1) {
					if staircaseType = 0 {
						#region
						
						staircaseCollisionRows = 0;
						
						if staircaseRotation = 1 {
							#region
							
							staircaseCollisionRows = 0;
							trgCreated[0] = instance_create_layer(x+i*20,y,"Instances",obj_staircase_collision);
							
							#endregion
						}
						if staircaseRotation = 4 {
							#region
							
							staircaseCollisionRows = 0;
							
							if i > 1 {
								trgCreated[0] = instance_create_layer(x+i*20-xCreateOff-20,y-(i-2)*20-yCreateOff,"Instances",obj_staircase_collision);
							}
							
							#endregion
						}
						
						#endregion
					}
					if staircaseType = 1 {
						#region
						
						if staircaseRotation = 0 || staircaseRotation = 2 {
							#region
							
							staircaseCollisionRows = 1;
							trgCreated[0] = instance_create_layer(x,y-i*20,"Instances",obj_staircase_collision);
							trgCreated[1] = instance_create_layer(x+20,y-i*20,"Instances",obj_staircase_collision);
							
							#endregion
						}
						if staircaseRotation = 1 || staircaseRotation = 6 {
							#region
							
							staircaseCollisionRows = 1;
							trgCreated[0] = instance_create_layer(x+i*20,y,"Instances",obj_staircase_collision);
							trgCreated[1] = instance_create_layer(x+i*20,y-20,"Instances",obj_staircase_collision);
							
							#endregion
						}
						if staircaseRotation = 3 {
							#region
							
							staircaseCollisionRows = 0;
							
							if i > 1 {
								with instance_create_layer(x+i*20-xCreateOff,y-(i-2)*40-yCreateOff,"Instances",obj_staircase_collision) {
									// Don't question it. For the sake of your own sanity, DO NOT QUESTION IT !!!
									
									other.trgCreated[0] = self.id;
									sprite_index = other.sprCreate[other.j];
								}
							}
							
							#endregion
						}
						if staircaseRotation = 4 {
							#region
							
							doubledUp = true;
							staircaseCollisionRows = 1;
							
							if i > 1 {
								trgCreated[0] = instance_create_layer(x+i*20-xCreateOff,y-(i-2)*20-yCreateOff,"Instances",obj_staircase_collision);
								trgCreated[1] = instance_create_layer(x+(i-1)*20-xCreateOff,y-(i-2)*20-yCreateOff-20,"Instances",obj_staircase_collision);
							}
							
							#endregion
						}
						if staircaseRotation = 5 {
							#region
							
							staircaseCollisionRows = 0;
							
							if i > 1 {
								with instance_create_layer(x+(i)*20-xCreateOff,y-(i-2)*10-yCreateOff,"Instances",obj_staircase_collision) {
									// Don't question it. For the sake of your own sanity, DO NOT QUESTION IT !!!
									
									other.trgCreated[0] = self.id;
									sprite_index = other.sprCreate[other.j];
								}
							}
							
							#endregion
						}
						if staircaseRotation = 7 {
							#region
							
							staircaseCollisionRows = 0;
							
							if i > 1 {
								with instance_create_layer(x+width*20-i*20-xCreateOff,y-(i-2)*10-yCreateOff,"Instances",obj_staircase_collision) {
									// Don't question it. For the sake of your own sanity, DO NOT QUESTION IT !!!
									
									other.trgCreated[0] = self.id;
									sprite_index = other.sprCreate[other.j];
								}
							}
							
							#endregion
						}
						if staircaseRotation = 8 {
							#region
							
							doubledUp = true;
							staircaseCollisionRows = 1;
							
							if i > 1 {
								trgCreated[0] = instance_create_layer(x+width*20-i*20-xCreateOff,y-(i-2)*20-yCreateOff,"Instances",obj_staircase_collision);
								trgCreated[1] = instance_create_layer(x+width*20-(i-1)*20-xCreateOff,y-(i-2)*20-yCreateOff-20,"Instances",obj_staircase_collision);
							}
							
							#endregion
						}
						if staircaseRotation = 9 {
							#region
							
							staircaseCollisionRows = 0;
							
							if i > 1 {
								with instance_create_layer(x+width*10+20-i*20-xCreateOff,y-(i-2)*40-yCreateOff,"Instances",obj_staircase_collision) {
									// Don't question it. For the sake of your own sanity, DO NOT QUESTION IT !!!
									
									other.trgCreated[0] = self.id;
									sprite_index = other.sprCreate[other.j];
								}
							}
							
							#endregion
						}
						
						#endregion
					}
					if staircaseType = 2 {
						#region
						
						if staircaseRotation = 0 {
							#region
							
							staircaseCollisionRows = 0;
							trgCreated[0] = instance_create_layer(x,y-i*20,"Instances",obj_staircase_collision);
							
							#endregion
						}
						if staircaseRotation = 1 || staircaseRotation = 6 {
							#region
							
							staircaseCollisionRows = 0;
							trgCreated[0] = instance_create_layer(x+i*20,y,"Instances",obj_staircase_collision);
							
							#endregion
						}
						if staircaseRotation = 2 {
							#region
							
							staircaseCollisionRows = 0;
							trgCreated[0] = instance_create_layer(x,y-i*20,"Instances",obj_staircase_collision);
							
							#endregion
						}
						if staircaseRotation = 3 {
							#region
							
							staircaseCollisionRows = 0;
							
							if i > 1 {
								with instance_create_layer(x+i*20-xCreateOff,y-(i-2)*40-yCreateOff,"Instances",obj_staircase_collision) {
									// Don't question it. For the sake of your own sanity, DO NOT QUESTION IT !!!
									
									other.trgCreated[0] = self.id;
									sprite_index = other.sprCreate[other.j];
								}
							}
							
							#endregion
						}
						if staircaseRotation = 4 {
							#region
							
							staircaseCollisionRows = 0;
							
							if i > 1 {
								trgCreated[0] = instance_create_layer(x+i*20-xCreateOff-20,y-(i-2)*20-yCreateOff,"Instances",obj_staircase_collision);
							}
							
							#endregion
						}
						
						#endregion
					}
					
					for(a = 0; a <= staircaseCollisionRows; a += 1) {
						if (doubledUp && i > 1) || (!doubledUp) {
							if trgCreated[a] != -1 {
								// Pass in specifications
								trgCreated[a].zfloor = self.zfloor;
								trgCreated[a].staircaseRun = self.staircaseRun; // The run of the staircase's slope used to determine an actor's z position
								trgCreated[a].staircaseRise = self.staircaseRise; // The rise of the staircase's slope used to determine an actor's z position
								trgCreated[a].collisionMaskRun = self.collisionMaskRun; // The run of the sloped edge at which rays iterate from
								trgCreated[a].collisionMaskRise = self.collisionMaskRise; // The rise of the sloped edge at which rays iterate from
								trgCreated[a].widthIterate = self.widthIterate;
								trgCreated[a].widthIterateCollisionOff = self.widthIterateCollisionOff;
								trgCreated[a].iterateLength = self.iterateLength; // How many iterations of rays there will be across the staircase edge
								trgCreated[a].slopeOriginOffsetX = self.slopeOriginOffsetX; // The x coordinate at which the rays start from
								trgCreated[a].slopeOriginOffsetY = self.slopeOriginOffsetY; // The y coordinate at which the rays start from
								trgCreated[a].rayXComponent = self.rayXComponent; // The horizontal length component of the collision ray
								trgCreated[a].rayYComponent = self.rayYComponent; // The vertical length component of the collision ray
								trgCreated[a].staircaseRotation = self.staircaseRotation; // Used to check if the rotation is 0 or 2, which need collision exception cases
								
								if !(self.staircaseRotation = 3 || self.staircaseRotation = 5 || self.staircaseRotation = 7 || self.staircaseRotation = 9) {
									// There is no explicable reason why this if-statement makes the game work, but it does.
									// I spent hours trying to comprehend this. Seriously, take my word for it.
									
									trgCreated[a].sprite_index = self.sprCreate[self.j]; // The collision mask of this instance
								}
							}
						}
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
		with obj_trigger_cutscene_region_level {
			instance_destroy();
		}
		with obj_trigger_pan_region_level {
			instance_destroy();
		}
		with obj_trigger_anchor_region_level {
			instance_destroy();
		}
		with obj_player_overworld {
			instance_destroy();
		}
		with obj_npc_position {
			xNode[0] = -1;
			yNode[0] = -1;
			i = 0;
		}
	}
}

// Control side panel pushing
if obj_panel_left.select = 0 && obj_panel_right.select = 0 {
	sidePanelCtrl = -1;
}

// Fullscreen
/*if keyboard_check(vk_alt) && keyboard_check_pressed(vk_enter) {
	if window_get_fullscreen() {
		window_set_fullscreen(false);
	} else {
		window_set_fullscreen(true);
	}
}
