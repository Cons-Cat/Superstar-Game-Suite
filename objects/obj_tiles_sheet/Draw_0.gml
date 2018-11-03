/// @description 
draw_set_color(make_color_rgb(149,134,210));
// Draw pink backdrop right
draw_rectangle(x,y,x+sprite_get_width(global.sprMaterial),y+sprite_get_height(global.sprMaterial),false);
// Draw pink backdrop left
draw_rectangle(obj_tiles_grid.x,obj_tiles_grid.y,obj_tiles_grid.x+sprite_get_width(global.sprMaterial),obj_tiles_grid.y+sprite_get_height(global.sprMaterial),false);

draw_sprite(global.sprMaterial,0,x+scrollX,y+scrollY);

// Select box horizontal edges
draw_sprite_ext(spr_tile_select_editor,0,xVal[0,0]+scrollX,yVal[0,0]+scrollY,selectWidthScale,1,0,c_white,1);
draw_sprite_ext(spr_tile_select_editor,0,xVal[0,0]+scrollX,yVal[0,0]+scrollY+selectHeightOffset-1,selectWidthScale,1,0,c_white,1);

// Select box vertical edges
draw_sprite_ext(spr_tile_select_editor,0,xVal[0,0]+scrollX,yVal[0,0]+scrollY,1,selectHeightScale,0,c_white,1);
draw_sprite_ext(spr_tile_select_editor,0,xVal[0,0]+scrollX+selectWidthOffset-1,yVal[0,0]+scrollY,1,selectHeightScale,0,c_white,1);
