/// @description 
draw_sprite(sprite_index,image_index,x,y - (zfloor * 20));
draw_set_color(c_black);

// Draw edges
if vertexToId != -1 {
	for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
		vertexDrawId = instance_find(obj_trigger_vertex,i);
		
		if vertexDrawId.vertexId = self.vertexToId {
			if vertexDrawId.visible {
				draw_arrow(x,y,vertexDrawId.x,vertexDrawId.y,5);
				break;
			}
		}
	}
}
