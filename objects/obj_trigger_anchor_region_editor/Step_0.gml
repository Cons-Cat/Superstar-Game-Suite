/// @description Manipulating dimensions
event_inherited();

// Dimensional manipulation
if spawnButtons {
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z3) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	
	/*with instance_create_layer(x,y,"Instances",obj_region_button_angle) {
		sortIndex = 0;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
		trg = other.id;
	}*/
	with instance_create_layer(x,y,"Instances",obj_subpanel_button) {
		sortIndex = 0;
		viewOn = 5;
		label = "Minor Radius";
		buttonType = 2;
		arbitraryVal = string(other.minorRadius / 20);
		valueLength = string_width(arbitraryVal)*2 + 4;
		other.minorId = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_subpanel_button) {
		sortIndex = 1;
		viewOn = 5;
		label = "Major Radius";
		buttonType = 2;
		arbitraryVal = string(other.majorRadius / 20);
		valueLength = string_width(arbitraryVal)*2 + 4;
		other.majorId = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_subpanel_button) {
		sortIndex = 2;
		viewOn = 5;
		label = "Threshold Radius";
		buttonType = 2;
		arbitraryVal = string(other.thresholdRadius);
		valueLength = string_width(arbitraryVal)*2 + 4;
		other.thresholdId = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_region_button_target) {
		sortIndex = 3;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
		trg = other.id;
	}
	
	obj_subpanel_left.tempY = obj_subpanel_left.y;
	obj_subpanel_left.moveDirection = 1;
	obj_subpanel_left.moveToY = obj_panel_bot.y;
	obj_subpanel_left.moveToSpd = (obj_panel_bot.y - obj_subpanel_left.y)/6.5;
	
	// Standard formula to solve for time, given speed and distance
	// +5 is a pause to dramatize the motion
	obj_subpanel_left.alarm[1] = abs(obj_panel_bot.y - obj_subpanel_left.y) / obj_subpanel_left.moveToSpd + 5;
	
	// Fix issues when the sub-panel is folded
	if obj_subpanel_left.y >= obj_panel_bot.y {
		obj_subpanel_left.tempY = -1;
	}
}

zcieling = zfloor;

if select {
	// These button instances couple to pass some values
	if instance_exists(majorId) {
		if majorId.arbitraryVal != "" {
			self.majorRadius = real(majorId.arbitraryVal)*20
		} else {
			self.majorRadius = 0;
		}
	}
	
	if instance_exists(minorId) {
		if minorId.arbitraryVal != "" {
			self.minorRadius = real(minorId.arbitraryVal)*20;
		} else {
			self.minorRadius = 0;
		}
	}
	
	if instance_exists(thresholdId) {
		if thresholdId.arbitraryVal != "" {
			self.thresholdRadius = real(thresholdId.arbitraryVal);
		} else {
			self.thresholdRadius = 0;
		}
	}
	
	// Calculate ellipse
	x1 = x + 10 + lengthdir_x(minorRadius,0);
	x2 = x + 10 + lengthdir_x(minorRadius,180);
	y1 = y + 10 + lengthdir_y(majorRadius,90);
	y2 = y + 10 + lengthdir_y(majorRadius,270);
}
