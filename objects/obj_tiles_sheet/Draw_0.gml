/// @description 

// Draw sheet
draw_sprite(tileDefaultSpr,0,xOff,yOff);

// Select box horizontal edges
draw_sprite_ext(spr_tile_select_editor,0,xOff+xInit,yOff+yInit,selectWidthScale,1,0,c_white,1);
draw_sprite_ext(spr_tile_select_editor,0,xOff+xInit,yOff+yInit+selectHeightOffset-1,selectWidthScale,1,0,c_white,1);

// Select box vertical edges
draw_sprite_ext(spr_tile_select_editor,0,xOff+xInit,yOff+yInit,1,selectHeightScale,0,c_white,1);
draw_sprite_ext(spr_tile_select_editor,0,xOff+xInit+selectWidthOffset-1,yOff+yInit,1,selectHeightScale+0.5,0,c_white,1);
