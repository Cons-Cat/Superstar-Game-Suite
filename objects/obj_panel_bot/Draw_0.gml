/// @description Insert description here
//if y < obj_editor_gui.calcWindowHeight {

draw_sprite_tiled_area(spr_editor_gui_streaks,0,0,0,obj_panel_left.baseX + 1,y,obj_panel_right.baseX - 1,view_get_hport(1));

// Actor rows
if rows > 0 {
	#region
	
	for (i = 0; i < rows; i += 1) {
		// Light gray
		draw_set_color(col[0]);
		draw_rectangle(actorDrawX,12-rowsDrawY+i*14,actorDrawX + view_wport[6]-2,12-rowsDrawY+i*14,false); // Actor segment
		
		// Dark gray
		draw_set_color(col[2]);
		draw_rectangle(actorDrawX,13-rowsDrawY+i*14,actorDrawX + view_wport[6],13-rowsDrawY+i*14,false); // Actor segment
		
		// Text
		if selectRow[i] || canSelectRow[i] {
			draw_set_color(make_color_rgb(255,160,64)); // Orange highlight and text
			draw_rectangle(actorDrawX,-rowsDrawY+i*14,actorDrawX + view_wport[6] - 2,12-rowsDrawY+i*14 - 1,false);
			
			draw_set_font(fontDark);
			draw_text(actorDrawX + 4,2-rowsDrawY+i*14,actorTxt[i]);
		} else {
			draw_set_color(make_color_rgb(200,210,243)); // Light text
			
			draw_set_font(fontLight);
			draw_text(actorDrawX + 4,2-rowsDrawY+i*14,actorTxt[i]);
		}
	}
	
	#endregion
}

// Timeline rows
for (i = 0; i < rows; i += 1) {
	#region
	
	if y + 33 - rowsDrawY + i*14 > scrollHorBotBound {
		draw_set_color(col[1]);
		draw_rectangle(obj_panel_left.baseX,y+33-rowsDrawY+i*14,obj_panel_right.baseX,y+45-rowsDrawY+i*14,false);
		draw_rectangle(obj_panel_right.baseX,y+20,obj_panel_right.baseX,view_hport[1]-2,false);
		
		// Light gray
		draw_set_color(col[0]);
		draw_rectangle(obj_panel_left.baseX,y+46-rowsDrawY+i*14,obj_panel_right.baseX,y+46-rowsDrawY+i*14,false); // Timeline segment top outline
		draw_rectangle(obj_panel_left.baseX,y+32-rowsDrawY+i*14,obj_panel_right.baseX,y+32-rowsDrawY+i*14,false); // Timeline segment bot outline
		
		// Dark gray
		draw_set_color(col[2]);
		draw_rectangle(obj_panel_left.baseX,y+33-rowsDrawY+(i)*14,obj_panel_right.baseX,y+33-rowsDrawY+(i)*14,false); // Timeline segment
		
		if i = rows - 1 {
			// Cast a shadow onto streaks below the last row
			draw_rectangle(obj_panel_left.baseX+1,y+33-rowsDrawY+(i+1)*14,obj_panel_right.baseX,y+33-rowsDrawY+(i+1)*14,false); // Timeline segment
		}
	}
	
	#endregion
}

// Draw actions
for (i = 1; i <= totalActions; i += 1) {
	#region
	
	if y + 33 - rowsDrawY + i*14 > scrollHorBotBound {
		if actionInd[i] != -1 {
			if actionSelect[i] || actionDelete[i] || ( isPlayingScene && currentAction[actionRowInd[i]] = actionTime[i] ) {
				// Orange highlight
				draw_sprite_ext(spr_cutscene_action_second, 0, camera_get_view_x(obj_editor_gui.cameraLeftSubPanel) + view_wport[5] + actionTime[i]*6 + obj_subpanel_left.longestPanelRightButton, 1 + actionRowInd[i]*14 - rowsDrawY, 1, 1, 0, c_orange, 1);
			} else {
				// Typical
				draw_sprite_ext(spr_cutscene_action_second, 0, camera_get_view_x(obj_editor_gui.cameraLeftSubPanel) + view_wport[5] + actionTime[i]*6 + obj_subpanel_left.longestPanelRightButton, 1 + actionRowInd[i]*14 - rowsDrawY, 1, 1, 0, actionColInd[actionInd[i]], 1);
			}
		}
	}
	
	#endregion
}

