/// @description 
if zfloor > 0 {
	// Draw shadows
	gpu_set_fog(true,c_black,0,0);
	draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,0.65);
	
	if hasThreshold {
		draw_set_alpha(0.35)
		
		for (i = 0; i < ds_list_size(polygon); i += 6) {
			draw_triangle(ds_list_find_value(polygon,i)-0.5,ds_list_find_value(polygon,i+1)-0.5,ds_list_find_value(polygon,i+2)-0.5,ds_list_find_value(polygon,i+3)-0.5,ds_list_find_value(polygon,i+4)-0.5,ds_list_find_value(polygon,i+5)-0.5,false);
		}
		
		draw_set_alpha(1)
	}
	
	gpu_set_fog(false,c_black,0,0);
}

// Draw edges
if vertexToInd != -1 {
	for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
		vertexDrawId = instance_find(obj_trigger_vertex,i);
		
		if vertexDrawId.vertexInd = self.vertexToInd {
			if vertexDrawId.visible {
				draw_set_color(edgeCol);
				draw_arrow(x-0.5,y-0.5 - (zfloor * 20),vertexDrawId.x-0.5,vertexDrawId.y-0.5 - (zfloor * 20),6);
				draw_line_width(x-0.5,y-0.5 - (zfloor * 20),vertexDrawId.x-0.5,vertexDrawId.y-0.5 - (zfloor * 20),1);
				
				break;
			}
		}
	}
}

// Draw thresholds
if hasThreshold {
	if w > 0 {
		// Draw polygon
		draw_set_color(polygonCol);
		gpu_set_blendmode_ext(bm_dest_color, bm_zero); // Multiply blend mode
		
		for (i = 0; i < ds_list_size(polygon); i += 6) {
			draw_triangle(ds_list_find_value(polygon,i)-0.5,ds_list_find_value(polygon,i+1)-0.5-zfloor*20,ds_list_find_value(polygon,i+2)-0.5,ds_list_find_value(polygon,i+3)-0.5-zfloor*20,ds_list_find_value(polygon,i+4)-0.5,ds_list_find_value(polygon,i+5)-0.5-zfloor*20,false);
		}
		
		draw_set_color(edgeCol);
		gpu_set_blendmode(bm_normal);
		
		// Normal
		draw_line(edgeMidPointX,edgeMidPointY-zfloor*20,edgeMidPointX + thresholdX,edgeMidPointY + thresholdY-zfloor*20);
		
		// Girth line 1
		draw_line(edgeMidPointX + thresholdX, edgeMidPointY + thresholdY-zfloor*20, edgeMidPointX + thresholdX + girthX,edgeMidPointY + thresholdY + girthY-zfloor*20);
		draw_line(edgeMidPointX + thresholdX + girthX + lengthdir_x(5,normal), edgeMidPointY + thresholdY + girthY + lengthdir_y(5,normal)-zfloor*20,edgeMidPointX + thresholdX + girthX - lengthdir_x(5,normal), edgeMidPointY + thresholdY + girthY - lengthdir_y(5,normal)-zfloor*20);
		
		// Girth line 2
		draw_line(edgeMidPointX + thresholdX, edgeMidPointY + thresholdY-zfloor*20, edgeMidPointX + thresholdX - girthX,edgeMidPointY + thresholdY - girthY-zfloor*20);
		draw_line(edgeMidPointX + thresholdX - girthX + lengthdir_x(5,normal), edgeMidPointY + thresholdY - girthY + lengthdir_y(5,normal)-zfloor*20,edgeMidPointX + thresholdX - girthX - lengthdir_x(5,normal), edgeMidPointY + thresholdY - girthY - lengthdir_y(5,normal)-zfloor*20);
	}
}

draw_sprite(sprite_index,image_index,x,y - (zfloor * 20));
