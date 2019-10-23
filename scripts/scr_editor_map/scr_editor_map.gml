///scr_array_xy(x1,y1,x2,y2)

var x1 = argument[0];
var x2 = argument[2];
var y1 = argument[1];
var y2 = argument[3];

var trg;

// Check for surface
if !surface_exists(obj_panel_bot.mapSurface) {
	obj_panel_bot.mapSurface = surface_create(room_width,room_height);
}

// Clear area
gpu_set_blendmode(bm_subtract);
surface_set_target(obj_panel_bot.mapSurface);
draw_set_color(c_white);
draw_rectangle(x1,y1,x2,y2,false)
surface_reset_target();
gpu_set_blendmode(bm_normal);

for (var i = x1 div 20; i < x2 div 20; i += 1) {
	for (var j = y1 div 20; j < y2 div 20; j += 1) {
		tempDepth[i,j] = 0;
	}
}

// Iterate through instances
for (var k = 0; k < instance_number(obj_editor_terrain); k += 1) {
	trg = instance_find(obj_editor_terrain,k);
	
	// If either left or right side is within x bounds
	if (trg.x + trg.width*20 >= x1 && trg.x + trg.width*20 < x2) || (trg.x >= x1 && trg.x < x2) {
		// If either top or bottom side is within y bounds
		if (trg.y + (trg.zfloor - trg.zcieling + trg.height)*20 >= y1 && trg.y + (trg.zfloor - trg.zcieling + trg.height)*20 < y2) || (trg.y >= y1 && trg.y < y2) {
			// Iterate through absolute co-ordinates
			for (var i = x1 div 20; i < x2 div 20; i += 1) {
				for (var j = y1 div 20; j < y2 div 20; j += 1) {
					// If this instance has a lower depth than the tile currently occupying these co-ordinates
					if trg.depth <= tempDepth[i,j] {
						// Update the depth of these co-ordinates
						tempDepth[i,j] = trg.depth;
						
						// Draw tile to minimap
						surface_copy_part(obj_panel_bot.mapSurface, i*20, j*20, trg.tileSurfaceDraw, (i * 20) - trg.x, (j * 20) - trg.y, 20, 20);
						//show_debug_message("x: " + string(i*20) + ", y: " + string(j*20));
					}
				}
			}
		}
	}
}
