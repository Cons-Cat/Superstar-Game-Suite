/// @description 

// Draw edges
if vertexToId != -1 {
	for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
		vertexDrawId = instance_find(obj_trigger_vertex,i);
		
		if vertexDrawId.vertexId = self.vertexToId {
			if vertexDrawId.visible {
				draw_set_color(make_color_rgb(29,0,92)); // Dark purple
				draw_arrow(x-0.5,y-0.5,vertexDrawId.x-0.5,vertexDrawId.y-0.5,6);
				draw_line_width(x-0.5,y-0.5,vertexDrawId.x-0.5,vertexDrawId.y-0.5,1);
				
				break;
			}
		}
	}
}

draw_sprite(sprite_index,image_index,x,y - (zfloor * 20));
