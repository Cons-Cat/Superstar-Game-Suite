/// @description Draw chat bubble
// Darks
	//Fill
	draw_set_alpha(inAlpha);
	draw_set_color(black);
	
	// Center
	draw_rectangle(lSide+1,tSide-2,rSide-1,bSide-1,false);
	// Left
	draw_rectangle(lSide+1-5*scale,tSide+1,lSide+1,bSide-1,false);
	// Top
	draw_rectangle(lSide-2,tSide+1-5*scale,rSide+1,tSide+1,false);
	// Right
	draw_rectangle(rSide-1+5*scale+1-1*scale,tSide+1,rSide-1,bSide-1,false);
	// Bottom
	draw_rectangle(lSide-1,bSide-2+5*scale,rSide+1,bSide-2,false);
	
	// Top left corner
	draw_sprite_ext(spr_chat_outline_dark,0,lSide,tSide,scale,scale,0,c_white,1);
	// Bottom left corner
	draw_sprite_ext(spr_chat_outline_dark,6,lSide,bSide,scale,scale,0,c_white,1);
	
	// Top
	for(i = 1; i < width; i += 1) {
		draw_sprite_ext(spr_chat_outline_dark,1,lSide+i*10*scale,tSide,scale,scale,0,c_white,1);
	}
	// Bottom
	for(i = 1; i < width; i += 1) {
		draw_sprite_ext(spr_chat_outline_dark,7,lSide+i*10*scale,bSide,scale,scale,0,c_white,1);
	}
	// Left
	for(i = 1; i < height; i += 1) {
		draw_sprite_ext(spr_chat_outline_dark,3,lSide,tSide+i*10*scale,scale,scale,0,c_white,1);
	}
	// Right
	for(i = 1; i < height; i += 1) {
		draw_sprite_ext(spr_chat_outline_dark,5,rSide,tSide+i*10*scale,scale,scale,0,c_white,1);
	}
	
	// Top right corner
	draw_sprite_ext(spr_chat_outline_dark,2,rSide,tSide,scale,scale,0,c_white,1);
	// Bottom right corner
	draw_sprite_ext(spr_chat_outline_dark,corner,rSide,bSide,scale,scale,0,c_white,1);
	
// Whites
	draw_set_alpha(outAlpha);
	
	// Top left corner
	draw_sprite_ext(spr_chat_outline_white,0,lSide,tSide,scale,scale,0,outlineColor,1);
	// Bottom left corner
	draw_sprite_ext(spr_chat_outline_white,6,lSide,bSide,scale,scale,0,outlineColor,1);
	
	// Top
	for(i = 1; i < width; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,1,lSide+i*10*scale+1,tSide,scale,scale,0,outlineColor,1);
	}
	draw_rectangle_color(lSide,tSide-5*scale,rSide-1,tSide-5*scale,black,black,black,black,false);
	draw_rectangle_color(lSide,tSide-4*scale,rSide-1,tSide-4*scale,outlineColor,outlineColor,outlineColor,outlineColor,false);
	
	// Bottom
	for(i = 1; i < width; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,7,lSide+i*10*scale,bSide,scale,scale,0,outlineColor,1);
	}
	draw_rectangle_color(lSide,bSide+3*scale,rSide-2+1*scale,bSide+3*scale,outlineColor,outlineColor,outlineColor,outlineColor,false);
	draw_rectangle_color(lSide,bSide+4*scale,rSide-2+1*scale,bSide+4*scale,black,black,black,black,false);
	
	// Left
	for(i = 1; i < height; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,3,lSide,tSide+i*10*scale,scale,scale,0,outlineColor,1);
	}
	draw_rectangle_color(lSide-4*scale,tSide,lSide-4*scale,bSide-1,outlineColor,outlineColor,outlineColor,outlineColor,false);
	draw_rectangle_color(lSide-5*scale,tSide,lSide-5*scale,bSide-1,black,black,black,black,false);
	
	// Right
	for(i = 1; i < height; i += 1) {
		draw_sprite_ext(spr_chat_outline_white,5,rSide,tSide+i*10*scale,scale,scale,0,outlineColor,1);
	}
	draw_rectangle_color(rSide+3*scale,tSide,rSide+3*scale,bSide-1,outlineColor,outlineColor,outlineColor,outlineColor,false);
	draw_rectangle_color(rSide+4*scale,tSide,rSide+4*scale,bSide-1,black,black,black,black,false);
	
	// Top right corner
	draw_sprite_ext(spr_chat_outline_white,2,rSide,tSide,scale,scale,0,outlineColor,1);
	// Bottom right corner
	draw_sprite_ext(spr_chat_outline_white,corner,rSide,bSide,scale,scale,0,outlineColor,1);

	draw_set_alpha(1);

// Arrow
draw_sprite_ext(spr_chat_arrow,0,trg.x-1,bSide,scale,arrowScale,0,outlineColor,outAlpha);
draw_sprite_ext(spr_chat_arrow,1,trg.x-1,bSide,scale,arrowScale,0,c_white,inAlpha);
draw_sprite_ext(spr_chat_arrow,2,trg.x-1,bSide,scale,arrowScale,0,outlineColor,outAlpha);

//Text
draw_set_color(c_white);
draw_set_font(font);

for (i = 0; i < textRows; i += 1) {
	draw_text(placex+1,placey+1+i*10,message_draw[i]);
}