// Draw time measure in play mode
if obj_editor_gui.mode = 2 {
	#region
	
	if isPlayingScene {
		if cutsceneInstanceId != -1 {
			draw_set_color(make_color_rgb(255,160,64)); // Orange
			draw_rectangle(obj_panel_left.baseX + cutsceneInstanceId.timeIndex, y+32, obj_panel_left.baseX + cutsceneInstanceId.timeIndex, y+32 + (rows)*14, false);
		}
	}
	
	#endregion
}

// Timeline ticks
draw_sprite_tiled_area(spr_editor_gui_streaks,0,0,0,obj_panel_left.baseX + 1,y + 18,obj_panel_right.baseX - 1,y + 31);
scrollOffDraw = ( ((scrollHorX - obj_panel_left.baseX - 1) / (scrollHorRightBound - scrollHorLeftBound)) * panelWidth ) % 60;

for (i = 0; i <= (view_get_wport(1) - 390) div 28; i += 1) {
	draw_sprite_ext(spr_timeline_tick,0,obj_panel_left.baseX + 3 + i*60 - scrollOffDraw,y + 21,2,1,0,c_white,1);
}

draw_set_color(col[0]);
draw_rectangle(obj_panel_left.baseX,scrollHorBotBound,obj_panel_left.baseX,scrollHorBotBound+12,false);
draw_rectangle(obj_panel_right.baseX,scrollHorBotBound,obj_panel_right.baseX,scrollHorBotBound+12,false);
draw_rectangle(obj_panel_left.baseX,scrollHorBotBound+13,obj_panel_right.baseX,scrollHorBotBound+13,false);

// Corners
draw_set_color(col[1]);
draw_rectangle(room_width + 3,y+4,obj_panel_left.baseX - 2,view_hport[1],false);
draw_rectangle(obj_panel_right.baseX + 2,y+4,room_width + view_wport[1]-3,view_hport[1],false);

// Outlines
draw_set_color(col[0]);
draw_rectangle(room_width,y,room_width + view_wport[1],y,false);
draw_rectangle(room_width,y,room_width,y+view_hport[1]-1,false);
draw_rectangle(room_width + view_wport[1]-1,y,room_width + view_wport[1],y+view_hport[1]-1,false);

draw_set_color(col[6]);
draw_rectangle(room_width, y+1,room_width + view_wport[1]-1,view_hport[1] - 1,true);
draw_rectangle(room_width + 1, y+2,room_width + view_wport[1] - 2,view_hport[1] - 2,true);

draw_set_color(col[2]);
draw_rectangle(room_width + 2,y+3,room_width + view_wport[1]-3,view_hport[1]-3,true);
draw_rectangle(obj_panel_left.baseX - 1,y+3,obj_panel_right.baseX + 1,view_hport[1]-3,true);

draw_set_color(make_color_rgb(38,43,50));
draw_rectangle(room_width + 6,y+29,obj_panel_left.baseX - 5,y+31,false);
draw_set_color(make_color_rgb(30,32,37));
draw_rectangle(room_width + 6,y+32,obj_panel_left.baseX - 5,y+33,false);

// Minimap
#region

gradientY[0] = 1; // Portion for dark
gradientY[1] = 0.88; // Portion for medium
gradientY[2] = 0.5; // Portion for light

// Draw map backdrop
draw_set_color(mapBackCol);
draw_rectangle(mapCenterX - floor(mapWidth/2) + 1,mapCenterY - floor(mapHeight/2) + 1,mapCenterX + floor(mapWidth/2) - 1,mapCenterY + floor(mapHeight/2) - 1,false);

