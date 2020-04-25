/// @description Wheel input behavior.
if select {
	relativeMouseX = window_mouse_get_x();
	relativeMouseY = window_mouse_get_y();
	angle = floor(point_direction(x+sprWidth+w/2 - camera_get_view_x(view_camera[viewOn]) + view_xport[viewOn], y-1+h/2 + view_yport[viewOn],relativeMouseX,relativeMouseY) / 22.5) * 22.5;
	angle = (angle + 360) % 360;
	
	// Snap angle to pixel-friendly angles.
	if angle % 45 != 0 {
		if angle % 90 > 45 {
			angle = 63.43 + (90 * (angle div 90));
		} else {
			angle = 26.565 + (90 * (angle div 90));
		}
	}
	
	// Snap to nothing if in its center
	if point_in_rectangle(mouse_x,mouse_y,x+sprWidth+2+w/2-5,y-5-1+w/2,x+sprWidth+2+w/2+5,y+5-1+h/2) {
		angle = -1;
	}
	
	//canSelect = true;
}
