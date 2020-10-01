/// scr_draw_terrain ( sprTop, subTop, sprMid, subMid, sprBot, subBot)
function scr_draw_terrain() {
	var argX = argument[0];
	var jTop = (y - floorY)/20 + zfloor - zcieling;
	var jBot = zfloor - abs(y - cielY)/20 - zcieling;

	var sprTop = argument[1];
	var subTop = argument[2];

	var sprMid = argument[3];
	var subMid = argument[4];

	var sprBot = argument[5];
	var subBot = argument[6];

	var sprHole = argument[7];
	var subHole = argument[8];

	// Draw Shadow
#region

	if (obj_z_mode.mode = 0 && zcieling > 0) || (obj_z_mode.mode = 1 && zfloor >= obj_z_min.z && zcieling <= obj_z_max.z) {
		var castY = y + zfloor*20;
		var inst;
		var tempZ = -1;
		var drawShad = true;
	
		// Find instances to cast a shadow on
		for (var i = 0; i < instance_number(obj_editor_placeable_parent); i ++) {
			inst = instance_find(obj_editor_placeable_parent,i);
		
			if inst.id != self.id {
				if inst.zfloor > tempZ {
					if inst.zfloor <= self.zcieling {
						if
						(inst.x <= argX && inst.x + inst.width*20 > argX)
						|| (inst.x >= argX && inst.x + inst.width*20 <= argX + 20)
						{
							var instY = inst.y + inst.zfloor*20;
							var selfY = self.y + self.zfloor*20;
					
							if
							(instY <= selfY && instY + inst.height*20 > selfY)
							|| (instY >= selfY && instY + inst.height*20 <= selfY + self.height*20)
							{
								if inst.zfloor = self.zcieling {
									drawShad = false;
							
									break;
								} else {
									// Cast shadow on this instance
									tempZ = inst.zfloor;
									castY = inst.floorY + (selfY - instY);
								}
							}
						}
					}
				}
			}
		}
	
		if drawShad {
			gpu_set_blendmode(bm_inv_src_color);
			gpu_set_fog(true,c_black,0,0);
		
			draw_sprite_ext(sprTop,subTop,argX,castY,1,1,0,c_white,0.425);
		
			gpu_set_blendmode(bm_normal);
			gpu_set_fog(false,c_black,0,0);
		}
	}

#endregion

	for (j = 0; j <= zfloor - zcieling; j += 1) {
		if j < jTop {
			// Draw walls
			if (j + zcieling >= obj_z_min.z && j + zcieling < obj_z_max.z ) || obj_z_mode.mode = 0 {
				if !canSelect {
					layerColor = col[ (j + zcieling) % 9 ];
				} else {
					layerColor = c_orange;
				}
			
				if j = jBot {
					draw_sprite_ext(sprBot,subBot,argX,cielY,1,1,0,layerColor,alpha);
				} else {
					draw_sprite_ext(sprMid,subMid,argX,cielY-(j-jBot)*20,1,1,0,layerColor,alpha);
				}
			}
		} else if j = jTop {
			// Draw floor
			if !canSelect {
				if j > 0 || zcieling > 0 {
					layerColor = col[ (j + zcieling - 1) % 9 ];
				} else {
					layerColor = c_white;
				}
			} else {
				layerColor = c_orange;
			}
		
			if floorY = y || obj_z_mode.mode = 0 {
				draw_sprite_ext(sprTop,subTop,argX,floorY,1,1,0,layerColor,alpha);
			} else {
				draw_sprite_ext(sprHole,subHole,argX,floorY,1,1,0,layerColor,alpha);
			}
		}
	}



}
