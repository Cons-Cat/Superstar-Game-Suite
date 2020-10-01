/// scr_array_xy( x1, y1, x2, y2, wipeId )
function scr_editor_map() {

	var x1 = argument[0];
	var x2 = argument[2];
	var y1 = argument[1];
	var y2 = argument[3];
	var wipeId = argument[4];

	if !surface_exists(obj_panel_bot.mapSurface) {
		exit;
	}

	var trg;
	var surf = surface_create(obj_panel_bot.mapWidth,obj_panel_bot.mapHeight);
	var tempDepth = 1;
	var depthsCounted = 0;
	var instCountSize = 0;
	var instCountId;
	var instCounted;
	var instSortedId;
	var tempInstInd;

	// Pass old surface in
	surface_copy(surf,0,0,obj_panel_bot.mapSurface)

	// Clear area
	gpu_set_blendmode(bm_subtract);
	draw_set_color(c_white);

	surface_set_target(obj_panel_bot.mapSurface);
	draw_rectangle( x1 *  (obj_panel_bot.mapWidth/room_width),y1 * (obj_panel_bot.mapHeight/room_height),x2 * (obj_panel_bot.mapWidth/room_width),y2 * (obj_panel_bot.mapHeight/room_height),false )
	surface_reset_target();

	surface_set_target(surf);
	draw_rectangle( x1 *  (obj_panel_bot.mapWidth/room_width),y1 * (obj_panel_bot.mapHeight/room_height),x2 * (obj_panel_bot.mapWidth/room_width),y2 * (obj_panel_bot.mapHeight/room_height),false )

	gpu_set_blendmode(bm_normal);

	// Iterate through instances
	for (var k = 0; k < instance_number(obj_editor_placeable_parent); k += 1) {
		trg = instance_find(obj_editor_placeable_parent,k);
	
		if surface_exists(trg.tileSurfaceDraw) {
			if trg.id != wipeId {
				// If this instance is within the inputted region
				if x1 <= trg.x + (trg.width+1)*20 && x2 >= trg.x - 20 &&
				y1 <= trg.y + (trg.height + trg.zfloor - trg.zcieling)*20 && y2 >= trg.y - 20 {
					// Depth sort this tile for drawing
					instCountId[instCountSize] = trg.id;
					instCountSize += 1;
				}
			}
		}
	}

	// Iterate through each tile in the domain
	for (var i = 0; i <= (x2-x1) div 20; i += 1) {
		for (var j = 0; j <= (y2-y1) div 20; j += 1) {
			// Initialize values for depth sorting by each i,j pair
			depthsCounted = 0;
		
			for (k = 0; k < instCountSize; k += 1) {
				instCounted[k] = false;
			}
		
			// Loop until every instCountId is depth sorted
			while depthsCounted < instCountSize {
				tempDepth = 1; // No terrain instance will ever have a depth of 1
			
				// Loop through every instCountId
				for (k = 0; k < instCountSize; k += 1) {
					// If this instCountId has not been sorted yet
					if !instCounted[k] {
						// If instCountId[k] has the largest depth in this pass of the loop
						if instCountId[k].depth >= tempDepth || tempDepth = 1 {
							instSortedId[depthsCounted] = instCountId[k];
						
							tempDepth = instCountId[k].depth;
							tempInstInd = k;
						}
					}
				}
			
				// Count this instance for being depth sorted
				instCounted[tempInstInd] = true;
				depthsCounted += 1;
			}
		
			// Draw tiles in the order they are sorted
			for (k = 0; k < depthsCounted; k += 1) {
				if x1 + i*20 < instSortedId[k].x + surface_get_width(instSortedId[k].tileSurfaceDraw) && x1 + i*20 >= instSortedId[k].x &&
				y1 + j*20 < instSortedId[k].y + surface_get_height(instSortedId[k].tileSurfaceDraw) - 20 && y1 + j*20 >= instSortedId[k].y {
					// Draw tile to minimap
					draw_surface_part_ext( instSortedId[k].tileSurfaceDraw,
				
					( (x1 - ( instSortedId[k].x - 20) ) div 20 + i ) * 20,
					( j - ( instSortedId[k].y - 20 - y1) div 20 ) * 20,
				
					20, 20,
				
					( x1 + i*20 ) * obj_panel_bot.mapWidth/room_width,
					( y1 + j*20 ) * obj_panel_bot.mapHeight/room_height,
				
					obj_panel_bot.mapWidth/room_width, obj_panel_bot.mapHeight/room_height,
					c_white,1);
				}
			}
		}
	}

	// Pass the new surface in
	surface_copy(obj_panel_bot.mapSurface,0,0,surf);

	// Clear this surface
	draw_clear_alpha(c_white,0);

	// Destroy this surface
	surface_reset_target();
	surface_free(surf);



}
