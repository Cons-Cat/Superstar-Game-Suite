/// @description 
subPointDisplacement = 0;

for (i = 0; i < array_height_2d(list); i += 1) {
	draw_sprite_ext(spr_point,0,x + 15, y + 6 + i *10+subPointDisplacement,1,1,0,col,1);
	draw_sprite_ext(spr_layer_eye,eyeState[i],x + 6, y + 6 + i *10+subPointDisplacement,1,1,0,eyeCol[i],1);
	
	if canSelect[i,0] || select[i,0] {
		draw_set_color(orange);
		draw_rectangle(x+19,y+2+i*10+subPointDisplacement,x+19+string_width(list[i,0]),y+11+i*10+subPointDisplacement,false);
		
		draw_set_font(obj_editor_gui.fontDark);
		draw_set_color(orange);
		
		draw_text(x + 19,y + 2 + i *10+subPointDisplacement,list[i,0]);
	} else {
		draw_set_font(obj_editor_gui.font);
		draw_set_color(col);
		
		draw_text(x + 19,y + 2 + i *10+subPointDisplacement,list[i,0]);
	}
	
	draw_sprite_ext(spr_point,0,x + 22, y + 18 + i *10+subPointDisplacement,1,1,0,col,1);
	
	for (j = 1; j < array_length_2d(list,i); j += 1) {
		if canSelect[i,j] || select[i,j] {
			draw_set_color(orange);
			draw_rectangle(x + 25, 2 + (i * 10) + (j * 11)+subPointDisplacement, x + 25 + string_width(list[i,j]), 11 + (i * 10) + (j * 11)+subPointDisplacement, false);
			
			draw_set_font(obj_editor_gui.fontDark);
			draw_set_color(orange);
			
			draw_text(x + 25,y + 2 + (i * 10) + (j * 11)+subPointDisplacement,list[i,j]);
		} else {
			draw_set_font(obj_editor_gui.font);
			draw_set_color(col);
			
			draw_text(x + 25,y + 2 + (i * 10) + (j * 11)+subPointDisplacement,list[i,j]);
		}
		
		draw_sprite_ext(spr_point,0,x + 22, y + 18 + (i * 10) + ( (j - 1) * 11 ) + subPointDisplacement,1,1,0,col,1);
	}
	
	subPointDisplacement += (array_length_2d(list,i) - 1) * 11;
}

// New layer icons
draw_sprite_ext(spr_layer_plus,0,x + 15, y + 6 + (array_height_2d(list) * 10) + subPointDisplacement,1,1,0,plusCol,1);
draw_sprite_ext(spr_layer_die,0,x + 25, y + 6 + (array_height_2d(list) * 10) + subPointDisplacement,1,1,0,dieCol,1);
