/// @description Select this tile
obj_tile_rectangle.select = 0;
obj_tile_rectangle.col = c_white;

obj_tile_slope1.select = 0;
obj_tile_slope1.col = c_white;

obj_tile_slope2.select = 0;
obj_tile_slope2.col = c_white;

obj_tile_slope3.select = 0;
obj_tile_slope3.col = c_white;

obj_tile_infinite.select = 0;
obj_tile_infinite.col = c_white;

if select = 0 {
	select = 1;
	col = c_orange;
} else {
	select = 0;
	col = c_white;
}
