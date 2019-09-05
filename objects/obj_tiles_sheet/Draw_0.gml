/// @description 
draw_sprite(tileDefaultSpr,0,x,y);

// Select box horizontal edges
draw_sprite_ext(spr_tile_select_editor,0,xVal[0,0],yVal[0,0],selectWidthScale,1,0,c_white,1);
draw_sprite_ext(spr_tile_select_editor,0,xVal[0,0],yVal[0,0]+selectHeightOffset-1,selectWidthScale,1,0,c_white,1);

// Select box vertical edges
draw_sprite_ext(spr_tile_select_editor,0,xVal[0,0],yVal[0,0],1,selectHeightScale,0,c_white,1);
draw_sprite_ext(spr_tile_select_editor,0,xVal[0,0]+selectWidthOffset-1,yVal[0,0],1,selectHeightScale,0,c_white,1);