// Minimap top edge
draw_sprite_ext(spr_minimap_vert,0,mapCenterX - floor((mapWidth-14)/2),mapCenterY - floor(mapHeight/2),mapWidth-14,1,0,c_white,1); // Top edge
draw_sprite_ext(spr_minimap_corner,0,mapCenterX - floor(mapWidth/2) + 8,mapCenterY - floor(mapHeight/2),1,1,0,c_white,1); // Top left corner
draw_sprite_ext(spr_minimap_corner,0,mapCenterX + floor(mapWidth/2) - 8,mapCenterY - floor(mapHeight/2),-1,1,0,c_white,1); // Top right corner

// Minimap bottom edge
draw_set_color(col[2]);
draw_rectangle(mapCenterX - floor((mapWidth-10)/2),mapCenterY + floor(mapHeight/2) - 6,mapCenterX + floor((mapWidth-10)/2),mapCenterY + floor(mapHeight/2) - 6,false);
draw_rectangle(mapCenterX + floor((mapWidth)/2) - 7,mapCenterY + floor(mapHeight/2) - 7,mapCenterX + floor((mapWidth)/2) - 7,mapCenterY + floor(mapHeight/2) - 7,false);
draw_rectangle(mapCenterX - floor((mapWidth)/2) + 6,mapCenterY + floor(mapHeight/2) - 7,mapCenterX - floor((mapWidth)/2) + 6,mapCenterY + floor(mapHeight/2) - 7,false);

for (i = 0; i <= 2; i += 1) {
	// Left edge
	draw_sprite_ext(spr_minimap_side,i,mapCenterX - floor((mapWidth-12)/2),mapCenterY - floor(mapHeight/2) + 8 + 1/(mapHeight*gradientY[i]),1,(mapHeight*gradientY[i]) - 15,0,c_white,1); // Left light edge
	
	// Right edge
	draw_sprite_ext(spr_minimap_side,i,mapCenterX + floor((mapWidth-12)/2),mapCenterY - floor(mapHeight/2) + 8 + 1/(mapHeight*gradientY[i]),-1,(mapHeight*gradientY[i]) - 15,0,c_white,1); // Right light edge
}

// Draw minimap contents
if surface_exists(mapSurface) {
	draw_surface_stretched(mapSurface, mapCenterX - floor(mapWidth/2) + 5, mapCenterY - floor(mapHeight/2) + 5, mapWidth - 10, mapHeight - 10);
}

// Draw map cursor
cursorX1 = mapCenterX - floor(mapWidth/2) + 5 + mapCursorX;
cursorX2 = mapCenterX - floor(mapWidth/2) + 5 + mapCursorX + mapCursorWidth;
cursorY1 = mapCenterY - floor(mapHeight/2) + 5 + mapCursorY;
cursorY2 = mapCenterY - floor(mapHeight/2) + 5 + mapCursorY + mapCursorHeight;

// Darks
	// Top
	draw_set_color(col[6]);
	draw_rectangle(cursorX1+2,cursorY1+1,cursorX2-2,cursorY1+1,false);
	draw_rectangle(cursorX1+1,cursorY1+2,cursorX1+1,cursorY1+2,false);
	draw_rectangle(cursorX2-1,cursorY1+2,cursorX2-1,cursorY1+2,false);
	
	draw_set_color(col[2]);
	draw_rectangle(cursorX1+2,cursorY1+2,cursorX2-2,cursorY1+2,false);
	draw_rectangle(cursorX1+1,cursorY1+3,cursorX1+1,cursorY1+3,false);
	draw_rectangle(cursorX2-1,cursorY1+3,cursorX2-1,cursorY1+3,false);
	
	// Bottom
	draw_set_color(col[6]);
	draw_rectangle(cursorX1+1,cursorY2+1,cursorX2-1,cursorY2+1,false);
	draw_rectangle(cursorX1,cursorY2,cursorX1,cursorY2,false);
	draw_rectangle(cursorX2,cursorY2,cursorX2,cursorY2,false);
	
	draw_set_color(col[2]);
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

#endregion

// Draw scrollbars and slider
event_inherited();

//}

draw_sprite_ext(sprite_index,image_index,x,y+1,image_xscale,image_yscale,image_angle,c_white,1);
