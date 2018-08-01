/// @description Draw GUI
// Draw left-side buttons
draw_sprite_ext(spr_timeline_buttons,0,x,y,1,1,0,selectButCol[1],menuAlpha); // Draw talk button
draw_sprite_ext(spr_timeline_buttons,1,x,y+10,1,1,0,selectButCol[2],menuAlpha); // Draw walk button
draw_sprite_ext(spr_timeline_buttons,2,x,y+20,1,1,0,selectButCol[3],menuAlpha); // Draw wait button
draw_sprite_ext(spr_timeline_buttons,6,x,y+30,1,1,0,selectButCol[4],menuAlpha); // Draw exit button

draw_sprite_ext(spr_timeline_numbers,10,x+23,y,5,1,0,c_white,menuAlpha);

// Draw timeline
for (i = 1; i <= rows; i += 1) {
	if i < 10 {
		draw_sprite_ext(spr_timeline_numbers,i,x+23,y+(i-1)*10+10,1,1,0,selectNumCol[i],menuAlpha);
		draw_sprite_ext(spr_timeline_numbers,10,x+33,y+(i-1)*10-(i div 10)*100+10,1,1,0,selectNumCol[i],menuAlpha);
	} else {
		draw_sprite_ext(spr_timeline_numbers,i div 10,x+23+(i div 10)*43,y+(i-1)*10-(i div 10)*100+10,1,1,0,selectNumCol[i],menuAlpha);
		draw_sprite_ext(spr_timeline_numbers,i % 10,x+33+(i div 10)*43,y+(i-1)*10-(i div 10)*100+10,1,1,0,selectNumCol[i],menuAlpha);
	}
	
	if rowSetting[i] = 0 {
		// Blank
		draw_sprite_ext(spr_timeline_buttons,5,x+43+(i div 10)*43,y+(i-1)*10-(i div 10)*100+10,1,1,0,selectButTimelineCol[i],menuAlpha);
	}
	if rowSetting[i] = 1 {
		// Talk
		draw_sprite_ext(spr_timeline_buttons,0,x+43+(i div 10)*43,y+(i-1)*10-(i div 10)*100+10,1,1,0,selectButTimelineCol[i],menuAlpha);
	}
	if rowSetting[i] = 2 {
		// Walk
		draw_sprite_ext(spr_timeline_buttons,1,x+43+(i div 10)*43,y+(i-1)*10-(i div 10)*100+10,1,1,0,selectButTimelineCol[i],menuAlpha);
	}
	if rowSetting[i] = 3 {
		// Wait
		draw_sprite_ext(spr_timeline_buttons,2,x+43+(i div 10)*43,y+(i-1)*10-(i div 10)*100+10,1,1,0,selectButTimelineCol[i],menuAlpha);
	}
}
