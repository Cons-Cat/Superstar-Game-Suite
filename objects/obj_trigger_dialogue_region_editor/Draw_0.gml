/// @description Draw region
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode = 4 {
		// Draw Shadow
		gpu_set_blendmode(bm_inv_src_color);
		
		for (i = 0; i < width; i += 1) {
			for (j = 0; j < height; j += 1) {
				if zfloor > 0 {
					//draw_sprite_ext(spr_shadow_editor,0,x+i*20,y+j*20+zfloor*20,1,1,0,c_white,0.8);
					if angleVal = 0 {
						draw_sprite_ext(spr_shadow_editor,0,x+10+i*20,y+10+j*20+zfloor*20,1,1,0,c_white,0.8);
					}
					if angleVal = 1 {
						draw_sprite_ext(spr_shadow_editor,0,x+14+i*17,y+7+j*20-i*11+zfloor*20,1,1,33,c_white,0.8);
					}
					if angleVal = 2 {
						draw_sprite_ext(spr_shadow_editor,0,x+14+i*14,y+6+j*20-i*14+zfloor*20,1,1,45,c_white,0.8);
					}
					if angleVal = 3 {
						draw_sprite_ext(spr_shadow_editor,0,x+13+i*8,y+7+j*20-i*18+zfloor*20,1,1,66,c_white,0.8);
					}
					if angleVal = 4 {
						draw_sprite_ext(spr_shadow_editor,0,x+10,y+10+j*20-i*20+zfloor*20,1,1,0,c_white,0.8);
					}
				}
			}
		}
		
		gpu_set_blendmode(bm_normal);
		
		for (i = 0; i < width; i += 1) {
			for (j = 0; j < height; j += 1) {
				/*if collision_point(x+i*20,y+j*20+zfloor*20,obj_editor_terrain_par,false,true) {
					trgDraw = collision_point(x+i*20,y+j*20+zfloor*20,obj_editor_terrain_par,false,true).id;
				}
				
				if trgDraw.zfloor >= self.zfloor && trgDraw.zcieling <= self.zcieling && trgDraw.x <= self.x && trgDraw.x+trgDraw.width*20 >= self.x+self.width*20 {
					draw_sprite_ext(spr_trigger_region,0,x+i*20,y+j*20,1,1,0,layerColor,0.7);
				} else {
					draw_sprite_ext(spr_trigger_region,1,x+i*20,y+j*20,1,1,0,layerColor,0.9);
				}
				
				trgDraw = self.id;*/
				if angleVal = 0 {
					draw_sprite_ext(spr_trigger_region,0,x+10+i*20,y+10+j*20,1,1,0,layerColor,0.7);
				}
				if angleVal = 1 {
					draw_sprite_ext(spr_trigger_region,0,x+14+i*17,y+7+j*20-i*11,1,1,33,layerColor,0.7);
				}
				if angleVal = 2 {
					draw_sprite_ext(spr_trigger_region,0,x+14+i*14,y+6+j*20-i*14,1,1,45,layerColor,0.7);
				}
				if angleVal = 3 {
					draw_sprite_ext(spr_trigger_region,0,x+13+i*8,y+7+j*20-i*18,1,1,66,layerColor,0.7);
				}
				if angleVal = 4 {
					draw_sprite_ext(spr_trigger_region,0,x+10,y+10+j*20-i*20,1,1,0,layerColor,0.7);
				}
			}
		}
	}
}
