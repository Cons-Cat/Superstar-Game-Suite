/// @description 
/*if obj_dialogue_region_interface.zfloor > 0 {
	if !collision_point(x,y+obj_dialogue_region_interface.zfloor*20,obj_editor_terrain,false,false) {
		draw_sprite_ext(spr_walk_region_revamp_shadow,0,x,y+obj_dialogue_region_interface.zfloor*20,1,1,0,c_white,0.8);
	} else {
		if y >= collision_point(x,y+obj_dialogue_region_interface.zfloor*20,obj_editor_terrain,false,false).y+obj_dialogue_region_interface.zfloor*20 - collision_point(x,y+obj_dialogue_region_interface.zfloor*20,obj_editor_terrain,false,false).height*20 {
			draw_sprite_ext(spr_walk_region_revamp_shadow,0,x,y+obj_dialogue_region_interface.zfloor*20-collision_point(x,y+obj_dialogue_region_interface.zfloor*20,obj_editor_terrain,false,false).zfloor*20,1,1,0,c_white,0.8);
		}
	}
}*/

draw_self();
