/// @description Insert description here
if y < window_get_height() {

draw_sprite_tiled_area(spr_editor_gui_streaks,0,0,0,obj_panel_left.baseX + 1,y,obj_panel_right.baseX - 1,view_get_hport(1));

// Timeline ticks
scrollOffDraw = ( ((scrollHorX - obj_panel_left.baseX - 1) / (scrollHorRightBound - scrollHorLeftBound)) * panelWidth ) % 60;

for (i = 0; i <= (view_get_wport(1) - 390) div 28; i += 1) {
	draw_sprite_ext(spr_timeline_tick,0,obj_panel_left.baseX + 3 + i*60 - scrollOffDraw,y + 21,2,1,0,c_white,1);
}

// Inside outline
draw_set_color(make_color_rgb(63,70,87));
draw_rectangle(obj_panel_left.baseX,y,obj_panel_left.baseX,view_hport[1]-2,false);
draw_rectangle(obj_panel_right.baseX,y+20,obj_panel_right.baseX,view_hport[1]-2,false);

// Timeline rows
for (i = 0; i < rows; i += 1) {
	draw_set_color(make_color_rgb(35,38,45));
	draw_rectangle(obj_panel_left.baseX,y+33+i*14,obj_panel_right.baseX,y+45+i*14,false);
	
	// Light gray
	draw_set_color(make_color_rgb(63,70,87));
	draw_rectangle(obj_panel_left.baseX,y+46+i*14,obj_panel_right.baseX,y+46+i*14,false); // Timeline segment top outline
	draw_rectangle(obj_panel_left.baseX,y+32+i*14,obj_panel_right.baseX,y+32+i*14,false); // Timeline segment bot outline
	
	// Dark gray
	draw_set_color(make_color_rgb(31,34,40));
	draw_rectangle(obj_panel_left.baseX,y+33+i*14,obj_panel_right.baseX,y+33+i*14,false); // Timeline segment
}

// Draw actions
for (i = 1; i <= totalActions; i += 1) {
	if actionInd[i] != -1 {
		if actionSelect[i] || actionDelete[i] {
			draw_sprite_ext(spr_cutscene_action_second, 0, camera_get_view_x(obj_editor_gui.cameraLeftSubPanel) + view_wport[5] + actionTime[i]*6 + obj_subpanel_left.longestPanelRightButton, 1 + actionRowInd[i]*14, 1, 1, 0, c_orange, 1);
		} else {
			draw_sprite_ext(spr_cutscene_action_second, 0, camera_get_view_x(obj_editor_gui.cameraLeftSubPanel) + view_wport[5] + actionTime[i]*6 + obj_subpanel_left.longestPanelRightButton, 1 + actionRowInd[i]*14, 1, 1, 0, actionColInd[actionInd[i]], 1);
		}
	}
}

// Corners
draw_set_color(make_color_rgb(35,38,45));
draw_rectangle(room_width + 3,y+4,obj_panel_left.baseX - 2,view_hport[1],false);
draw_rectangle(obj_panel_right.baseX + 2,y+4,room_width + view_wport[1]-3,view_hport[1],false);

// Outlines
if y < view_hport[1] {
	draw_set_color(make_color_rgb(63,70,87));
	draw_rectangle(room_width,y,room_width + view_wport[1],y,false);
	draw_rectangle(room_width,y,room_width,y+view_hport[1]-1,false);
	draw_rectangle(room_width + view_wport[1]-1,y,room_width + view_wport[1],y+view_hport[1]-1,false);
	
	draw_set_color(make_color_rgb(28,30,36));
	draw_rectangle(room_width, y+1,room_width + view_wport[1]-1,view_hport[1] - 1,true);
	draw_rectangle(room_width + 1, y+2,room_width + view_wport[1] - 2,view_hport[1] - 2,true);
	
	draw_set_color(make_color_rgb(31,34,40));
	draw_rectangle(room_width + 2,y+3,room_width + view_wport[1]-3,view_hport[1]-3,true);
	draw_rectangle(obj_panel_left.baseX - 1,y+3,obj_panel_right.baseX + 1,view_hport[1]-3,true);
	
	draw_set_color(make_color_rgb(38,43,50));
	draw_rectangle(room_width + 6,y+29,obj_panel_left.baseX - 5,y+31,false);
	draw_set_color(make_color_rgb(30,32,37));
	draw_rectangle(room_width + 6,y+32,obj_panel_left.baseX - 5,y+33,false);
}

// Actor rows
if rows > 0 {
	for (i = 0; i < rows; i += 1) {
		// Light gray
		draw_set_color(make_color_rgb(63,70,87));
		draw_rectangle(room_width + 3,y+46+i*14,obj_panel_left.baseX - 2,y+46+i*14,false); // Actor segment
		
		// Dark gray
		draw_set_color(make_color_rgb(31,34,40));
		draw_rectangle(room_width + 3,y+47+i*14,obj_panel_left.baseX -2,y+47+i*14,false); // Actor segment
		
		// Text
		if selectRow[i] || canSelectRow[i] {
			draw_set_color(make_color_rgb(255,160,64)); // Orange
			draw_rectangle(room_width + 21,y+35+i*14,obj_panel_left.baseX - 2,y+46+i*14,false);
			
			draw_set_font(fontDark);
			draw_text(room_width + 23,y+36+i*14,actorTxt[i]);
		} else {
			draw_set_color(make_color_rgb(200,210,243)); // Light text
			
			draw_set_font(fontLight);
			draw_text(room_width + 23,y+36+i*14,actorTxt[i]);
		}
	}
}

// Minimap
gradientY[0] = 1; // Portion for dark
gradientY[1] = 0.88; // Portion for medium
gradientY[2] = 0.5; // Portion for light

// Keep width proportional to the height, or vice versa, depending on which is larger
if room_width >= room_height {
	mapRatio = room_height / room_width;
	
	mapWidth = (room_width + view_wport[1] - 37) - (obj_panel_right.baseX + 34);
	mapHeight = mapWidth * mapRatio;
} else {
	mapRatio = room_width / room_height;
	
	mapHeight = (view_hport[1] - 26) - (y + 5);
	mapWidth = mapHeight * mapRatio;
}

// Make map drag with the bottom panel

if y > baseY {
	mapYOff = floor( (y - baseY) / 2 );
} else {
	mapYOff = 0;
}

mapCenterX = floor( room_width + (view_wport[1]) - (room_width + (view_wport[1]) - obj_panel_right.baseX) / 2 );
mapCenterY = floor( y + 5 + ( (view_hport[1] - 31) - y ) / 2 ) + mapYOff;

// Draw map backdrop
if surface_exists(mapSurface) {
	draw_surface_stretched(mapSurface, mapCenterX - floor(mapWidth/2), mapCenterY - floor(mapHeight/2), mapWidth, mapHeight);
}

// 16:9 ratio cursor
mapCursorWidth = 16 * (mapWidth - 10) / (room_width / 20 - 16) / obj_editor_gui.realPortScaleHor;
mapCursorHeight = mapCursorWidth * 9/16;

// Conversion ratios: Room units to map units
mapCursorIncrementX = (mapWidth - 10) / (room_width / 20 - 16) - ( 16 / (room_width / 20) * obj_editor_gui.realPortScaleHor);
mapCursorIncrementY = (mapWidth - 9) / (room_height / 20 - 9) - ( 9 / (room_height / 20) * obj_editor_gui.realPortScaleVer);

if obj_camera_editor.gridAtX = room_width / 20 - 16 {
	// Snap cursor to right edge
	mapCursorX = mapWidth - 11 - round(mapCursorWidth);
} else {
	// Increment the cursor horizontally
	mapCursorX = obj_camera_editor.gridAtX * mapCursorIncrementX;
}

mapCursorY = obj_camera_editor.gridAtY * mapCursorIncrementY;

// Minimap top edge
draw_sprite_ext(spr_minimap_vert,0,mapCenterX - floor((mapWidth-14)/2),mapCenterY - floor(mapHeight/2),mapWidth-14,1,0,c_white,1); // Top edge
draw_sprite_ext(spr_minimap_corner,0,mapCenterX - floor(mapWidth/2) + 8,mapCenterY - floor(mapHeight/2),1,1,0,c_white,1); // Top left corner
draw_sprite_ext(spr_minimap_corner,0,mapCenterX + floor(mapWidth/2) - 8,mapCenterY - floor(mapHeight/2),-1,1,0,c_white,1); // Top right corner

// Minimap bottom edge
draw_set_color(make_color_rgb(31,34,40));
draw_rectangle(mapCenterX - floor((mapWidth-10)/2),mapCenterY + floor(mapHeight/2) - 6,mapCenterX + floor((mapWidth-10)/2),mapCenterY + floor(mapHeight/2) - 6,false);
draw_rectangle(mapCenterX + floor((mapWidth)/2) - 7,mapCenterY + floor(mapHeight/2) - 7,mapCenterX + floor((mapWidth)/2) - 7,mapCenterY + floor(mapHeight/2) - 7,false);
draw_rectangle(mapCenterX - floor((mapWidth)/2) + 6,mapCenterY + floor(mapHeight/2) - 7,mapCenterX - floor((mapWidth)/2) + 6,mapCenterY + floor(mapHeight/2) - 7,false);

for (i = 0; i <= 2; i += 1) {
	// Left edge
	draw_sprite_ext(spr_minimap_side,i,mapCenterX - floor((mapWidth-12)/2),mapCenterY - floor(mapHeight/2) + 8 + 1/(mapHeight*gradientY[i]),1,(mapHeight*gradientY[i]) - 15,0,c_white,1); // Left light edge
	
	// Right edge
	draw_sprite_ext(spr_minimap_side,i,mapCenterX + floor((mapWidth-12)/2),mapCenterY - floor(mapHeight/2) + 8 + 1/(mapHeight*gradientY[i]),-1,(mapHeight*gradientY[i]) - 15,0,c_white,1); // Right light edge
}

// Draw map cursor
cursorX1 = mapCenterX - floor(mapWidth/2) + 5 + mapCursorX;
cursorX2 = mapCenterX - floor(mapWidth/2) + 5 + mapCursorWidth + mapCursorX;
cursorY1 = mapCenterY - floor(mapHeight/2) + 5 + mapCursorY;
cursorY2 = mapCenterY - floor(mapHeight/2) + 5 + mapCursorHeight + mapCursorY;

// Darks
	// Top
	draw_set_color(make_color_rgb(28,30,36));
	draw_rectangle(cursorX1+2,cursorY1+1,cursorX2-2,cursorY1+1,false);
	draw_rectangle(cursorX1+1,cursorY1+2,cursorX1+1,cursorY1+2,false);
	draw_rectangle(cursorX2-1,cursorY1+2,cursorX2-1,cursorY1+2,false);
	
	draw_set_color(make_color_rgb(31,34,40));
	draw_rectangle(cursorX1+2,cursorY1+2,cursorX2-2,cursorY1+2,false);
	draw_rectangle(cursorX1+1,cursorY1+3,cursorX1+1,cursorY1+3,false);
	draw_rectangle(cursorX2-1,cursorY1+3,cursorX2-1,cursorY1+3,false);
	
	// Bottom
	draw_set_color(make_color_rgb(28,30,36));
	draw_rectangle(cursorX1+1,cursorY2+1,cursorX2-1,cursorY2+1,false);
	draw_rectangle(cursorX1,cursorY2,cursorX1,cursorY2,false);
	draw_rectangle(cursorX2,cursorY2,cursorX2,cursorY2,false);
	
	draw_set_color(make_color_rgb(31,34,40));
	draw_rectangle(cursorX1+1,cursorY2+2,cursorX2-1,cursorY2+2,false);
	draw_rectangle(cursorX1,cursorY2+1,cursorX1,cursorY2+1,false);
	draw_rectangle(cursorX2,cursorY2+1,cursorX2,cursorY2+1,false);

//Lights
	// Top
	draw_set_color(make_color_rgb(230,232,242));
	draw_rectangle(cursorX1+1,cursorY1,cursorX2-1,cursorY1,false);
	draw_rectangle(cursorX1,cursorY1+1,cursorX1+1,cursorY1+1,false);
	draw_rectangle(cursorX2-1,cursorY1+1,cursorX2,cursorY1+1,false);
	
	// Middle
	draw_set_color(make_color_rgb(200,210,243));
	draw_rectangle(cursorX1,cursorY1+2,cursorX1,cursorY2-2,false);
	draw_rectangle(cursorX2,cursorY1+2,cursorX2,cursorY2-2,false);
	
	// Bottom
	draw_rectangle(cursorX1,cursorY2-1,cursorX1+1,cursorY2-1,false);
	draw_rectangle(cursorX2-1,cursorY2-1,cursorX2,cursorY2-1,false);
	draw_rectangle(cursorX1+1,cursorY2,cursorX2-1,cursorY2,false);

// Minimap bottom edge, drawn over the cursor
draw_sprite_ext(spr_minimap_vert,1,mapCenterX - floor((mapWidth-14)/2),mapCenterY + floor(mapHeight/2)+1,mapWidth-14,-1,0,c_white,1);
draw_sprite_ext(spr_minimap_corner,1,mapCenterX - floor(mapWidth/2) + 8,mapCenterY + floor(mapHeight/2)+1,1,-1,0,c_white,1); // Bottom left corner
draw_sprite_ext(spr_minimap_corner,1,mapCenterX + floor(mapWidth/2) - 8,mapCenterY + floor(mapHeight/2)+1,-1,-1,0,c_white,1); // Bottom right corner

// Draw scrollbars and slider
event_inherited();

}

draw_sprite_ext(sprite_index,image_index,x,y+1,image_xscale,image_yscale,image_angle,c_white,1);
