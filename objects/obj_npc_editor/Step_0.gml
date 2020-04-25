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
	
	#endregion
}

// Trigger manipulation
if spawnTriggers {
	#region
	
	spawnTriggers = false;
	
	with instance_create_layer(x,y,"Instances",obj_actor_button_rotate) {
		label = "Rotation";
		sprite_index = spr_scene_rotate;
		
		trg = other.id;
		sortIndex = 0;
		viewOn = 2;
		panelId = obj_panel_left.id;
		sprWidth = (string_width(label) + 5) * 2;
		angle = trg.angle;
		calcAngleVals = true;
	}
	with instance_create_layer(x,y,"Instances",obj_actor_button_scene) {
		label = "Event 1";
		sprite_index = spr_editor_trigger_scene;
		
		trg = other.id;
		sortIndex = 1;
		viewOn = 2;
		panelId = obj_panel_left.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	
	scr_panel_calc(obj_panel_left.id);
	
	#endregion
}

// Generate angle interface
if placed = 1 {
	#region
	
	if instance_exists(obj_editor_gui) {
		if !instance_exists(obj_actor_rotate_target) {
			if obj_editor_gui.mode = 4 { // Trigger mode
				with instance_create_layer(x+10,y+10,"Instances",obj_actor_rotate_target) {
					trg = other.id;
					zfloor = other.zfloor;
					angle = other.angle;
					
					calcAngleVals = true;
					
					canPlace = true;
					canRelease = true;
					canDel = true;
				}
				
				placed = 2;
			}
		}
	}
	
	#endregion
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

// Overwrite inherited layerColor behavior
if orangeAnyways {
	layerColor = c_orange;
}

// Load cutscene information.
if select {
	if !trgGone {
		// Import data
		scr_import_cutscene(obj_panel_bot,self.id);
		
		if !instance_exists(obj_cutscene_actor_dummy_player) {
			// Generate stand-in for Minerva
			with instance_create_layer(x+30,y+10,"Instances",obj_cutscene_actor_dummy_player) {
				trg = other.id;
				zfloor = other.zfloor;
			}
		}
		
		trgGone = true;
	}
	
	if instance_exists(obj_region_button_edge) {
		obj_region_button_edge.trg = self.id; // This button instance couples itself to pass some values
	}
} else {
	trgGone = false;
}
