/// @description Insert description here
surface_resize(application_surface,camera_get_view_width(obj_editor_gui.camera),camera_get_view_height(obj_editor_gui.camera));
draw_sprite_part(spr_editor_gui_streaks,0,192,y,641,576-y,192,y);

// Timeline ticks
scrollOffDraw = ((scrollHorX-scrollHorLeftBound)/scrollHorFactor) %	56;
scrollOffAction = ((scrollHorX-scrollHorLeftBound)/scrollHorFactor)

if rows > 0 {
	for (i = 0; i <= 12; i += 1) {
		draw_sprite_ext(spr_timeline_tick,0,195 + i*60 - scrollOffDraw,y + 21,2,1,0,c_white,1);
	}
	
	for (i = 0; i < rows; i += 1) {
		draw_set_color(make_color_rgb(35,38,45));
		draw_rectangle(192,y+33+i*14,832,y+45+i*14,false);
		
		// Light gray
		draw_set_color(make_color_rgb(63,70,87));
		draw_rectangle(192,y+46+i*14,832,y+46+i*14,false); // Timeline segment
		draw_rectangle(192,y+32+i*14,832,y+32+i*14,false); // Timeline segment
		
		// Dark gray
		draw_set_color(make_color_rgb(31,34,40));
		draw_rectangle(192,y+33+i*14,832,y+33+i*14,false); // Timeline segment
	}
	
	// Draw actions
	for (i = 1; i <= totalActions; i += 1) {
		if 193 + actionTime[i]*6 - scrollOffAction >= 187 && 193 + actionTime[i]*6 - scrollOffAction <= 832 {
			if actionInd[i] != -1 {
				draw_sprite_ext(spr_cutscene_action_second,0,193+actionTime[i]*6-scrollOffAction,y+35+actionRowInd[i]*14,1,1,0,actionColorDraw[i],1);
			}
		}
	}
}

// Corners
draw_set_color(make_color_rgb(35,38,45));
draw_rectangle(3,y+4,3+187,576,false);
draw_rectangle(834,y+4,834+187,576,false);

// Outlines
if y < 576 {
	draw_set_color(make_color_rgb(63,70,87));
	draw_rectangle(0,y,1024,y,false);
	draw_rectangle(0,y,0,y+575,false);
	draw_rectangle(1023,y,1024,y+575,false);
	
	draw_set_color(make_color_rgb(28,30,36));
	draw_rectangle(0,y+1,1024,575,true);
	draw_rectangle(1,y+2,1023,574,true);
	
	draw_set_color(make_color_rgb(31,34,40));
	draw_rectangle(2,y+3,1022,573,true);
	draw_rectangle(191,y+3,190+643,573,true);
	
	draw_set_color(make_color_rgb(38,43,50));
	draw_rectangle(6,y+29,187,y+31,false);
	draw_set_color(make_color_rgb(30,32,37));
	draw_rectangle(6,y+32,187,y+33,false);
}

if rows > 0 {
	for (i = 0; i < rows; i += 1) {
		// Light gray
		draw_set_color(make_color_rgb(63,70,87));
		draw_rectangle(3,y+46+i*14,190,y+46+i*14,false); // Actor segment
		
		// Dark gray
		draw_set_color(make_color_rgb(31,34,40));
		draw_rectangle(3,y+47+i*14,190,y+47+i*14,false); // Actor segment
		
		// Text
		if selectRow[i] || canSelectRow[i] {
			draw_set_color(make_color_rgb(255,160,64)); // Orange
			draw_rectangle(21,y+35+i*14,190,y+46+i*14,false);
			
			draw_set_font(fontDark);
			draw_text(23,y+36+i*14,actorTxt[i]);
		} else {
			draw_set_color(make_color_rgb(200,210,243)); // Light text
			
			draw_set_font(fontLight);
			draw_text(23,y+36+i*14,actorTxt[i]);
		}
	}
}

event_inherited();
draw_sprite_ext(sprite_index,image_index,x,y+1,image_xscale,image_yscale,image_angle,c_white,1);
