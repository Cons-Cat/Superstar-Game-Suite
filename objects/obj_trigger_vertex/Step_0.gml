///@description Manipulate placement
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

if canDragDelayed {
	if trg != -1 {
		if instance_exists(trg) {
			zfloor = trg.zfloor;
			
			if trg.select {
				canDrag = true;
				visible = true;
				
				if instance_exists(obj_region_button_edge) {
					if obj_region_button_edge.select {
						// Prevent dragging while placing edges
						canDrag = false;
					}
					
					// Select
					if mouse_y < obj_panel_bot.y {
						if relativeMouseX >= bbox_left && relativeMouseX <= bbox_right {
							if (relativeMouseY >= bbox_top - (zfloor * 20) && relativeMouseY <= bbox_bottom - (zfloor * 20)) {
								obj_region_button_edge.vertexTempHover = self.id;
								
								if mouse_check_button_pressed(mb_left) {
									if canDrag {
										canPlace = true;
									}
								}
							}
						}
					}
				}
				
				// De-select
				if (mouse_check_button_released(mb_left)) {
					canDrag = true;
					canPlace = false;
				}
				
				// Keep position relative to trg
				if canPlace {
					trgXOff = x - trg.x;
					trgYOff = y - (trg.y + trg.zfloor*20) ;
				} else {
					x = trg.x + trgXOff;
					y = trg.y + trgYOff + trg.zfloor * 20;
					
					// Update trg recursively while it is selected
					trg.recalculate = true;
				}
				
				if vertexToInd != -1 {
					if vertexToId = -1 {
						with obj_trigger_vertex {
							if vertexInd = other.vertexToInd {
								other.vertexToId = self.id;
								
								break;
							}
						}
					}
					
					// Hover over edge
					edgeHover = false;
					edgeMidPointX = x + lengthdir_x(point_distance(x,y,vertexToId.x,vertexToId.y),point_direction(x,y,vertexToId.x,vertexToId.y))/2;
					edgeMidPointY = y + lengthdir_y(point_distance(x,y,vertexToId.x,vertexToId.y),point_direction(x,y,vertexToId.x,vertexToId.y))/2;
					
					if scr_lines_intersect(x,y-zfloor*20,vertexToId.x,vertexToId.y-zfloor*20,relativeMouseX-3,relativeMouseY-3,relativeMouseX+3,relativeMouseY+3,true) != 0 || scr_lines_intersect(x,y-zfloor*20,vertexToId.x,vertexToId.y-zfloor*20,relativeMouseX+3,relativeMouseY-3,relativeMouseX-3,relativeMouseY+3,true) != 0 {
						if !collision_rectangle(relativeMouseX-1,relativeMouseY-1 + (self.zfloor * 20),relativeMouseX+1,relativeMouseY+1 + (self.zfloor * 20),obj_trigger_vertex,false,false) { // Prevent interference with deleting vertices
							if instance_exists(obj_region_button_edge) {
								if !obj_region_button_edge.select && !mouse_check_button(mb_left) { // If not added edges or dragging vertices
									edgeHover = true;
									
									with obj_trigger_vertex {
										if vertexInd != other.vertexInd { // Exclude source vertex
											edgeHover = false; // Prevent multiple edges from being selected
										}
									}
								}
							}
						}
						
						// Enable threshold
						if mouse_check_button_pressed(mb_left) {
							if instance_exists(obj_region_button_threshold) {
								if obj_region_button_threshold.select {
									obj_region_button_threshold.edgeSelectVertex = self.id;
									hasThreshold = true;
									edgeSelect = true; // Select edge
								}
							}
						}
					} else {
						// De-select edge
						if mouse_check_button_released(mb_left) {
							if edgeSelect {
								if w <= 0 {
									hasThreshold = false;
								}
								
								obj_region_button_threshold.edgeSelectVertex = -1;
							}
							
							edgeSelect = false;
						}
					}
				}
				
				// Delete edge
				if mouse_check_button_pressed(mb_right) {
					if edgeHover {
						edgeDeleteState = 1;
						hasThreshold = false;
					}
				}
				
				if mouse_check_button_released(mb_right) {
					if edgeHover {
						if edgeDeleteState = 1 {
							vertexToInd = -1; // Dissolve edge
							trg.recalculate = true; // Recalculate polygon
						}
					}
					
					edgeDeleteState = 0;
				}
			} else {
				// De-activate when trg is not selected
				canDrag = false;
				visible = false;
			}
		} else {
			// De-couple instance from trg
			trg = -1;
		}
	} else {
		// Impell stasis when deleted
		canDrag = false;
		canPlace = false
		
		visible = false;
	}
}

