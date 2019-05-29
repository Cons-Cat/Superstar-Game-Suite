/// @description 
activated = false;
outside = true;
zoom = 1;

for (i = 0; i < ds_list_size(polygon); i += 6) {
	if point_in_triangle(obj_player_overworld.x,obj_player_overworld.y,ds_list_find_value(polygon,i),ds_list_find_value(polygon,i+1),ds_list_find_value(polygon,i+2),ds_list_find_value(polygon,i+3),ds_list_find_value(polygon,i+4),ds_list_find_value(polygon,i+5)) {
		outside = false;
		
		if angle != -1 {
			magnitude = maxMagnitude;
		} else {
			magnitude = 0;
		}
		
		zoom = 1 - maxZoom;
		
		break;
	}
}

if outside {
	// In threshold regions
	for (j = 0; j < thresholdCount; j += 1) { // All threshold regions
		for (i = 0; i < ds_list_size(thresholdRegion[j]); i += 6) { // All internal triangles of each threshold region
			if point_in_triangle(obj_player_overworld.x,obj_player_overworld.y,ds_list_find_value(thresholdRegion[j],i),ds_list_find_value(thresholdRegion[j],i+1),ds_list_find_value(thresholdRegion[j],i+2),ds_list_find_value(thresholdRegion[j],i+3),ds_list_find_value(thresholdRegion[j],i+4),ds_list_find_value(thresholdRegion[j],i+5)) {
				// Calculate magnitude
				theta = degtorad((point_direction(thresholdEntryX[j],thresholdEntryY[j],obj_player_overworld.x,obj_player_overworld.y) - point_direction(thresholdEntryX[j],thresholdEntryY[j],thresholdExitX[j],thresholdExitY[j])));
				playerDistance = cos(theta) * point_distance(obj_player_overworld.x,obj_player_overworld.y,thresholdEntryX[j],thresholdEntryY[j]);
				
				magnitude = maxMagnitude * ( dsin( playerDistance / thresholdLength[j] * 180 - 90 ) + 1 ) / 2;
				zoom = 1 - (maxZoom * (magnitude/maxMagnitude));
				
				if angle = -1 {
					magnitude = 0;
				}
				
				doubleBreak = true;
				
				break;
			}
		}
		
		if doubleBreak {
			doubleBreak = false;
			
			break;
		}
	}
}

obj_camera_editor.panX = lengthdir_x(magnitude,angle)*20;
obj_camera_editor.panY = lengthdir_y(magnitude,angle)*20;
obj_camera_editor.zoomLevel = self.zoom;
