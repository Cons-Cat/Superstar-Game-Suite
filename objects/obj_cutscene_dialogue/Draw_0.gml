/// @description 

// Draw backdrop
draw_sprite_tiled_area(spr_editor_gui_streaks,0,0,0,x,y,x+boxWidth,y+boxHeight);

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
	draw_rectangle(scrollVerRightBound+1,y-1,scrollVerRightBound+1,y+1+boxHeight,false);
	
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
	draw_rectangle(scrollVerRightBound+2,y-2,scrollVerRightBound+2,y+2+boxHeight,false);
	
	// Medium horizontals
	draw_rectangle(x-2,y-3,scrollVerRightBound+1,y-3,false);
	draw_rectangle(x-2,y+3+boxHeight,scrollVerRightBound+1,y+3+boxHeight,false);
	
	// Medium corners
	draw_rectangle(x-2,y-2,x-2,y-1,false);
	draw_rectangle(x-2,y+2+boxHeight,x-2,y+1+boxHeight,false);
	draw_rectangle(scrollVerRightBound+1,y-2,scrollVerRightBound+1,y-2,false);
	draw_rectangle(scrollVerRightBound+1,y+2+boxHeight,scrollVerRightBound+1,y+2+boxHeight,false);
	
#endregion

// Draw dialogue surface
if surface_exists(diaSurface) {
	#region
	
	surface_set_target(diaSurface);
	draw_clear_alpha(c_white,0);
	
	for ( i = 0; i <= bubbleCount; i += 1 ) {
		// Draw sliders
		#region
		
		// Left slider
		if sliderMagnitude[i,0] > 0 {
			draw_sprite_ext(spr_dia_slider_top,selectBubSlider[i,0],bubbleX[i] + 9 - ( 7 * sliderMagnitude[i,0] ),bubbleY[i]+3,-1,1,0,c_white,1);
			draw_sprite_ext(spr_dia_slider_mid,selectBubSlider[i,0],bubbleX[i] + 9 - ( 7 * sliderMagnitude[i,0] ),bubbleY[i]+5,-1,(lineCount[i] + 1)*10-3,0,c_white,1);
			
			if lineCount[i] > 0 {
				draw_sprite_ext(spr_dia_slider_bot,selectBubSlider[i,0],bubbleX[i] + 9 - ( 7 * sliderMagnitude[i,0] ),bubbleY[i]+1+(lineCount[i] + 1)*10,-1,1,0,c_white,1);
			} else {
				draw_sprite_ext(spr_dia_slider_bot,selectBubSlider[i,0],bubbleX[i] + 9 - ( 7 * sliderMagnitude[i,0] ),bubbleY[i]+2+(lineCount[i] + 1)*10,-1,1,0,c_white,1);
			}
			
			draw_sprite_ext(spr_dia_slider_icon,selectBubSlider[i,0],bubbleX[i] + 9 - ( 7 * sliderMagnitude[i,0] ),bubbleY[i]+2+(lineCount[i] + 1)*5,-1,1,0,c_white,1);
		}
		
		// Right slider
		if sliderMagnitude[i,1] > 0 {
			draw_sprite_ext(spr_dia_slider_top,selectBubSlider[i,1],bubbleX[i] + 4 - 7 + ( 7 * sliderMagnitude[i,1] )+longestLine[i],bubbleY[i]+3,1,1,0,c_white,1);
			draw_sprite_ext(spr_dia_slider_mid,selectBubSlider[i,1],bubbleX[i] + 4 - 7 + ( 7 * sliderMagnitude[i,1] )+longestLine[i],bubbleY[i]+5,1,(lineCount[i] + 1)*10-3,0,c_white,1);
			
			if lineCount[i] > 0 {
				draw_sprite_ext(spr_dia_slider_bot,selectBubSlider[i,1],bubbleX[i] + 4 - 7 + ( 7 * sliderMagnitude[i,1] )+longestLine[i],bubbleY[i]+1+(lineCount[i] + 1)*10,1,1,0,c_white,1);
			} else {
				draw_sprite_ext(spr_dia_slider_bot,selectBubSlider[i,1],bubbleX[i] + 4 - 7 + ( 7 * sliderMagnitude[i,1] )+longestLine[i],bubbleY[i]+2+(lineCount[i] + 1)*10,1,1,0,c_white,1);
			}
			
			draw_sprite_ext(spr_dia_slider_icon,selectBubSlider[i,0],bubbleX[i] + 4 - 7 + ( 7 * sliderMagnitude[i,1] )+longestLine[i],bubbleY[i]+2+(lineCount[i] + 1)*5,1,1,0,c_white,1);
		}
		
		// Top slider
		if sliderMagnitude[i,2] > 0 {
			draw_sprite_ext(spr_dia_slider_top,selectBubSlider[i,2],bubbleX[i] + 2, bubbleY[i] + 9 - (7 * sliderMagnitude[i,2]),1,1,90,c_white,1);
			draw_sprite_ext(spr_dia_slider_bot,selectBubSlider[i,2],bubbleX[i]+longestLine[i] + 2, bubbleY[i] + 9 - (7 * sliderMagnitude[i,2]),1,1,90,c_white,1);
			draw_sprite_ext(spr_dia_slider_mid,selectBubSlider[i,2],bubbleX[i] + 4, bubbleY[i] + 9 - (7 * sliderMagnitude[i,2]),1,longestLine[i] - 3,90,c_white,1);
			
			draw_sprite_ext(spr_dia_slider_icon,selectBubSlider[i,0],bubbleX[i]+floor(longestLine[i]/2) + 3,bubbleY[i] + 9 - (7 * sliderMagnitude[i,2]),1,1,90,c_white,1);
		}
		
		// Bottom slider
		if sliderMagnitude[i,3] > 0 {
			draw_sprite_ext(spr_dia_slider_bot,selectBubSlider[i,3],bubbleX[i] + 4, bubbleY[i] + 7 + lineCount[i]*10 + (7 * sliderMagnitude[i,3]),1,1,270,c_white,1);
			draw_sprite_ext(spr_dia_slider_top,selectBubSlider[i,3],bubbleX[i]+longestLine[i] + 3, bubbleY[i] + 7 + lineCount[i]*10 + (7 * sliderMagnitude[i,3]),1,1,270,c_white,1);
			draw_sprite_ext(spr_dia_slider_mid,selectBubSlider[i,3],bubbleX[i]+longestLine[i] + 1, bubbleY[i] + 7 + lineCount[i]*10 + (7 * sliderMagnitude[i,3]),1,longestLine[i] - 4,270,c_white,1);
			
			draw_sprite_ext(spr_dia_slider_icon,selectBubSlider[i,0],bubbleX[i]+floor(longestLine[i]/2) + 4,bubbleY[i] + 7 + lineCount[i]*10 + (7 * sliderMagnitude[i,3]),1,1,270,c_white,1);
		}
		
		#endregion
		
		// Draw bubbles
		#region
		
		if lineCount[i] = 0 {
			// Draw log bubble
			draw_sprite_ext(spr_dia_log_center,0,13+bubbleX[i],bubbleY[i],(-6+bubbleX[i]+longestLine[i]) - (14+bubbleX[i]),1,0,c_white,1);
			draw_sprite(spr_dia_log_left,0,bubbleX[i],bubbleY[i]);
			draw_sprite(spr_dia_log_right,0,2+bubbleX[i]+longestLine[i]-9,bubbleY[i]);
		} else {
			// Draw rectangular bubble
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
		
		#endregion
		
		draw_set_font(font);
		draw_set_color(col[2]); // Font color
		
		for ( j = 0; j <= lineCount[i]; j += 1 ) {
			if hasText[i] {
				// Draw text
				if lineCount[i] = 0 {
					draw_text(3+bubbleX[i],3+bubbleY[i]+1+j*10,lineStr[i,j]);
				} else {
					draw_text(3+bubbleX[i],3+bubbleY[i]+j*10,lineStr[i,j]);
				}
			} else {
				// Draw placeholder text
				draw_set_alpha(0.65);
				draw_text(3+bubbleX[i], 3+bubbleY[i], "Text.");
				draw_set_alpha(1);
			}
			
			// Draw cursor
			if cursorBubble = i {
				#region
				
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
					if i = cursorBubble {
						var ii = cursorPlaceChar;
						var jj = cursorPlaceLine;
						
						// Iterate through highlighted characters in lines
						while !( ii = cursorPlaceSelectionChar && jj = cursorPlaceSelectionLine ) {
							if ii < string_length(lineStr[i,jj]) {
								ii += 1;
							} else {
								ii = 0;
								jj += 1;
								
								// Skip blank lines
								if lineStr[i,jj] = "" {
									if jj < lineCount[i] {
										continue;
									} else {
										break;
									}
								}
							}
							
							// Highlight the width of each selected character
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
				
				#endregion
			}
		}
	}
	
	surface_reset_target();
	
	draw_surface_part(diaSurface,0,surfaceScrollOff,surface_get_width(diaSurface),boxHeight-1,x+1,y+1);
	
	#endregion
}

// Draw scrollbars
event_inherited();

// Draw buttons box
#region

if buttonsAnchorRight {
	draw_sprite_tiled_area(spr_editor_gui_streaks,0,0,0,scrollVerRightBound+5,y,scrollVerRightBound+sprite_get_width(spr_dia_buttons_box)-2,y+sprite_get_height(spr_dia_buttons_box)-4);
	draw_sprite(spr_dia_buttons_box,canSelectBox,scrollVerRightBound+3,y-3);
} else {
	draw_sprite_tiled_area(spr_editor_gui_streaks,0,0,0,x-38,y,x-45+sprite_get_width(spr_dia_buttons_box),y+sprite_get_height(spr_dia_buttons_box)-4);
	draw_sprite(spr_dia_buttons_box,canSelectBox,x-40,y-3);
}

#endregion

// Draw buttons
for (i = 0; i <= 1; i += 1) {
	for (j = 0; j <= 3; j += 1) {
		if buttonsAnchorRight {
			draw_sprite(buttonSprite[i,j],canSelectButtonState[i,j], scrollVerRightBound + 6 + i*16, y + 1 + j*16);
		} else {
			draw_sprite(buttonSprite[i,j],canSelectButtonState[i,j], x - 37 + i*16, y + 1 + j*16);
		}
	}
}
