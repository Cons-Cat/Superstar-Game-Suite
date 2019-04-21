///@description Manipulate placement
relativeMouseX = floor((mouse_x + 195 - 23) / 10) * 5 - 80 + floor(camera_get_view_x(obj_editor_gui.cameraRealGame)/20)*20;
relativeMouseY = floor((mouse_y + 576) / 10) * 5 - 320 + 41 + floor(camera_get_view_y(obj_editor_gui.cameraRealGame)/20)*20;

if canDragDelayed {
	if trg != -1 {
		if instance_exists(trg) {
			zfloor = trg.zfloor;
			
			if trg.select {
				canDrag = true;
				visible = true;
				
				if obj_region_button_edge.select {
					// Prevent dragging while placing edges
					canDrag = false;
				}
				
				// Select
				if mouse_y < obj_panel_bot.y {
					if relativeMouseX >= self.x-5 && relativeMouseX <= self.x+5 {
						if (relativeMouseY >= self.y-4 - (zfloor * 20) && relativeMouseY <= self.y+5 - (zfloor * 20)) {
							obj_region_button_edge.vertexTempHover = self.id;
							
							if mouse_check_button_pressed(mb_left) {
								if canDrag {
									canPlace = true;
								}
							}
						}
					}
				}
				
				// De-select
				if (mouse_check_button_released(mb_left)) {
					if canPlace {
						trg.recalculate = true;
					}
					
					canDrag = true;
					canPlace = false;
				}
				
				// Keep position relative to trg
				if canPlace {
					trgXOff = x - trg.x;
					trgYOff = y - (trg.y + trg.zfloor*20);
				} else {
					x = trg.x + trgXOff;
					y = trg.y + trgYOff + trg.zfloor * 20;
					
					trg.recalculate = true;
				}
				
				// Hover over edge
				if vertexToInd != -1 {
					if vertexToId = -1 {
						with obj_trigger_vertex {
							if vertexInd = other.vertexToInd {
								other.vertexToId = self.id;
								
								break;
							}
						}
					}
					
					edgeHover = false;
					
					if !collision_rectangle(relativeMouseX-1,relativeMouseY-1 + (self.zfloor * 20),relativeMouseX+1,relativeMouseY+1 + (self.zfloor * 20),obj_trigger_vertex,false,false) { // Prevent interference with deleting vertices
						if !obj_region_button_edge.select && !mouse_check_button(mb_left) { // If not added edges or dragging vertices
							if scr_lines_intersect(x,y-zfloor*20,vertexToId.x,vertexToId.y-zfloor*20,relativeMouseX-3,relativeMouseY-3,relativeMouseX+3,relativeMouseY+3,true) != 0 || scr_lines_intersect(x,y-zfloor*20,vertexToId.x,vertexToId.y-zfloor*20,relativeMouseX+3,relativeMouseY-3,relativeMouseX-3,relativeMouseY+3,true) != 0 {
								edgeHover = true;
								
								with obj_trigger_vertex {
									if vertexInd != other.vertexInd { // Exclude source vertex
										edgeHover = false; // Prevent multiple edges from being selected
									}
								}
							}
						}
					}
				}
				
				// Delete edge
				if mouse_check_button_pressed(mb_right) {
					if edgeHover {
						edgeDeleteState = 1;
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
		x = relativeMouseX;
		y = relativeMouseY + (zfloor * 20);
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
if edgeHover || edgeDeleteState = 1 {
	edgeCol = c_yellow;
} else {
	edgeCol = make_color_rgb(29,0,92); // Dark purple
}
