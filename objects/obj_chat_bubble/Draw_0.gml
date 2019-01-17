/// @description Draw chat bubble

// Darks
	//Fill
	for(i = 0; i <= width; i += 1) {
		for(j = 0; j <= height; j += 1) {
			if (i > 0 && i < width) || (j > 0 && j < height) {
				draw_sprite(spr_chat_outline_dark,4,placex+i*10,placey+j*10);
			}
		}
	}
	draw_sprite(spr_chat_fill,0,placex+2,placey+2);
	draw_sprite(spr_chat_fill,0,placex+2,placey+height*10);
	draw_sprite(spr_chat_fill,0,placex+width*10,placey+2);
	draw_sprite(spr_chat_fill,0,placex+width*10,placey+height*10);
	
	//Top left corner
	draw_sprite(spr_chat_outline_dark,0,placex,placey);
	//Bottom left corner
	draw_sprite(spr_chat_outline_dark,6,placex,placey+(height)*10);
	
	//Top
	for(i = 1; i < width; i += 1) {
		draw_sprite(spr_chat_outline_dark,1,placex+i*10,placey);
	}
	//Bottom
	for(i = 1; i < width; i += 1) {
		draw_sprite(spr_chat_outline_dark,7,placex+i*10,placey+(height)*10);
	}
	//Left
	for(i = 1; i < height; i += 1) {
		draw_sprite(spr_chat_outline_dark,3,placex,placey+i*10);
	}
	//Right
	for(i = 1; i < height; i += 1) {
		draw_sprite(spr_chat_outline_dark,5,placex+width*10,placey+i*10);
	}

	//Top right corner
	draw_sprite(spr_chat_outline_dark,2,placex+(width*10),placey);
	//Bottom right corner
	draw_sprite(spr_chat_outline_dark,corner,placex+(width)*10,placey+(height)*10);
	
// Whites
	// Top left corner
	draw_sprite_ext(spr_chat_outline_white,0,placex,placey,1,1,0,outlineColor,1);
	// Bottom left corner
	draw_sprite_ext(spr_chat_outline_white,6,placex,placey+(height)*10,1,1,0,outlineColor,1);
	
	// Top
	for(i = 1; i < width; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,1,placex+i*10,placey,1,1,0,outlineColor,1);
	}
	// Bottom
	for(i = 1; i < width; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,7,placex+i*10,placey+(height)*10,1,1,0,outlineColor,1);
	}
	// Left
	for(i = 1; i < height; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,3,placex,placey+i*10,1,1,0,outlineColor,1);
	}
	// Right
	for(i = 1; i < height; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,5,placex+width*10,placey+i*10,1,1,0,outlineColor,1);
	}
	
	// Top right corner
	draw_sprite_ext(spr_chat_outline_white,2,placex+(width*10),placey,1,1,0,outlineColor,1);
	// Bottom right corner
	draw_sprite_ext(spr_chat_outline_white,corner,placex+(width)*10,placey+(height)*10,1,1,0,outlineColor,1);

// Arrow
draw_sprite_ext(spr_chat_arrow,0,placex+width*5,placey+height*10+2,1,1,0,outlineColor,1);
draw_sprite(spr_chat_arrow,1,placex+width*5,placey+height*10+2);

//Text
draw_set_color(c_white);
draw_set_font(font);
draw_text_ext(placex+6,placey+6,message_draw,10,width*10);
