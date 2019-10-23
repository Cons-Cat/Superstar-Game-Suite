/// @description 
draw_set_color(c_black);
draw_rectangle(leftQuarter,upQuarter,rightQuarter,downQuarter,false);

draw_set_color(c_red);
draw_rectangle(centerX,centerY,centerX,centerY,false);

draw_sprite(sprite_index,0,x,y);

draw_text(leftQuarter,downQuarter+10,placeZ);

/*if instance_exists(obj_player_overworld) {
	show_debug_message("accelZ: " + string(accelZ));
	show_debug_message("placeZ: " + string(floor(placeZ)));
	show_debug_message("jumpHeight: " + string(floor(obj_player_overworld.jumpHeight)));
	show_debug_message("onGround: " + string(obj_player_overworld.onGround));
	show_debug_message("");
}*/
