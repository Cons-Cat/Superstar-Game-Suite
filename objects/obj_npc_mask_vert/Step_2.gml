/// @description Insert description here
if instance_exists(trg) {
	image_xscale = sprite_get_width(trg.mask_index)/2;
	image_yscale = sprite_get_height(trg.mask_index)/2;
	depth = trg.depth;
	
	x = trg.x - image_xscale;
	y = trg.y - image_yscale*2;
	zheight = trg.zfloor;
	zcieling = trg.zfloor;
} else {
	instance_destroy();
}
