/// @description 

// Draw backdrop
draw_sprite_tiled_area(spr_editor_gui_streaks,0,x,y,x,y,x+boxWidth,y+boxHeight);

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
for ( i = 0; i <= bubbleCount; i += 1 ) {
	#region
	
	draw_set_color(make_color_rgb(20,22,33));
	draw_rectangle(x+14+bubbleX[i],y+14+bubbleY[i],x+1+bubbleX[i]+longestLine[i],y+1+bubbleY[i]+lineCount[i]*10,false);
	
	draw_sprite(spr_dia_box_tl,0,x+1+bubbleX[i],y+1+bubbleY[i]);
	draw_sprite(spr_dia_box_tr,0,x+3+bubbleX[i]+longestLine[i]-9,y+1+bubbleY[i]);
	draw_sprite(spr_dia_box_bl,0,x+1+bubbleX[i],y+2+bubbleY[i]+lineCount[i]*10);
	draw_sprite(spr_dia_box_br,0,x+3+bubbleX[i]+longestLine[i]-9,y+2+bubbleY[i]+lineCount[i]*10);
	
	draw_sprite_ext(spr_dia_box_top,0,x+14+bubbleX[i],y+1+bubbleY[i],(-6+bubbleX[i]+longestLine[i]) - (14+bubbleX[i]),1,0,c_white,1);
	draw_sprite_ext(spr_dia_box_bot,0,x+14+bubbleX[i],y+2+bubbleY[i]+lineCount[i]*10,(-6+bubbleX[i]+longestLine[i]) - (14+bubbleX[i]),1,0,c_white,1);
	
	draw_sprite_ext(spr_dia_box_left,0,x+1+bubbleX[i],y+14+bubbleY[i],1,-12+lineCount[i]*10,0,c_white,1);
	draw_sprite_ext(spr_dia_box_right,0,x+3+bubbleX[i]+longestLine[i]-9,y+14+bubbleY[i],1,-12+lineCount[i]*10,0,c_white,1);
	
	draw_set_font(font);
	draw_set_color(col[2]); // Font color
	
	for ( j = 0; j <= lineCount[i]; j += 1 ) {
		draw_text(x+4+bubbleX[i],y+4+bubbleY[i]+j*10,lineStr[i,j]);
		
		// Draw cursor
		if cursorBubble = i {
			if cursorLine = j {
				draw_set_color(col[4]); // Yellow
				
				draw_rectangle(x+4+bubbleX[i]+cursorPlacePix,y+bubbleY[i]+3+j*10,x+bubbleX[i]+4+cursorPlacePix,y+12+bubbleY[i]+j*10,false);
				
				draw_set_color(col[2]); // Reset color
			}
		}
	}
	
	#endregion
}

// Draw scrollbars
event_inherited();
