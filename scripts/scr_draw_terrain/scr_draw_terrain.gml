/// scr_draw_terrain ( sprTop, subTop, sprMid, subMid, sprBot, subBot)
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


// Draw Below Shadow
#region
		
/*if (obj_z_mode.mode = 0 && zcieling > 0) || (obj_z_mode.mode = 1 && zfloor >= obj_z_min.z && zcieling <= obj_z_max.z) {
	gpu_set_blendmode(bm_inv_src_color);
	
	for (i = 0; i < width; i += 1) {
		for (j = 0; j < height; j += 1) {
			if !collision_point(x+i*20,y+j*20+(zfloor)*20,obj_editor_terrain,false,true) {
				draw_sprite_ext(spr_shadow_editor,0,x+i*20+10,y+j*20+10+zfloor*20,1,1,0,c_white,0.8);
			}
		}
	}
	
	gpu_set_blendmode(bm_normal);
}*/

#endregion

for (j = 0; j <= zfloor - zcieling; j += 1) {
	if j < jTop {
		// Draw walls
		if (j + zcieling >= obj_z_min.z && j + zcieling < obj_z_max.z )|| obj_z_mode.mode = 0 {
			if !canSelect {
				layerColor = col[ (j + zcieling) % 9 ];
			} else {
				layerColor = c_orange;
			}
			
			if j = jBot {
				draw_sprite_ext(sprBot,subBot,argX,cielY,1,1,0,layerColor,alpha);
			} else {
				draw_sprite_ext(sprMid,subMid,argX,y+(height+zfloor-zcieling-j-1)*20,1,1,0,layerColor,alpha);
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
		
		// Initialize shadow iteration
		/*for (i = 0; i < width; i += 1) {
			for (j = 0; j < height; j += 1) {
				shadowed[i,j] = 0;
			}
		}
		
		// Draw Above Shadow
		if zcieling >= 0 {
			var trgShad;
			
			gpu_set_blendmode(bm_inv_src_color);
			
			if j = zfloor - zcieling {
				for (z = 0; z < y+(zfloor+height)*20; z += 20) {
					if collision_point(x+i*20,z,obj_editor_terrain,false,true) {
						shadowed[i,j] += 1;
						trgShad = collision_point(x+i*20,z,obj_editor_terrain,false,true).id;
						
						for (v = 0; v < trgShad.height; v += 1) {
							if zfloor < trgShad.zcieling {
								if (self.y+self.zfloor*20+j*20) = (trgShad.y+trgShad.zfloor*20+v*20) {
									if shadowed[i,j] = 1 {
										draw_sprite_ext(sprTop,subTop,argX,y,1,1,0,c_white,0.75);
									}
								}
							}
						}
					}
				}
			}
			
			gpu_set_blendmode(bm_normal);
		}*/
	}
}
