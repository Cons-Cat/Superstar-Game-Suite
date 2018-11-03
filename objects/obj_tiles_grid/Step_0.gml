/// @description 
if mouse_y >= 600 {
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
}

if mouse_x >= self.x && mouse_x < self.x+20 {
	if mouse_y >= self.y && mouse_y < self.y+20 {
		if mouse_check_button(mb_left) {
			for (a = 0; a < obj_tiles_sheet.selectWidthOffset; a += 20) {
				for (b = 0; b < obj_tiles_sheet.selectHeightOffset; b += 20) {
					with collision_point(x+a+a/20, y+b+b/20,obj_tiles_grid,false,false) {
						xVal = obj_tiles_sheet.xVal[other.a,other.b] - obj_tiles_sheet.x;
						yVal = obj_tiles_sheet.yVal[other.a,other.b] - obj_tiles_sheet.y;
						tempMaterial = global.sprMaterial;
					}
				}
			}
		}
	}
}

if close = true {
	trgId.sprMaterial = global.sprMaterial;
	trgId.tileArrayDrawX[i,j] = xVal;
	trgId.tileArrayDrawY[i,j] = yVal;
	trgId.slope3MustUpdate = true;
	
	instance_destroy();
}
