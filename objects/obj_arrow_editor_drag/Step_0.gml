/// @description 
event_inherited();

// Selecting
if mouseCheckX >= bbox_left && mouseCheckX <= bbox_right && mouseCheckY >= bbox_top && mouseCheckY <= bbox_bottom {
	if visible {
		if mouse_check_button_pressed(mb_left) {
			if canSelect {
				select = true;
			}
		}
	}
}

// Dragging terrain
if instance_exists(trg) {
	if select {
		x = (mouseCheckX div global.snapDimension) * global.snapDimension;
		y = (mouseCheckY div global.snapDimension) * global.snapDimension;
		
		trg.x = self.x;
		trg.y = self.y;
		
		// Update minimap
		if trg.lastX != trg.x || trg.lastY != trg.y {
			with trg {
				scr_editor_map(lastX,lastY,lastX+width*20,lastY+(height+zfloor-zcieling)*20);
				scr_editor_map(x,y,x+width*20,y+(height+zfloor-zcieling)*20);
			}
			
			trg.lastX = x;
			trg.lastY = y;
		}
	}
}
