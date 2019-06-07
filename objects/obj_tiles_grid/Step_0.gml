/// @description 
/*if mouse_y >= 600 {
	if mouse_x <= 170 {
		if !keyboard_check(vk_shift) {
			if mouse_wheel_down() {
				y -= 10;
			}
			if mouse_wheel_up() {
				y += 10;
			}
		} else {
			if mouse_wheel_down() {
				x -= 10;
			}
			if mouse_wheel_up() {
				x += 10;
			}
		}
	}
}*/

x = camera_get_view_x(obj_editor_gui.cameraLeftPanel) + 2 + i*21;
y = 1 + j*21;

tileLayerCount = array_height_2d(obj_tile_layers.list) - 1;

if mouse_x >= self.x && mouse_x < self.x+20 {
	if mouse_y >= self.y && mouse_y < self.y+20 {
		if mouse_check_button(mb_left) {
			for (a = 0; a < obj_tiles_sheet.selectWidthOffset; a += 20) {
				for (b = 0; b < obj_tiles_sheet.selectHeightOffset; b += 20) {
					//for(k = 0; k < tileLayerCount; k += 1) {
						k = 0;
						
						with collision_point(x+a+a/20, y+b+b/20,obj_tiles_grid,false,false) {
							xVal[k] = obj_tiles_sheet.xVal[other.a,other.b] - obj_tiles_sheet.x;
							yVal[k] = obj_tiles_sheet.yVal[other.a,other.b] - obj_tiles_sheet.y;
							tempMaterial = global.sprMaterial;
						}
						hasTile[scr_array_xy(i,j,tileLayerCount),k] = true;
						
						break;
					//}
				}
			}
		}
	}
}

for (k = 0; k <= tileLayerCount-1; k += 1) {
	if hasTile[scr_array_xy(i,j,tileLayerCount),k] {
		trgId.tileArrayDrawX[scr_array_xy(i,j,tileLayerCount),k] = xVal[k];
		trgId.tileArrayDrawY[scr_array_xy(i,j,tileLayerCount),k] = yVal[k];
	}
}

trgId.sprMaterial = global.sprMaterial;
trgId.slope3MustUpdate = true;
