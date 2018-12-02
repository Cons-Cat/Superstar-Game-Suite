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
			if staircaseType = 0 {
				if staircaseRotation = 4 {
					for (i = 2; i < widthIterate - 1; i += 1) {
						with instance_create_layer(x+(i-1)*20,y-(i-2)*20,"Instances",obj_staircase_collision) {
							zfloor = other.zfloor;
							staircaseType = other.staircaseType;
							staircaseRotation = other.staircaseRotation;
							staircaseSlope = other.staircaseSlope;
							xOrigin = other.xOrigin;
							yOrigin = other.yOrigin;
							
							sprite_index = spr_slopeL_1x_bot;
						}
						with instance_create_layer(x+(i-1)*20-20,y-(i-2)*20,"Instances",obj_staircase_collision) {
							zfloor = other.zfloor;
							staircaseType = other.staircaseType;
							staircaseRotation = other.staircaseRotation;
							staircaseSlope = other.staircaseSlope;
							xOrigin = other.xOrigin;
							yOrigin = other.yOrigin;
							
							sprite_index = spr_slopeR_1x_bot;
						}
						with instance_create_layer(x+(i-1)*20-20,y-(i-2)*20-20,"Instances",obj_staircase_collision) {
							zfloor = other.zfloor;
							staircaseType = other.staircaseType;
							staircaseRotation = other.staircaseRotation;
							staircaseSlope = other.staircaseSlope;
							xOrigin = other.xOrigin;
							yOrigin = other.yOrigin;
							
							sprite_index = spr_slopeR_1x;
						}
						with instance_create_layer(x+(i-1)*20,y-(i-2)*20-20,"Instances",obj_staircase_collision) {
							zfloor = other.zfloor;
							staircaseType = other.staircaseType;
							staircaseRotation = other.staircaseRotation;
							staircaseSlope = other.staircaseSlope;
							xOrigin = other.xOrigin;
							yOrigin = other.yOrigin;
							
							sprite_index = spr_slopeL_1x;
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
