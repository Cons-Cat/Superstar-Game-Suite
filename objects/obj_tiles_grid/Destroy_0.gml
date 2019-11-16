/// @description Free surfaces
if surface_exists(tileSurface) {
	surface_free(tileSurface);
}
if surface_exists(marbleSurface) {
	surface_free(marbleSurface);
}

// Reset panel left width
obj_panel_left.panelWidth = 0;
