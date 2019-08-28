/// @description Update views to screen size
/*if window_get_width() < 1024 {
	window_set_position(windowTempX,window_get_y());
	window_set_size(1024,window_get_height());
}
if window_get_height() < 576 {
	window_set_position(window_get_x(),windowTempY);
	window_set_size(window_get_width(),576);
}

windowTempX = window_get_x();
windowTempY = window_get_y();*/
if tempResWidth != window_get_width() || tempResHeight != window_get_height() {
	realPortScaleHor = window_get_width() div 512;
	realPortScaleVer = window_get_height() div 288;
	
	view_set_wport(0,512 * ( realPortScaleHor ) +  (window_get_width() - (512 * ( realPortScaleHor ))) );
	view_set_hport(0,288 * ( realPortScaleVer ) + ( window_get_height() - (288 * ( realPortScaleVer ))) );
	
	view_set_wport(1,window_get_width());
	view_set_hport(1,window_get_height());
	view_set_xport(1,0);
	
	camera_set_view_size(cameraRealGame,view_wport[0] / realPortScaleHor,view_hport[0] / realPortScaleHor);
	camera_set_view_size(view_camera[1],window_get_width(),window_get_height());
	camera_set_view_pos(view_camera[1],room_width,0);
	
	surface_resize(application_surface, view_get_wport(1), view_get_hport(1));
	
	if obj_panel_left.onBase = 1 {
		obj_panel_left.x = (window_get_width() - 320 * obj_editor_gui.realPortScaleHor)/2 - 1 + room_width;
		obj_panel_left.moveToX = obj_panel_left.x;
	}
	if obj_panel_left.onBase = 2 {
		obj_panel_left.x = room_width;
		obj_panel_left.moveToX = obj_panel_left.x;
	}
	
	if obj_panel_right.onBase = 1 {
		obj_panel_right.x = window_get_width() - (window_get_width() - 320 * obj_editor_gui.realPortScaleHor)/2 + 1 + room_width;
		obj_panel_right.moveToX = obj_panel_right.x;
	}
	if obj_panel_right.onBase = 2 {
		obj_panel_right.x = view_wport[1] + room_width;
		obj_panel_right.moveToX = obj_panel_right.x;
	}
	
	if obj_panel_bot.onBase = 1 {
		obj_panel_bot.y = view_hport[1] - (156/576 * view_hport[1]);
		obj_panel_bot.moveToY = obj_panel_bot.y;
	}
	if obj_panel_bot.onBase = 2 {
		obj_panel_bot.y = view_hport[1];
		obj_panel_bot.moveToY = obj_panel_bot.y;
	}
	
	if obj_panel_top.onBase = 1 {
		obj_panel_top.y = 60/576 * view_hport[1] - 1;
		obj_panel_top.moveToY = obj_panel_top.y;
	}
	if obj_panel_top.onBase = 2 {
		obj_panel_top.y = 0;
		obj_panel_top.moveToY = obj_panel_top.y;
	}
	
	tempResWidth = window_get_width();
	tempResHeight = window_get_height();
}

mouseCheckX = floor(window_mouse_get_x() * (camera_get_view_width(cameraRealGame)) / window_get_width()) + camera_get_view_x(cameraRealGame);
mouseCheckY = floor(window_mouse_get_y() * (camera_get_view_height(cameraRealGame)) / window_get_height()) + camera_get_view_y(cameraRealGame);

// Toggle marble drawing
if keyboard_check_pressed(ord("Q")) {
	global.drawMarble = !global.drawMarble;
}
