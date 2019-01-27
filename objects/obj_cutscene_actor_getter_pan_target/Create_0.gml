/// @description Initialize variables
gone = false;
gray = make_color_rgb(102,102,102);
orange = make_color_rgb(255,160,64);
col1 = gray;
col2 = orange;

for (i = 0; i <= 7; i += 1) {
	for (j = 0; j <= 2; j += 1) {
		arrowSelect[i,j] = false;
	}
}

sliderSelect[0] = false;
sliderSelect[1] = false;

obj_trigger_dialogue_region_editor.canDeSelect = false;
