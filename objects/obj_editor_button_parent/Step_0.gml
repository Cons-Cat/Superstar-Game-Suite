/// @description De-selection
mouseCheckX = obj_editor_gui.mouseCheckX;
mouseCheckY = obj_editor_gui.mouseCheckY;

// Do not obstruct higher level interfaces
if canSelect {
	// canSelect determined by obj_trigger_vertex
	image_alpha = 1;
} else {
	image_alpha = 0.5;
}

// Release mouse to de-select
if !mouse_check_button(mb_left) && instance_exists(trg) {
	select = false;
	trg.buttonSelected = false;
	col = c_white;
}

// De-select terrain
if mouse_check_button_pressed(mb_left) {
	#region
	
	if !select {
		if window_view_mouse_get_x(1) > obj_panel_left.x && window_view_mouse_get_x(1) < obj_panel_right.x && window_view_mouse_get_y(1) > obj_panel_top.y && window_view_mouse_get_y(1) < obj_panel_bot.y {
			selfCanDeSelect = true;
			
			// Every exception case
			if instance_exists(obj_trigger_widget_parent) {
				if obj_trigger_widget_parent.mouseHover {
				//if collision_rectangle(mouseCheckX-1,mouseCheckY-1+(obj_trigger_widget_parent.zfloor*20),mouseCheckX+1,mouseCheckY+1+(obj_trigger_widget_parent.zfloor*20),obj_trigger_widget_parent,false,false) {
					selfCanDeSelect = false;
				}
			}
				
				if instance_exists(obj_panel_button) {
					for (i = 0; i < instance_number(obj_panel_button); i++) {
						var buttonInst = instance_find(obj_panel_button,i)
						
						if buttonInst.trg = self.trg {
							if buttonInst.select {
								selfCanDeSelect = false;
							
								break;
							}
						}
					}
				//}
			}
			
			if selfCanDeSelect {
				alarm[0] = 2;
			}
		}
	}
	
	#endregion
}

if select {
	col = c_orange;
	
	if instance_exists(trg) {
		trg.buttonSelected = true;
		trg.collMask = -1;
	}
}

if obj_editor_gui.mode = 4 { // Triggers mode
	if instance_exists(obj_trigger_widget_parent) {
		visible = false;
	} else {
		visible = true;
	}
}
