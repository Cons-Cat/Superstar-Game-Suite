/// @description 
subPointDisplacement = 0;

for (i = 0; i <= tileLayerCount; i += 2) {
	draw_sprite_ext(spr_layer_rack,0,x + 12, y + i*11,1,1,0,col,1);
	
	if i != tileLayerCount {
		draw_sprite_ext(spr_layer_rack,0,x + 12, y + (i+1)*11,1,1,0,col,1);
	}
	
	draw_sprite_ext(spr_point,0,x + 31, y + 6 + layerOrder[i] * 11,1,1,0,col,layerAlpha[i]);
	draw_sprite_ext(spr_layer_eye,eyeState[i],x + 22, y + 6 + layerOrder[i] *11,1,1,0,eyeCol[i],1);
	
	draw_sprite_ext(spr_layer_slot,0,x + 2, y + 1 + i*11,1,1,0,col,1);
	
	draw_set_font(obj_editor_gui.fontDark);
	draw_set_color(col);
	draw_text(x + 2,y+ 2 + i * 11,string( (i div 2) + 1) );
	
	// Layer
	if canSelect[i] || select[i] && !(i = dragLayer && draggingMouse) {
		draw_set_color(orange);
		draw_rectangle(x+37,y+2+layerOrder[i]*11,x+37+string_width(layerName[i]),y+11+layerOrder[i]*11,false);
		
		draw_set_font(obj_editor_gui.fontDark);
		draw_set_color(orange);
	} else {
		draw_set_font(obj_editor_gui.font);
		draw_set_color(col);
		draw_set_alpha(layerAlpha[i]);
	}
	
	draw_text(x + 37,y + 2 + layerOrder[i] * 11,layerName[i]);
	draw_set_alpha(1);
	
	draw_sprite_ext(spr_layer_minus,0,x + 37, y + 18 + layerOrder[i] * 11,1,1,0,col,layerAlpha[i]);
	
	// Sub-layer
	if canSelect[i+1] || select[i+1] && !(i = dragLayer && draggingMouse) {
		draw_set_color(orange);
		draw_rectangle(x + 43, 2 + (layerOrder[i] + 1) * 11, x + 43 + string_width(layerName[i+1]), 11 + (layerOrder[i] + 1) * 11, false);
		
		draw_set_font(obj_editor_gui.fontDark);
		draw_set_color(orange);
	} else {
		draw_set_font(obj_editor_gui.font);
		draw_set_color(col);
		draw_set_alpha(layerAlpha[i]);
	}
	
	draw_text(x + 43,y + 2 + (layerOrder[i] + 1) * 11,layerName[i+1]);
	draw_set_alpha(1);
}

// Draw scroll markers last
for (i = 0; i <= tileLayerCount; i += 2) {
	draw_sprite_ext(spr_layer_place,0,x + 11,y + 1 + layerOrder[i]*11,1,1,0,col,1);
}

// New layer icons
draw_sprite_ext(spr_layer_plus,0,x + 31, y + 6 + (tileLayerCount + 2) * 11,1,1,0,plusCol,1);
draw_sprite_ext(spr_layer_die,0,x + 41, y + 6 + (tileLayerCount + 2) * 11,1,1,0,dieCol,1);
