/// @description 
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
	
	with instance_create_layer(x,y,"Instances",obj_actor_button_rotate) {
		trg = other.id;
		sortIndex = 0;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
		sprWidth = (string_width(label) + 5) * 2;
		angle = other.angle;
	}
	
	#endregion
}

// Generate angle interface
if placed = 1 {
	if instance_exists(obj_editor_gui) {
		if !instance_exists(obj_cutscene_rotate_target) {
			if obj_editor_gui.mode = 4 { // Trigger mode
				with instance_create_layer(x,y,"Instances",obj_cutscene_rotate_target) {
					trg = other.id;
					zfloor = other.zfloor;
					angle = 0;
					
					calcAngleVals = true;
					
					originX[0] = x + 10;
					originY[0] = y + 10;
					
					canPlace = true;
					canDel = true;
					canRelease = true;
				}
				
				placed = 2;
			}
		}
	}
}

// Find relevant floor object
trgFinalTemp = 0;

for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
	trgScr = instance_find(obj_editor_terrain,i).id;
	
	if trgScr.zfloor*20 <= self.zfloor*20 {
		if collision_point(x,y,trgScr,true,true) {
			trgLayer[i] = trgScr.zfloor;
			
			for (a = 0; a <= i; a += 1) {
				if trgLayer[a] >= trgFinalTemp {
					trgFinal = trgScr;
					trgFinalTemp = trgLayer[a];
				}
			}
			
			platOn = trgFinal.zfloor*20;
		}
	}
}

if instance_exists(trgFinal) {
	if trgFinal.zfloor = self.zfloor {
		fallSearch = false; // Cancel fall if standing on a platform
		onGround = true;
	}
}

zcieling = zfloor;

if orangeAnyways {
	layerColor = c_orange;
}
