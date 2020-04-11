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

if instance_exists(trg) {
	zfloor = trg.zfloor;
}

if select {
	// If the mouse hovers over a vertex
	// Consider zfloor passed in from a selected obj_trigger_region_editor instance
	if vertexTempHover != -1 {
		if mouse_check_button_pressed(mb_left) {
			vertexTempSelect = vertexTempHover;
		}
		
		if vertexTempSelect = vertexTempHover {
			vertexTempSelect.edgeState = 2;
		}
		
		if mouse_check_button_pressed(mb_left) {
			if vertexTempSelect.edgeState != 2 { // If the vertex is not selected
				vertexTempSelect.edgeState = 2;
			}
		}
		
		if mouse_check_button_released(mb_left) {
			for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
				if instance_find(obj_trigger_vertex,i).edgeState = 2 {
					vertexSelectedCount += 1;
					vertexConnect[vertexSelectedCount] = vertexTempHover.id;
					vertexTempSelect = -1;
				}
				
				if vertexSelectedCount = 2 {
					obj_trigger_vertex.edgeState = 0;
					
					if vertexConnect[2].vertexInd != vertexConnect[1].vertexInd { // Ensure these are different vertices
						vertexConnect[1].vertexToInd = vertexConnect[2].vertexInd;
						vertexConnect[1].vertexToId = -1; // Reset line id
						vertexSelectedCount = 0;
						
						obj_trigger_region_parent.recalculate = true; // Recalculate polygon
					} else {
						vertexSelectedCount = 0;
					}
					
					break;
				}
			}
		}
		
		if vertexTempHover.edgeState = 0 {
			vertexTempHover.edgeState = 1; // Hover over vertex
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
			vertexSelectedCount = 0;
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

event_inherited();

if select {
	obj_editor_button_parent.visible = false;
}
