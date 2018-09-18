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
			if zfloor > 0 {
				// Front collision
				with instance_create_layer(x,y,"Instances",obj_solid) {
					y = other.y+(other.zfloor+other.height-1)*20;
					x = other.x;
					image_xscale = other.width;
					zplace = other.zfloor;
					zcieling = other.zcieling;
				}
				// Back collision
				with instance_create_layer(x,y,"Instances",obj_solid) {
					y = other.y+(other.zfloor)*20;
					x = other.x;
					image_xscale = other.width;
					zplace = other.zfloor;
					zcieling = other.zcieling;
				}
				// Left collision
				with instance_create_layer(x,y,"Instances",obj_solid_side) {
					zplace = other.zfloor;
					zcieling = other.zcieling;
					height = other.height;
					image_yscale = other.height;
					y = other.y+(zplace)*20
					x = other.x;
				}
				// Right collision
				with instance_create_layer(x,y,"Instances",obj_solid_side) {
					zplace = other.zfloor;
					zcieling = other.zcieling;
					height = other.height;
					image_yscale = other.height;
					y = other.y+(zplace)*20
					x = other.x+(other.width-1)*20;
				}
			}
			// Floor collision
			with instance_create_layer(x,y,"Instances",obj_floor) {
				y = other.y;
				x = other.x;
				image_xscale = other.width;
				image_yscale = other.height;
				zplace = other.zfloor;
				zcieling = other.zcieling;
			}
		}
		with obj_editor_slope1 {
			if zfloor > 0 {
				for (i = 0; i < width; i += 1) {
					// Right slopes collision
					if !flip {
						if !mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeL_1x_bot) {
								y = other.y+(other.zfloor)*20+(other.height-1)*20-(other.i)*20;
								x = other.x+other.i*20;
								zplace = other.zfloor;
								zcieling = other.zcieling;
							}
						
							// Floor collision
							with instance_create_layer(x,y-i*20,"Instances",obj_floor) {
								y = other.y - other.i*20;
								x = other.x + other.i*20;
								sprite_index = spr_slopeL_1x_bot;
								zplace = other.zfloor;
								zcieling = other.zcieling;
							}
						}
						if mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeR_1x_bot) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								zplace = other.zfloor;
								zcieling = other.zcieling;
							}
						
							// Floor collision
							with instance_create_layer(x,y+zfloor*20+i*20-width*20,"Instances",obj_floor) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								sprite_index = spr_slopeR_1x_bot;
								zplace = other.zfloor;
								zcieling = other.zcieling;
							}
						}
					} else {
						if !mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeR_1x) {
								y = other.y+(other.zfloor)*20+(other.height-1)*20-(other.i)*20;
								x = other.x+other.i*20;
								zplace = other.zfloor;
								zcieling = other.zcieling;
							}
							
							// Floor collision
							with instance_create_layer(x,y-i*20,"Instances",obj_floor) {
								x = other.x + other.i*20;
								//sprite_index = spr_slopeR_1x;
								zplace = other.zfloor;
								zcieling = other.zcieling;
							}
						}
						if mirror {
							// Sloped wall collision
							with instance_create_layer(x,y,"Instances",obj_slopeL_1x) {
								y = other.y+(other.zfloor)*20+(other.i)*20-other.width*20+20;
								x = other.x+other.i*20;
								zplace = other.zfloor;
								zcieling = other.zcieling;
							}
							
							// Floor collision
							with instance_create_layer(x,y-(width-i)*20+20,"Instances",obj_floor) {
								x = other.x+other.i*20;
								sprite_index = spr_slopeL_1x;
								zplace = other.zfloor;
								zcieling = other.zcieling;
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
			obj_tiles_grid.close = true;
			view_visible[1] = false;
			view_visible[2] = false;
			global.pieceSelected = -1;
		}
	}
}
