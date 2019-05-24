/// @description 
activated = false;
magnitude = 0;

for (i = 0; i < ds_list_size(polygon); i += 6) {
	if point_in_triangle(obj_player_overworld.x,obj_player_overworld.y,ds_list_find_value(polygon,i),ds_list_find_value(polygon,i+1),ds_list_find_value(polygon,i+2),ds_list_find_value(polygon,i+3),ds_list_find_value(polygon,i+4),ds_list_find_value(polygon,i+5)) {
		activated = true;
		
		break;
	}
}

if !activated {
	// In threshold regions
	for (j = 0; j < thresholdCount; j += 1) { // All threshold regions
		for (i = 0; i < ds_list_size(thresholdRegion[j]); i += 6) { // All internal triangles of each threshold region
			if point_in_triangle(obj_player_overworld.x,obj_player_overworld.y,ds_list_find_value(thresholdRegion[j],i),ds_list_find_value(thresholdRegion[j],i+1),ds_list_find_value(thresholdRegion[j],i+2),ds_list_find_value(thresholdRegion[j],i+3),ds_list_find_value(thresholdRegion[j],i+4),ds_list_find_value(thresholdRegion[j],i+5)) {
				// Calculate magnitude
				theta = degtorad((point_direction(thresholdEntryX[j],thresholdEntryY[j],obj_player_overworld.x,obj_player_overworld.y) - point_direction(thresholdEntryX[j],thresholdEntryY[j],thresholdExitX[j],thresholdExitY[j])));
				playerDistance = cos(theta) * point_distance(obj_player_overworld.x,obj_player_overworld.y,thresholdEntryX[j],thresholdEntryY[j]);
				
				magnitude = maxMagnitude * ( dsin( playerDistance / thresholdLength[j] * 180 - 90 ) + 1 ) / 2;
				
				if magnitude < 0 {
					magnitude = 0;
				}
				
				if magnitude > maxMagnitude {
					magnitude = maxMagnitude;
				}
				
				obj_camera_editor.panX = lengthdir_x(magnitude,angle)*20;
				obj_camera_editor.panY = lengthdir_y(magnitude,angle)*20;
				
				doubleBreak = true;
				break;
			}
		}
		
		if doubleBreak {
			doubleBreak = false;
			break;
		}
	}
} else {
	// In polygon region
	magnitude = maxMagnitude;
	
	obj_camera_editor.panX = lengthdir_x(magnitude,angle)*20;
	obj_camera_editor.panY = lengthdir_y(magnitude,angle)*20;
}
