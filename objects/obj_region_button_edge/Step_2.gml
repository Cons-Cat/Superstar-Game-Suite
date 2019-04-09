/// @description Define edges between vertices
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

with obj_trigger_vertex {
	if !mouse_check_button(mb_left) {
		if edgeState = 1 || !other.select {
			// Un-highlight un-selected vertices
			edgeState = 0;
		}
	}
}

if select {
	if collision_rectangle(relativeMouseX-1,relativeMouseY-1,relativeMouseX+1,relativeMouseY+1,obj_trigger_vertex,false,false) {
		vertexTempHover = collision_rectangle(relativeMouseX-1,relativeMouseY-1,relativeMouseX+1,relativeMouseY+1,obj_trigger_vertex,false,false);
		
		if mouse_check_button_pressed(mb_left) {
			vertexTempSelect = vertexTempHover;
		}
		
		if vertexTempSelect = vertexTempHover {
			vertexTempSelect.edgeState = 2;
		}
		
		if mouse_check_button_pressed(mb_left) {
			if vertexTempSelect.visible { // If the vertex is active
				if vertexTempSelect.edgeState != 2 { // If the vertex is not selected
					vertexTempSelect.edgeState = 2;
				}
			}
		}
		
		if mouse_check_button_released(mb_left) {
			for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
				if instance_find(obj_trigger_vertex,i).edgeState = 2 {
					vertexSelectedCount += 1;
					vertexConnect[vertexSelectedCount] = vertexTempSelect.id;
					vertexTempSelect = -1;
				}
				
				if vertexSelectedCount = 2 {
					obj_trigger_vertex.edgeState = 0;
					
					vertexConnect[1].vertexToId = vertexConnect[2].vertexId;
					vertexSelectedCount = 0;
					
					obj_trigger_dialogue_region_editor.recalculate = true; // Recalculate polygon
					
					break;
				}
			}
		}
		
		if vertexTempSelect = -1 {
			if vertexTempHover.edgeState = 0 {
				vertexTempHover.edgeState = 1; // Hover over vertex
			}
		}
	} else {
		if mouse_check_button(mb_left) {
			if vertexTempSelect != -1 {
				if vertexTempSelect.edgeState = 2 {
					vertexTempSelect.edgeState = 1;
				}
			}
		}
		
		if mouse_check_button_released(mb_left) {
			vertexTempSelect = -1;
		}
		
		if mouse_check_button_pressed(mb_left) {
			if vertexTempSelect = -1 {
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
			} else {
				vertexTempSelect = -1;
				vertexSelectedCount = 0;
				obj_trigger_vertex.select = false;
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
