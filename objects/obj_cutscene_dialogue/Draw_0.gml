/// @description 

// Draw backdrop
draw_sprite_tiled_area(spr_editor_gui_streaks,0,x,y,x,y,x+boxWidth,y+boxHeight);

if surface_exists(diaSurface) {
}

// Draw outline
draw_set_color(col[0]); // Dark
#region

	// Dark verticals
	draw_rectangle(x-1,y,x-1,y+boxHeight,false);
	
	// Dark horizontals
	draw_rectangle(x-1,y-1,x+boxWidth,y-1,false);
	draw_rectangle(x-1,y+1+boxHeight,x+boxWidth,y+1+boxHeight,false);
	
	// Dark corners
	draw_rectangle(x,y,x,y,false);
	draw_rectangle(x,y+boxHeight,x,y+boxHeight,false);
	draw_rectangle(x,y+boxHeight,x,y+boxHeight,false);
	draw_rectangle(x+boxWidth,y+boxHeight,x+boxWidth,y+boxHeight,false);

#endregion

draw_set_color(outlineCol[1]); // Bright outline
#region

	// Bright verticals
	draw_rectangle(x-2,y,x-2,y+boxHeight,false);
	draw_rectangle(x+boxWidth+scrollVerRightBound-scrollVerLeftBound+1,y-1,x+boxWidth+scrollVerRightBound-scrollVerLeftBound+1,y+1+boxHeight,false);
	
	// Bright horizontals
	draw_rectangle(x-1,y-2,scrollVerRightBound,y-2,false);
	draw_rectangle(x-1,y+2+boxHeight,scrollVerRightBound,y+2+boxHeight,false);
	
	// Bright corners
	draw_rectangle(x-1,y-1,x-1,y-1,false);
	draw_rectangle(x-1,y+1+boxHeight,x-1,y+1+boxHeight,false);
	
#endregion

draw_set_color(outlineCol[0]); // Dark outline
#region

	// Medium verticals
	draw_rectangle(x-3,y-1,x-3,y+boxHeight+1,false);
	draw_rectangle(x+boxWidth+scrollVerRightBound-scrollVerLeftBound+2,y-2,x+boxWidth+scrollVerRightBound-scrollVerLeftBound+2,y+2+boxHeight,false);
	
	// Medium horizontals
	draw_rectangle(x-2,y-3,scrollVerRightBound+1,y-3,false);
	draw_rectangle(x-2,y+3+boxHeight,scrollVerRightBound+1,y+3+boxHeight,false);
	
	// Medium corners
	draw_rectangle(x-2,y-2,x-2,y-1,false);
	draw_rectangle(x-2,y+2+boxHeight,x-2,y+1+boxHeight,false);
	draw_rectangle(x+boxWidth+scrollVerRightBound-scrollVerLeftBound+1,y-2,x+boxWidth+scrollVerRightBound-scrollVerLeftBound+1,y-2,false);
	draw_rectangle(x+boxWidth+scrollVerRightBound-scrollVerLeftBound+1,y+2+boxHeight,x+boxWidth+scrollVerRightBound-scrollVerLeftBound+1,y+2+boxHeight,false);
	
#endregion

