/// @description Depth calculation
// Draw above target instance
if trg != -1 {
	depth = obj_editor_gui.depth -(trg.y + zfloor*20 + 20) - zfloor - room_height - 101;
}
