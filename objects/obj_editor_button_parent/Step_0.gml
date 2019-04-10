/// @description Deselection
mouseCheckX = obj_editor_gui.mouseCheckX;
mouseCheckY = obj_editor_gui.mouseCheckY;

if instance_exists(trg) {
	fromTxt = trg.str;
}

// Do not obstruct higher level interfaces
if canSelect {
	image_alpha = 1;
} else {
	image_alpha = 0.5;
}

// Release mouse to deselect
if !mouse_check_button(mb_left) && instance_exists(trg) {
	select = false;
	trg.buttonSelected = 0;
	col = c_white;
}

// Deselect terrain
if mouse_check_button_pressed(mb_left) {
	if !select {
		if window_view_mouse_get_x(1) > obj_panel_left.x && window_view_mouse_get_x(1) < obj_panel_right.x && window_view_mouse_get_y(1) > obj_panel_top.y && window_view_mouse_get_y(1) < obj_panel_bot.y {
			selfCanDeSelect = true;
			
			// Every exception case
			if (obj_editor_gui.mode = 4 && mouse_y <= obj_panel_bot.y) {
				if instance_exists(obj_region_button_vertex) {
					if obj_region_button_vertex.select {
						selfCanDeSelect = false;
					}
				}
				
				if instance_exists(obj_trigger_vertex) {
					// Consider zfloor passed into obj_region_button_edge from a selected obj_trigger_dialoge_region_editor instance
					if collision_rectangle(mouseCheckX-1,mouseCheckY-1+(obj_region_button_edge.zfloor*20),mouseCheckX+1,mouseCheckY+1+(obj_region_button_edge.zfloor*20),obj_trigger_vertex,false,false) {
						selfCanDeSelect = false;
					}
				}
				
				if instance_exists(obj_region_button_edge) {
					if obj_region_button_edge.select {
						selfCanDeSelect = false;
					}
				}
			}
			
			if selfCanDeSelect {
				alarm[0] = 2;
			}
		}
	}
}

if select {
	col = c_orange;
	
	if instance_exists(trg) {
		trg.buttonSelected = 1;
	}
}

visible = true;
canSelect = true;

if obj_editor_gui.mode = 4 { // Triggers mode
	if instance_exists(obj_cutscene_actor_getter_target_parent) {
		visible = false;
	} else {
		visible = true;
	}
}

