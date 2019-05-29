/// @description Disable obstructing interface buttons
if visible {
	if trg != -1 {
		if instance_exists(obj_editor_button_parent) {
			if collision_rectangle(relativeMouseX-1,relativeMouseY-1 + (self.zfloor * 20),relativeMouseX-1,relativeMouseY-1 + (self.zfloor * 20),self.id,false,false) {
				with obj_editor_button_parent {
					if !select {
						canSelect = false;
					}
				}
			}
		}
	}
}
