/// @description Disable obstructing interface buttons
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

if visible {
	if trg != -1 {
		if instance_exists(obj_editor_button_parent) {
			if collision_rectangle(relativeMouseX-1,relativeMouseY-1 + (self.zfloor * 20),relativeMouseX-1,relativeMouseY-1 + (self.zfloor * 20),self.id,false,false) {
				with obj_editor_button_parent {
					if !select {
						canSelect = false;
						
						if instance_exists(obj_cutscene_actor_dummy_lucy) {
							obj_cutscene_actor_dummy_lucy.canSelect = false;
						}
					}
				}
			}
		}
	}
}
