/// @description Disable obstructing interface buttons
if visible {
	if instance_exists(obj_editor_button_parent) {
		if collision_rectangle(relativeMouseX-1,relativeMouseY-1 + (self.zfloor * 20),relativeMouseX+1,relativeMouseY+1 + (self.zfloor * 20),obj_trigger_vertex,false,false) {
			with obj_editor_button_parent {
				if !select {
					canSelect = false;
					obj_cutscene_actor_dummy_lucy.canSelect = false;
				}
			}
		}
	}
}
