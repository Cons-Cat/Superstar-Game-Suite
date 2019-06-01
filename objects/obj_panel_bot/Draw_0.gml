/// @description Insert description here
draw_sprite_tiled_area(spr_editor_gui_streaks,0,0,0,193,y,view_get_wport(1)-193,view_get_hport(1));

// Timeline ticks
scrollOffDraw = ( ((scrollHorX - 193)/(scrollHorRightBound - scrollHorLeftBound))*panelWidth ) % 60;

for (i = 0; i <= (view_get_wport(1) - 390) div 28; i += 1) {
	draw_sprite_ext(spr_timeline_tick,0,195 + i*60 - scrollOffDraw,y + 21,2,1,0,c_white,1);
}

// Inside outline
draw_set_color(make_color_rgb(63,70,87));
draw_rectangle(192,y+20,192,view_hport[1]-2,false);
draw_rectangle(view_get_wport(1)-192,y+20,view_get_wport(1)-192,view_hport[1]-2,false);

for (i = 0; i < rows; i += 1) {
	draw_set_color(make_color_rgb(35,38,45));
	draw_rectangle(192,y+33+i*14,view_get_wport(1)-192,y+45+i*14,false);
	
	// Light gray
	draw_set_color(make_color_rgb(63,70,87));
	draw_rectangle(192,y+46+i*14,view_get_wport(1)-192,y+46+i*14,false); // Timeline segment top outline
	draw_rectangle(192,y+32+i*14,view_get_wport(1)-192,y+32+i*14,false); // Timeline segment bot outline
	
	// Dark gray
	draw_set_color(make_color_rgb(31,34,40));
	draw_rectangle(192,y+33+i*14,view_get_wport(1)-192,y+33+i*14,false); // Timeline segment
}

// Draw actions
for (i = 1; i <= totalActions; i += 1) {
	//if 193 + actionTime[i]*6 - scrollOffAction >= 187 && 193 + actionTime[i]*6 - scrollOffAction <= view_get_wport(1) - 192 {
		if actionInd[i] != -1 {
			draw_sprite_ext(spr_cutscene_action_second, 0, view_wport[1] + view_wport[2] + view_wport[3] + view_wport[5] + 1 + actionTime[i]*6, actionRowInd[i]*14, 1, 1, 0, actionColorDraw[i], 1);
		}
	//}
}

// Corners
draw_set_color(make_color_rgb(35,38,45));
draw_rectangle(3,y+4,190,view_hport[1],false);
draw_rectangle(view_wport[1]-190,y+4,view_wport[1]-3,view_hport[1],false);

// Outlines
if y < view_hport[1] {
	draw_set_color(make_color_rgb(63,70,87));
	draw_rectangle(0,y,view_wport[1],y,false);
	draw_rectangle(0,y,0,y+view_hport[1]-1,false);
	draw_rectangle(view_wport[1]-1,y,view_wport[1],y+view_hport[1]-1,false);
	
	draw_set_color(make_color_rgb(28,30,36));
	draw_rectangle(0,y+1,view_wport[1],view_hport[1]-1,true);
	draw_rectangle(1,y+2,view_wport[1]-1,view_hport[1]-2,true);
	
	draw_set_color(make_color_rgb(31,34,40));
	draw_rectangle(2,y+3,view_wport[1]-2,view_hport[1]-3,true);
	draw_rectangle(191,y+3,view_wport[1]-191,view_hport[1]-3,true);
	
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

/*draw_set_color(c_red);
draw_set_alpha(0.5);
draw_rectangle(camera_get_view_x(obj_editor_gui.cameraBotPanel),camera_get_view_y(obj_editor_gui.cameraBotPanel),camera_get_view_x(obj_editor_gui.cameraBotPanel)+camera_get_view_width(obj_editor_gui.cameraBotPanel),10,false);
draw_set_alpha(1);*/
