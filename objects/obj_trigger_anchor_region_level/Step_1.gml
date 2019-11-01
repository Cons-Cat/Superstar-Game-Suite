/// @description 
if collision_ellipse(x1+thresholdRadius*20,y1-thresholdRadius*20,x2-thresholdRadius*20,y2+thresholdRadius*20,obj_player_overworld,false,false) {
	obj_camera_editor.anchorId = self.id;
	
	if !activeInScene {
		activeInScene = true;
	}
	
	a1 = minorRadius;
	b1 = majorRadius;
	a2 = minorRadius + thresholdRadius*20;
	b2 = majorRadius + thresholdRadius*20;
	theta = point_direction(x+10,y+10,obj_player_overworld.x,obj_player_overworld.y);
	distance = point_distance(x+10,y+10,obj_player_overworld.x,obj_player_overworld.y);
	radiusInner = (a1 * b1) / (sqrt( sqr(a1) * sqr(dsin(theta)) + sqr(b1) * sqr(dcos(theta))));
	radiusOuter = (a2 * b2) / (sqrt(sqr(a2) * sqr(dsin(theta)) + sqr(b2) * sqr(dcos(theta))));
	
	if distance < radiusOuter {
		if distance > radiusInner {
			magnitude = ( dsin( (radiusOuter - distance) / (radiusOuter - radiusInner) * 180 - 90 ) + 1 ) / 2;
			zoom = 1 - (maxZoom * magnitude);
		} else {
			magnitude = 1;
			zoom = 1 - maxZoom;
		}
	} else {
		magnitude = 0;
		zoom = 1;
	}
	
	obj_camera_editor.anchored = true;
	obj_camera_editor.zoomLevel = self.zoom;
} else {
	if activeInScene {
		obj_camera_editor.anchored = false;
		
		activeInScene = false;
		magnitude = 0;
		zoom = 1 - maxZoom;
	}
}