// Draw dialogue bubbles
if surface_exists(diaSurface) {
	surface_set_target(diaSurface);
	draw_clear_alpha(c_white,0);
	
	// Draw sliders
	#region
	
	for ( i = 0; i <= bubbleCount; i += 1 ) {
		// Left slider
		if canSelectBubState[i] = 0 {
			draw_sprite_ext(spr_dia_slider,0,bubbleX[i] + 2 - ( 7 * sliderMagnitude ),bubbleY[i]+3,-1,1,0,c_white,1);
			draw_sprite_ext(spr_dia_slider,2,bubbleX[i] + 2 - ( 7 * sliderMagnitude ),bubbleY[i]+2+(lineCount[i] + 1)*10,-1,1,0,c_white,1);
			draw_sprite_ext(spr_dia_slider,1,bubbleX[i] + 2 - ( 7 * sliderMagnitude ),bubbleY[i]+4,-1,(lineCount[i] + 1)*10-2,0,c_white,1);
		}
		// Right slider
		if canSelectBubState[i] = 1 {
			draw_sprite_ext(spr_dia_slider,0,bubbleX[i] + 3 - 7 + ( 7 * sliderMagnitude )+longestLine[i],bubbleY[i]+3,1,1,0,c_white,1);
			draw_sprite_ext(spr_dia_slider,2,bubbleX[i] + 3 - 7 + ( 7 * sliderMagnitude )+longestLine[i],bubbleY[i]+2+(lineCount[i] + 1)*10,1,1,0,c_white,1);
			draw_sprite_ext(spr_dia_slider,1,bubbleX[i] + 3 - 7 + ( 7 * sliderMagnitude )+longestLine[i],bubbleY[i]+4,1,(lineCount[i] + 1)*10-2,0,c_white,1);
		}
	}
	
	#endregion
	
	for ( i = 0; i <= bubbleCount; i += 1 ) {
		#region
		
		if lineCount[i] = 0 {
			// Draw log box
			draw_sprite_ext(spr_dia_log_center,0,13+bubbleX[i],bubbleY[i],(-6+bubbleX[i]+longestLine[i]) - (14+bubbleX[i]),1,0,c_white,1);
			draw_sprite(spr_dia_log_left,0,bubbleX[i],bubbleY[i]);
			draw_sprite(spr_dia_log_right,0,2+bubbleX[i]+longestLine[i]-9,bubbleY[i]);
		} else {
			// Draw rectangular box
			draw_set_color(make_color_rgb(20,22,33));
			draw_rectangle(13+bubbleX[i],13+bubbleY[i],bubbleX[i]+longestLine[i],bubbleY[i]+lineCount[i]*10,false);
			
			draw_sprite(spr_dia_box_tl,0,bubbleX[i],bubbleY[i]);
			draw_sprite(spr_dia_box_tr,0,2+bubbleX[i]+longestLine[i]-9,+bubbleY[i]);
			draw_sprite(spr_dia_box_bl,0,bubbleX[i],1+bubbleY[i]+lineCount[i]*10);
			draw_sprite(spr_dia_box_br,0,2+bubbleX[i]+longestLine[i]-9,1+bubbleY[i]+lineCount[i]*10);
			
			draw_sprite_ext(spr_dia_box_top,0,13+bubbleX[i],bubbleY[i],(-6+bubbleX[i]+longestLine[i]) - (14+bubbleX[i]),1,0,c_white,1);
			draw_sprite_ext(spr_dia_box_bot,0,13+bubbleX[i],1+bubbleY[i]+lineCount[i]*10,(-6+bubbleX[i]+longestLine[i]) - (14+bubbleX[i]),1,0,c_white,1);
			
			draw_sprite_ext(spr_dia_box_left,0,bubbleX[i],13+bubbleY[i],1,-12+lineCount[i]*10,0,c_white,1);
			draw_sprite_ext(spr_dia_box_right,0,2+bubbleX[i]+longestLine[i]-9,13+bubbleY[i],1,-12+lineCount[i]*10,0,c_white,1);
		}
		
		draw_set_font(font);
		draw_set_color(col[2]); // Font color
		
		for ( j = 0; j <= lineCount[i]; j += 1 ) {
			if lineCount[i] = 0 {
				draw_text(3+bubbleX[i],3+bubbleY[i]+1+j*10,lineStr[i,j]);
			} else {
				draw_text(3+bubbleX[i],3+bubbleY[i]+j*10,lineStr[i,j]);
			}
			
			// Draw cursor
			if cursorBubble = i {
				// Idle cursor
				if cursorState = 0 {
					if cursorPlaceLine = j {
						draw_set_color(col[4]); // Yellow
						
						if lineCount[i] = 0 {
							draw_rectangle(3+bubbleX[i]+cursorPlacePix,2+bubbleY[i]+1+j*10,bubbleX[i]+3+cursorPlacePix,11+bubbleY[i]+1+j*10,false);
						} else {
							draw_rectangle(3+bubbleX[i]+cursorPlacePix,2+bubbleY[i]+j*10,bubbleX[i]+3+cursorPlacePix,11+bubbleY[i]+j*10,false);
						}
						
						draw_set_color(col[2]); // Reset color
					}
				}
				
				// Highlight cursor
				if cursorState = 1 {
					var ii = cursorPlaceChar;
					var jj = cursorPlaceLine;
					
					// Iterate through highlighted characters in lines
					while !( ii = cursorPlaceSelectionChar && jj = cursorPlaceSelectionLine ) {
						if ii < string_length(lineStr[i,jj]) {
							ii += 1;
						} else {
							ii = 0;
							jj += 1;
						}
						
						iiXPix = string_width(string_copy(lineStr[i,jj],1,ii-1));
						iiWPix = string_width(string_char_at(lineStr[i,jj],ii))-1;
						
						// Highlight character
						draw_set_color(col[4]); // Yellow
						draw_set_font(obj_editor_gui.fontDark);
						draw_rectangle(3+bubbleX[i]+iiXPix,2+bubbleY[i]+1+jj*10,bubbleX[i]+3+iiXPix+iiWPix,11+bubbleY[i]+1+jj*10,false);
						
						draw_text(3+bubbleX[i]+iiXPix,3+bubbleY[i]+jj*10,string_char_at(lineStr[i,jj],ii));
					}
					
					draw_set_color(col[2]); // Reset color
					draw_set_font(obj_editor_gui.font); // Reset font
				}
			}
		}
		
		#endregion
	}
	
	surface_reset_target();
	
	draw_surface_part(diaSurface,0,surfaceScrollOff,surface_get_width(diaSurface),boxHeight-1,x+1,y+1);
}

// Draw scrollbars
event_inherited();
