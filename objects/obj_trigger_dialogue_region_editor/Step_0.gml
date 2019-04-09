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
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_right) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_left) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_region_button_vertex) {
		sortIndex = 0;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
	}
	with instance_create_layer(x,y,"Instances",obj_region_button_edge) {
		sortIndex = 1;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
	}
}

zcieling = zfloor;

if select {
	if !trgGone {
		// Import metadata
		importCutscene(obj_panel_bot,self.id);
		
		if !instance_exists(obj_cutscene_actor_dummy_lucy) {
			// Generate stand-in for Minerva
			with instance_create_layer(x+10,y+10,"Instances",obj_cutscene_actor_dummy_lucy) {
				trg = other.id;
				zfloor = other.zfloor;
			}
		}
		
		trgGone = true;
	}
	
	// Create ds_list from ordered pairs of vertex co-ordinats
	if recalculate {
		recalculate = false;
		vectorCount = 0;
		
		if instance_exists(obj_trigger_vertex) { // 0 vertices broke this system
			broken = false;
		}
		
		for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
			if instance_find(obj_trigger_vertex,i).trg = self.id {
				vectorCount += 1;
				
				if instance_find(obj_trigger_vertex,i).vertexToId = -1 { // If the polygon is broken
					broken = true;
				}
			}
		}
		
		if vectorCount < 3 {
			// If the polygon is a single line
			broken = true;
		}
		
		if !broken {
			ds_list_clear(list); // Reset the list
			
			i = 0;
			while i < vertexCount { // Iterate through the number of active vertices
				for (j = 0; j < vertexCount; j += 1) { // Iterate through every existent vertex
					if instance_find(obj_trigger_vertex,j).trg = self.id { // Reduce to exclusively active vertices
						if instance_find(obj_trigger_vertex,j).vertexId = i + 1 { // Check if this is the vertex next in order
							ds_list_add(list,vertexInstanceId[j+1].x);
							ds_list_add(list,vertexInstanceId[j+1].y);
							
							i += 1;
						}
					}
				}
			}
			
			// Generate list of right triangles
			polygon = scr_polygon_to_triangles(list);
		}
	}
} else {
	trgGone = false;
}
