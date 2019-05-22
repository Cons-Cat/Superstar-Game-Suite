/// @description Define edges between vertices
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

//with obj_trigger_vertex {
//	if !mouse_check_button(mb_left) {
//		if edgeState = 1 || !other.select {
//			// Un-highlight un-selected vertices
//			edgeState = 0;
//		}
//	}
//}

if instance_exists(trg) {
	zfloor = trg.zfloor;
}

if select {
	// If an edge is selected
	// Consider zfloor passed in from a selected obj_trigger_region_editor instance
	if mouse_check_button_pressed(mb_left) {
		if edgeSelectVertex != -1 {
			edgeSelectVertex.hasThreshold = true;
		} else {
			canRelease = true;
		}
	}
	
	if edgeSelectVertex != -1 {
		edgeSelectVertex.recalculate= true;
	}
}

event_inherited();
