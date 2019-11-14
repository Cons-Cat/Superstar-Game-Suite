/// @description Free surfaces
if surface_exists(tileSurface) {
	surface_free(tileSurface);
}
if surface_exists(marbleSurface) {
	surface_free(marbleSurface);
}

for (k = 0; k <= tileLayerCount; k += 2) { // Iterate through absolute
	if surface_exists(surfaceSubtract[k]) {
		surface_free(surfaceSubtract[k]);
	}
}
