/// @description Manipulating dimensions
event_inherited();

// Dimensional manipulation
if spawnButtons {
	#region
	
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
	
	with instance_create_layer(x,y,"Instances",obj_panel_buton_input_num) {
		label = "Minor Radius";
		
		sortIndex = 0;
		viewOn = 5;
		buttonType = 2;
		arbitraryVal = string(other.minorRadius / 20);
		valueLength = string_width(arbitraryVal)*2 + 4;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
		
		other.minorId = self.id;
	}
	with instance_create_layer(x,y,"Instances",obj_panel_buton_input_num) {
		label = "Major Radius";
		
		sortIndex = 1;
		viewOn = 5;
		buttonType = 2;
		arbitraryVal = string(other.majorRadius / 20);
		valueLength = string_width(arbitraryVal)*2 + 4;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
		
		other.majorId = self.id;
	}
	with instance_create_layer(x,y,"Instances",obj_panel_buton_input_num) {
		sortIndex = 2;
		viewOn = 5;
		label = "Threshold";
		buttonType = 2;
		arbitraryVal = string(other.thresholdRadius);
		valueLength = string_width(arbitraryVal)*2 + 4;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
		
		other.thresholdId = self.id;
	}
	with instance_create_layer(x,y,"Instances",obj_region_button_target) {
		label = "Target";
		
		sortIndex = 3;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(x,y,"Instances",obj_panel_buton_input_num) {
		label = "Zoom Percent";
		
		sortIndex = 4;
		viewOn = 5;
		buttonType = 2;
		arbitraryVal = string(other.zoomVal);
		valueLength = string_width(arbitraryVal)*2 + 4;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
		
		other.zoomId = self.id;
	}
	
	valueButtonsExist = true;
	
	event_user(0);
	
	#endregion
}

zcieling = zfloor;

if select {
	// These button instances couple to pass some values
	if valueButtonsExist {
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
		
		if instance_exists(zoomId) {
			if zoomId.arbitraryVal != "" {
				self.zoomVal = real(zoomId.arbitraryVal);
			} else {
				self.zoomVal = 100;
			}
		}
	}
	
	// Calculate ellipse
	x1 = x + 10 + lengthdir_x(minorRadius,0);
	x2 = x + 10 + lengthdir_x(minorRadius,180);
	y1 = y + 10 + lengthdir_y(majorRadius,90);
	y2 = y + 10 + lengthdir_y(majorRadius,270);
}
