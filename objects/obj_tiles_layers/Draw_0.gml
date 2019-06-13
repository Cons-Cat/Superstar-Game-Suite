/// @description 
subPointDisplacement = 0;

for (i = 0; i < array_height_2d(layerName); i += 1) {
	draw_sprite_ext(spr_layer_rack,0,x + 12, y + i*21,1,1,0,col,1);
	
	if i != array_height_2d(layerName) - 1 {
		draw_sprite_ext(spr_layer_rack,0,x + 12, y + (i+0.5)*21,1,1,0,col,1);
	}
	
	draw_sprite_ext(spr_point,0,x + 31, y + 6 + layerOrder[i] * 21,1,1,0,col,layerAlpha[i]);
	draw_sprite_ext(spr_layer_eye,eyeState[i],x + 22, y + 6 + layerOrder[i] *21,1,1,0,eyeCol[i],1);
	
	draw_sprite_ext(spr_layer_slot,0,x + 2, y + 1 + i*21,1,1,0,col,1);
	//draw_sprite_ext(spr_layer_slot,0,x + 2, y + 2 + (i+2)*10 + subPointDisplacement,1,1,0,col,1);
	
	draw_set_font(obj_editor_gui.fontDark);
	draw_set_color(col);
	draw_text(x + 2,y+ 2 + i * 21,string(i+1));
	//draw_text(x + 2,y+ 3 + (layerOrder[i]+2)*10 + subPointDisplacement,string(layerOrder[i]+2));
	
	if canSelect[i,0] || select[i,0] && !(i = dragLayer && draggingMouse) {
		draw_set_color(orange);
		draw_rectangle(x+37,y+2+layerOrder[i]*21,x+37+string_width(layerName[i,0]),y+11+layerOrder[i]*21,false);
		
		draw_set_font(obj_editor_gui.fontDark);
		draw_set_color(orange);
	} else {
		draw_set_font(obj_editor_gui.font);
		draw_set_color(col);
		draw_set_alpha(layerAlpha[i]);
	}
	
	draw_text(x + 37,y + 2 + layerOrder[i] * 21,layerName[i,0]);
	draw_set_alpha(1);
	
	draw_sprite_ext(spr_layer_minus,0,x + 37, y + 18 + layerOrder[i] * 21,1,1,0,col,layerAlpha[i]);
	
	for (j = 1; j < array_length_2d(layerName,i); j += 1) {
		if canSelect[i,j] || select[i,j] && !(i = dragLayer && draggingMouse) {
			draw_set_color(orange);
			draw_rectangle(x + 43, 2 + (layerOrder[i] * 21) + (j * 11), x + 43 + string_width(layerName[i,j]), 11 + (layerOrder[i] * 21) + (j * 11), false);
			
			draw_set_font(obj_editor_gui.fontDark);
			draw_set_color(orange);
		} else {
			draw_set_font(obj_editor_gui.font);
			draw_set_color(col);
			draw_set_alpha(layerAlpha[i]);
		}
		
		draw_text(x + 43,y + 2 + (layerOrder[i] * 21) + (j * 11),layerName[i,j]);
		draw_set_alpha(1);
	}
}

// Draw scroll markers last
for (i = 0; i < array_height_2d(layerName); i += 1) {
	draw_sprite_ext(spr_layer_place,0,x + 11,y + 1 + layerOrder[i]*21,1,1,0,col,1);
}

// New layer icons
draw_sprite_ext(spr_layer_plus,0,x + 31, y + 6 + (array_height_2d(layerName) * 21),1,1,0,plusCol,1);
draw_sprite_ext(spr_layer_die,0,x + 41, y + 6 + (array_height_2d(layerName) * 21),1,1,0,dieCol,1);
