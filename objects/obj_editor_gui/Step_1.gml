/// @description Update views to screen size
/*
// Minimum window dimensions
if window_get_width() < 1024 {
	window_set_position(windowTempX,window_get_y());
	window_set_size(1024,window_get_height());
}
if window_get_height() < 576 {
	window_set_position(window_get_x(),windowTempY);
	window_set_size(window_get_width(),576);
}

windowTempX = window_get_x();
windowTempY = window_get_y();*/

if window_has_focus() {
	if tempResWidth != window_get_width() || tempResHeight != window_get_height() {
		// Replace surfaces
		with obj_editor_terrain_par {
			surfaceResize = true;
			calculateSub = true;
		}
		with obj_panel_bot {
			remakeMap = true;
		}
		with obj_cutscene_dialogue {
			remakeSurface = true;
		}
		
		if window_get_width() >= 3840 {
			is4K = true;
		} else {
			is4K = false;
		}
		
		realPortScaleHor = window_get_width() div 512;
		realPortScaleVer = window_get_height() div 288;
		
		// Set world view
		view_set_wport(0,( 512 * realPortScaleHor ) + ( window_get_width() - (512 * realPortScaleHor )) );
		view_set_hport(0,( 288 * realPortScaleVer ) + ( window_get_height() - (288 * realPortScaleVer )) );
		
		camera_set_view_size(cameraRealGame,view_wport[0] / realPortScaleHor,view_hport[0] / realPortScaleHor);
		
		// Set GUI view
		view_set_wport(1,window_get_width());
		view_set_hport(1,window_get_height());
		view_set_xport(1,0);
		
		camera_set_view_size(view_camera[1],window_get_width(),window_get_height());
		camera_set_view_pos(view_camera[1],room_width,0);
		
		surface_resize(application_surface, view_get_wport(1), view_get_hport(1));
		
		// Update left panel
		obj_panel_left.baseX = round( (window_get_width() - (16 * 20 * realPortScaleHor) ) / 2 ) + room_width;
		
		if obj_panel_left.onBase = 1 { // At baseX
			obj_panel_left.x = obj_panel_left.baseX;
		}
		if obj_panel_left.onBase = 2 { // Folded
			obj_panel_left.x = room_width;
		}
		
		if obj_panel_left.x < obj_panel_left.baseX {
			obj_panel_left.x = obj_panel_left.baseX;
		}
		
		obj_panel_left.moveToX = obj_panel_left.x;
		
		// Update right panel
		obj_panel_right.baseX = window_get_width() + room_width*2 - obj_panel_left.baseX;
		
		if obj_panel_right.onBase = 1 { // At baseX
			obj_panel_right.x = obj_panel_right.baseX;
		}
		if obj_panel_right.onBase = 2 { // Folded
			obj_panel_right.x = view_wport[1] + room_width;;
		}
		
		if obj_panel_right.x > obj_panel_right.baseX {
			obj_panel_right.x = obj_panel_right.baseX;
		}
		
		obj_panel_right.moveToX = obj_panel_right.x;
		
		// Update bottom panel
		obj_panel_bot.baseY = ( 9 * 20 * obj_editor_gui.realPortScaleVer ) + ( 60 / 576 * window_get_height() );
		
		if obj_panel_bot.onBase = 1 { // At baseX
			obj_panel_bot.y = obj_panel_bot.baseY;
		}
		if obj_panel_bot.onBase = 2 { // Folded
			obj_panel_bot.y = view_hport[1];
		}
		
		obj_panel_bot.moveToY = obj_panel_bot.y;
		
		// Update top panel
		obj_panel_top.baseY = view_hport[1] - ( ( 576 - 60 - (9*20*2) ) / 576 * view_hport[1]);
		
		if obj_panel_top.onBase = 1 { // At baseX
			obj_panel_top.y = obj_panel_top.baseY;
		}
		if obj_panel_top.onBase = 2 { // Folded
			obj_panel_top.y = 0;
		}
		
		obj_panel_top.moveToY = obj_panel_top.y;
		
		// Reset panel temp places
		global.tempXRight = obj_panel_right.baseX;
		global.tempXLeft = obj_panel_left.baseX;
		
		tempResWidth = window_get_width();
		tempResHeight = window_get_height();
	}
}

mouseCheckX = floor(window_mouse_get_x() * camera_get_view_width(cameraRealGame) / window_get_width() ) + camera_get_view_x(cameraRealGame);
mouseCheckY = floor(window_mouse_get_y() * camera_get_view_height(cameraRealGame) / window_get_height() ) + camera_get_view_y(cameraRealGame);

if keyboard_check(vk_control) {
	global.snapDimension = 10;
} else {
	global.snapDimension = 20;
}
