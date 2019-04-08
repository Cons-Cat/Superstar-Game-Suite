/// @description Define edges between vertices
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

with obj_trigger_vertex {
	if edgeState = 1 || !other.select {
		// Un-highlight un-selected vertices
		edgeState = 0;
	}
}

if select {
	if collision_rectangle(relativeMouseX-1,relativeMouseY-1,relativeMouseX+1,relativeMouseY+1,obj_trigger_vertex,false,false) {
		vertexTemp = collision_rectangle(relativeMouseX-2,relativeMouseY-2,relativeMouseX+2,relativeMouseY+2,obj_trigger_vertex,false,false);
		
		if mouse_check_button_pressed(mb_left) {
			if vertexTemp.visible { // If the vertex is active
				if vertexTemp.edgeState != 2 { // If the vertex is not selected
					vertexTemp.edgeState = 2;
					
					for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
						if instance_find(obj_trigger_vertex,i).edgeState = 2 {
							vertexSelectedCount += 1;
							vertexConnect[vertexSelectedCount] = vertexTemp.id;
						}
						
						if vertexSelectedCount = 2 {
							obj_trigger_vertex.edgeState = 0;
							
							vertexConnect[1].vertexToId = vertexConnect[2].vertexId;
							vertexSelectedCount = 0;
							
							obj_trigger_dialogue_region_editor.recalculate = true; // Recalculate polygon
							
							break;
						}
					}
				} else {
					vertexTemp.edgeState = 1; // Deselect vertex
					vertexSelectedCount -= 1;
				}
			}
		}
		
		if vertexTemp.edgeState = 0 {
			vertexTemp.edgeState = 1; // Hover over vertex
		}
	} else {
		if mouse_check_button_pressed(mb_left) {
			for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
				if instance_find(obj_trigger_vertex,i).edgeState = 2 {
					break;
				}
				
				if i = instance_number(obj_trigger_vertex) - 1 {
					select = false;
					canRelease = true;
				}
			}
			
			with obj_trigger_vertex {
				// Cancel intent
				edgeState = 0;
				other.vertexSelectedCount = 0;
			}
		}
	}
}

with obj_trigger_vertex {
	if edgeState = 2 {
		// Keep this button selected when in use
		other.select = true;
	}
}

event_inherited();
