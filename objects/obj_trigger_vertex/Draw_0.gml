/// @description 
if zfloor > 0 {
	// Draw shadow
	gpu_set_fog(true,c_black,0,0);
	draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,0.65);
	gpu_set_fog(false,c_black,0,0);
}

// Draw edges
if vertexToId != -1 {
	for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
		vertexDrawId = instance_find(obj_trigger_vertex,i);
		
		if vertexDrawId.vertexId = self.vertexToId {
			if vertexDrawId.visible {
				draw_set_color(make_color_rgb(29,0,92)); // Dark purple
				draw_arrow(x-0.5,y-0.5 - (zfloor * 20),vertexDrawId.x-0.5,vertexDrawId.y-0.5 - (zfloor * 20),6);
				draw_line_width(x-0.5,y-0.5 - (zfloor * 20),vertexDrawId.x-0.5,vertexDrawId.y-0.5 - (zfloor * 20),1);
				
				break;
			}
		}
	}
}

draw_sprite(sprite_index,image_index,x,y - (zfloor * 20));
