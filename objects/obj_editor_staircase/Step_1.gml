/// @description Hover over with mouse.
hovered = false;

if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 3 {
	if surface_exists(bakedStaircase) {
		if mouseCheckX >= staircaseRasterX0 && mouseCheckX < staircaseRasterX0 + staircaseW {
			if mouseCheckY >= staircaseRasterY0 && mouseCheckY < staircaseRasterY0 + staircaseH {
				if staircaseRasterInd[mouseCheckX - staircaseRasterX0, mouseCheckY - staircaseRasterY0] != -1 {
					hovered = true;
				}
			}
		}
	}
} else if obj_editor_gui.mode = 1 {
	var zOff =  (zfloor - zcieling) * 20;
	
	if point_in_triangle(mouseCheckX, mouseCheckY, x1, y1 + zOff, x2, y2 + zOff, x3, y3)
	|| point_in_triangle(mouseCheckX, mouseCheckY, x3, y3, x2, y2 + zOff, x4, y4)
	{
		hovered = true;
	}
}

// This hovered bool is used by obj_editor_gui to help determine canSelect.