// Dragging
if canPlace {
	image_index = 1;
	
	if mouse_y < obj_panel_bot.y {
		x = floor((relativeMouseX + mouseXOff)/5)*5;
		y = floor((relativeMouseY + (zfloor * 20) + mouseYOff)/5)*5 + 1;
	}
} else {
	image_index = 0;
}

// Delete vertex
if relativeMouseX >= bbox_left && relativeMouseX <= bbox_right && relativeMouseY + zfloor*20 >= bbox_top && relativeMouseY + zfloor*20 <= bbox_bottom {
	if visible {
		if deleting {
			image_index = 1;
		}
		
		if mouse_check_button_pressed(mb_right) {
			deleting = true;
		}
		if mouse_check_button_released(mb_right) {
			// De-couple instance
			with obj_trigger_vertex {
				if vertexToInd = other.vertexInd {
					vertexToInd = -1;
				}
			}
			
			trg.broken = true;
			trg.recalculate = true;
			
			trg = -1;
		}
	}
}

if mouse_check_button_released(mb_right) {
	deleting = false;
}

// Highlight during edge editing
if edgeState = 1 {
	image_index = 2;
}
if edgeState = 2 {
	image_index = 3;
}

// Highlight edge if hovered upon
if edgeHover || edgeDeleteState = 1 || edgeSelect {
	edgeCol = c_yellow;
} else {
	edgeCol = edgeColTemp;
}

// Defining threshold
if x != tempX || y != tempY {
	tempX = x;
	tempY = y;
	
	recalculate = true;
	vertexToId.recalculate = true;
	
	with obj_trigger_vertex {
		if vertexToId = other.id {
			recalculate = true;
		}
	}
}

if recalculate || recalculate2 {
	show_debug_message(vertexToInd);
	recalculate = false;
	
	if hasThreshold {
		if recalculate2 {
			recalculate2 = false;
		} else {
			// Prevent updating from falling one timestep behind
			recalculate2 = true;
		}
		
		ds_list_clear(list);
		normal = (point_direction(x,y,vertexToId.x,vertexToId.y) - 90);
		
		if edgeSelect {
			relativeMouseX = floor(obj_editor_gui.mouseCheckX/5)*5;
			relativeMouseY = floor(obj_editor_gui.mouseCheckY/5)*5;
			girth = tempGirth;
			theta = normal - (point_direction(edgeMidPointX,edgeMidPointY,relativeMouseX,relativeMouseY) );
			
			if theta < 0 {
				theta += 360;
			}
			
			c = point_distance(edgeMidPointX,edgeMidPointY,relativeMouseX,relativeMouseY);
			w = cos(degtorad(theta)) * c;
			
			if w < 0 {
				w = 0;
			}
			
			girth = point_distance(edgeMidPointX + thresholdX, edgeMidPointY + thresholdY,relativeMouseX,relativeMouseY);
			
			if girth < point_distance(x,y,vertexToId.x,vertexToId.y)/2 {
				girth = point_distance(x,y,vertexToId.x,vertexToId.y)/2;
			}
			
			tempGirth = girth;
		}
		
		if girth > tempGirth {
			girth = tempGirth;
		}
		if girth < point_distance(x,y,vertexToId.x,vertexToId.y)/2 {
			girth = point_distance(x,y,vertexToId.x,vertexToId.y)/2;
		}
		
		thresholdX = lengthdir_x(w,point_direction(x,y,vertexToId.x,vertexToId.y) - 90);
		thresholdY = lengthdir_y(w,point_direction(x,y,vertexToId.x,vertexToId.y) - 90);
		
		girthX = lengthdir_x(girth,point_direction(x,y,vertexToId.x,vertexToId.y));
		girthY = lengthdir_y(girth,point_direction(x,y,vertexToId.x,vertexToId.y));
		
		// Create polygon
		if w > 0 {
			ds_list_add(list,x,y);
			ds_list_add(list,edgeMidPointX + thresholdX - girthX,edgeMidPointY + thresholdY - girthY);
			ds_list_add(list,edgeMidPointX + thresholdX + girthX,edgeMidPointY + thresholdY + girthY);
			ds_list_add(list,vertexToId.x,vertexToId.y);
			polygon = scr_polygon_to_triangles(list);
		}
	}
}
