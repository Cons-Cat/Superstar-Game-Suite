/// @description Draw chat bubble

// Darks
	//Fill
	for(i = 0; i <= width; i += 1) {
		for(j = 0; j <= height; j += 1) {
			if (i > 0 && i < width) || (j > 0 && j < height) {
				draw_sprite(spr_chat_outline_dark,4,placex+i*10+5,placey+j*10+5);
			}
		}
	}
	draw_sprite(spr_chat_fill,0,placex+2+4,placey+2+4);
	draw_sprite(spr_chat_fill,0,placex+2+4,placey+height*10+4);
	draw_sprite(spr_chat_fill,0,placex+width*10+4,placey+2+4);
	draw_sprite(spr_chat_fill,0,placex+width*10+4,placey+height*10+4);
	
	//Top left corner
	draw_sprite(spr_chat_outline_dark,0,placex+5,placey+5);
	//Bottom left corner
	draw_sprite(spr_chat_outline_dark,6,placex+5,placey+(height)*10+5);
	
	//Top
	for(i = 1; i < width; i += 1) {
		draw_sprite(spr_chat_outline_dark,1,placex+i*10+5,placey+5);
	}
	//Bottom
	for(i = 1; i < width; i += 1) {
		draw_sprite(spr_chat_outline_dark,7,placex+i*10+5,placey+(height)*10+5);
	}
	//Left
	for(i = 1; i < height; i += 1) {
		draw_sprite(spr_chat_outline_dark,3,placex+5,placey+i*10+5);
	}
	//Right
	for(i = 1; i < height; i += 1) {
		draw_sprite(spr_chat_outline_dark,5,placex+width*10+5,placey+i*10+5);
	}
	
	//Top right corner
	draw_sprite(spr_chat_outline_dark,2,placex+(width*10)+5,placey+5);
	//Bottom right corner
	draw_sprite(spr_chat_outline_dark,corner,placex+(width)*10+5,placey+(height)*10+5);

// Whites
	// Top left corner
	draw_sprite_ext(spr_chat_outline_white,0,placex+5,placey+5,1,1,0,outlineColor,1);
	// Bottom left corner
	draw_sprite_ext(spr_chat_outline_white,6,placex+5,placey+(height)*10+5,1,1,0,outlineColor,1);
	
	// Top
	for(i = 1; i < width; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,1,placex+i*10+5,placey+5,1,1,0,outlineColor,1);
	}
	// Bottom
	for(i = 1; i < width; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,7,placex+i*10+5,placey+(height)*10+5,1,1,0,outlineColor,1);
	}
	// Left
	for(i = 1; i < height; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,3,placex+5,placey+i*10+5,1,1,0,outlineColor,1);
	}
	// Right
	for(i = 1; i < height; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,5,placex+width*10+5,placey+i*10+5,1,1,0,outlineColor,1);
	}
	
	// Top right corner
	draw_sprite_ext(spr_chat_outline_white,2,placex+(width*10)+5,placey+5,1,1,0,outlineColor,1);
	// Bottom right corner
	draw_sprite_ext(spr_chat_outline_white,corner,placex+(width)*10+5,placey+(height)*10+5,1,1,0,outlineColor,1);

// Arrow
draw_sprite_ext(spr_chat_arrow,0,trg.x+9,placey+height*10+5,1,1,0,outlineColor,1);
draw_sprite(spr_chat_arrow,1,trg.x+9,placey+height*10+5);
draw_sprite(spr_chat_arrow,2,trg.x+9,placey+height*10+5);

// Draggers
draw_sprite_ext(spr_dialogue_dragger,0,placex,placey,-1,height*10+10,0,selectCol[0],1); // Left
draw_sprite_ext(spr_dialogue_dragger_border,0,placex,placey,-1,1,0,selectCol[0],1);
draw_sprite_ext(spr_dialogue_dragger_border,0,placex,placey+height*10+9,-1,1,0,selectCol[0],1);

draw_sprite_ext(spr_dialogue_dragger,0,placex+width*10+10,placey,1,height*10+10,0,selectCol[1],1); // Right
draw_sprite_ext(spr_dialogue_dragger_border,0,placex+width*10+10,placey,1,1,0,selectCol[1],1);
draw_sprite_ext(spr_dialogue_dragger_border,0,placex+width*10+10,placey+height*10+9,1,1,0,selectCol[1],1);

for (i = 0; i < width*10+10; i += 1) {
	draw_sprite_ext(spr_dialogue_dragger,0,placex+i,placey,1,1,90,selectCol[2],1); // Top
}
draw_sprite_ext(spr_dialogue_dragger_border,0,placex,placey,1,1,90,selectCol[2],1);
draw_sprite_ext(spr_dialogue_dragger_border,0,placex+width*10+9,placey,1,1,90,selectCol[2],1);

// Arrows on draggers
draw_sprite_ext(spr_dialogue_dragger_arrow,0,placex,placey+height*5+5,-1,1,0,c_white,1); // Left
draw_sprite_ext(spr_dialogue_dragger_arrow,0,placex+width*10+10,placey+height*5+5,1,1,0,c_white,1); // Right
draw_sprite_ext(spr_dialogue_dragger_arrow,0,placex+width*5+5,placey,1,1,90,c_white,1); // Top

// Z dragger
draw_sprite_ext(spr_dialogue_dragger_z,0,placex+width*10+10-15,placey+height*10+10,1,1,0,selectCol[3],1);
draw_sprite_ext(spr_dialogue_dragger_z_arrow,0,placex+width*10+10-15,placey+height*10+10,1,1,0,c_white,1);

// Select text rows
draw_set_font(font);

for (i = 0; i < textRows; i += 1) {
	if selectTextRow[i] || canSelectTextRow[i] {
		draw_set_color(orange);
		draw_rectangle(placex + 5,placey + 5 + i*10, placex + width*10 + 4,placey + 14 + i*10,false);
		draw_set_color(c_black);
	} else {
		draw_set_color(c_white);
	}
	
	draw_text(placex + 6, placey + 6 + i*10,str[i]);
}
