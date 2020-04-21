/// @description Saving room data
x = round( (obj_panel_left.baseX - 4 - room_width) / 3 * 2 - ( (obj_panel_left.baseX - 4 - room_width) / 6.25) ) + room_width;

if select {
	select = false;
	
	// Save level data
	saveFile = get_save_filename_ext("Editor Save File|*.vasc", "", working_directory + "\Room Saves\ ", "Save Level Data");
	
	if saveFile != "" {
		str = "";
		export = file_text_open_write(saveFile);
		
		// Top data
		str += string(instance_number(obj_editor_placeable_parent));
		
		for (var i = 0; i < instance_number(obj_editor_placeable_parent); i += 1) {
			trg = instance_find(obj_editor_placeable_parent,i);
			writeVertices = false;
			
			// Write generic data
			str += string_hash_to_newline("#" + string(trg.str));
			str += string_hash_to_newline("#" + string(trg.x));
			str += string_hash_to_newline("#" + string(trg.y));
			str += string_hash_to_newline("#" + string(trg.width));
			str += string_hash_to_newline("#" + string(trg.height));
			str += string_hash_to_newline("#" + string(trg.zfloor));
			str += string_hash_to_newline("#" + string(trg.zcieling));
			
			// Write instance-particular data
			if trg.str = "rectangle" || trg.str = "slope1" || trg.str = "slope2" || trg.str = "slope3" {
				#region
				
				str += string_hash_to_newline("#" + string(trg.finite));
				str += string_hash_to_newline("#" + string(trg.tileDrawSpr));
				str += string_hash_to_newline("#" + string(trg.tileLayerCount));
				str += string_hash_to_newline("#" + string(trg.tileArrayHeight));
				
				// Generic slope data
				if trg.str != "rectangle" {
					str += string_hash_to_newline("#" + string(trg.mirror));
					str += string_hash_to_newline("#" + string(trg.flip));
				}
				
				// Rectangle terrain tiles
				for (k = 0; k <= trg.tileLayerCount; k += 2) { // Iterate through arbitrary layers
						str += string_hash_to_newline("#" + string(trg.layerOrder[k]));
				}
				
				for (k = 0; k <= trg.tileLayerCount; k += 2) { // Iterate through arbitrary layers
					// Write layer data
					str += string_hash_to_newline("#" + string(trg.layerVisible[k]));
					str += string_hash_to_newline("#" + string(trg.layerType[k]));
					
					str += string_hash_to_newline("#" + string(trg.layerName[k]));
					str += string_hash_to_newline("#" + string(trg.layerName[k+1]));
					
					// Write hasTile values
					for (a = 0; a < trg.width + 2; a += 1) { // Iterate horizontally
						for (b = 0; b < trg.height + trg.zfloor - trg.zcieling + 1; b += 1) { // Iterate vertically
							str += string_hash_to_newline("#" + string(trg.hasTile[scr_array_xy(a, b, trg.tileArrayHeight), k]));
							str += string_hash_to_newline("#" + string(trg.hasTile[scr_array_xy(a, b, trg.tileArrayHeight), k+1]));
							
							// Define tile co-ordinates if true
							if trg.hasTile[scr_array_xy(a, b, trg.tileArrayHeight), k] {
								str += string_hash_to_newline("#" + string(trg.tileArrayDrawX[scr_array_xy(a, b, trg.tileArrayHeight), k]));
								str += string_hash_to_newline("#" + string(trg.tileArrayDrawY[scr_array_xy(a, b, trg.tileArrayHeight), k]));
							}
							if trg.hasTile[scr_array_xy(a, b, trg.tileArrayHeight), k+1] {
								str += string_hash_to_newline("#" + string(trg.tileArrayDrawX[scr_array_xy(a, b, trg.tileArrayHeight), k+1]));
								str += string_hash_to_newline("#" + string(trg.tileArrayDrawY[scr_array_xy(a, b, trg.tileArrayHeight), k+1]));
							}
						}
					}
					
					// Write marble pixels
					if trg.layerType[k] = 1 {
						for (a = 0; a < trg.width * 20; a += 1) { // Iterate horizontally
							for (b = 0; b < (trg.height + trg.zfloor - trg.zcieling) * 20; b += 1) { // Iterate vertically
								str += string_hash_to_newline("#" + string(trg.marblePixelColInd[a,b]));
							}
						}
					}
				}
				
				#endregion
			}
			
			if trg.str = "moveScene" {
				#region
				
				str += string_hash_to_newline("#" + string(trg.instId1[0]));
				str += string_hash_to_newline("#" + string(trg.totalActions));
				str += string_hash_to_newline("#" + string(obj_panel_bot.rows));
				
				for (var j = 0; j < obj_panel_bot.rows; j += 1) {
					str += string_hash_to_newline("#" + string(trg.actorTxt[j]));
				}
				
				for (var j = 1; j <= trg.totalActions; j += 1) {
					#region
					
					str += string_hash_to_newline("#" + string(trg.actionInd[j]));
					str += string_hash_to_newline("#" + string(trg.actionTime[j]));
					str += string_hash_to_newline("#" + string(trg.actionRowInd[j]));
					
					if trg.actionInd[j] = 0 { // Walk action
						str += string_hash_to_newline("#" + string(trg.xNode[j]));
						str += string_hash_to_newline("#" + string(trg.yNode[j]));
					}
					
					if trg.actionInd[j] = 1 { // Rotation action
						str += string_hash_to_newline("#" + string(trg.angleRot[j]));
						str += string_hash_to_newline("#" + string(trg.angleRotExport[j]));
					}
					
					if trg.actionInd[j] = 2 { // Dialogue action
						#region
						
						str += string_hash_to_newline("#" + string(trg.xOffDialogue[j]));
						str += string_hash_to_newline("#" + string(trg.yOffDialogue[j]));
						str += string_hash_to_newline("#" + string(trg.bubbleCount[j]));
						
						for (var k = 0; k <= trg.bubbleCount[j]; k += 1) {
							str += string_hash_to_newline("#" + string(trg.lineCount[j,k]));
							str += string_hash_to_newline("#" + string(trg.bubbleX[j,k]));
							str += string_hash_to_newline("#" + string(trg.bubbleY[j,k]));
							
							for (var z = 0; z <= trg.lineCount[j,k]; z += 1) {
								str += string_hash_to_newline("#" + trg.lineStr[scr_array_xy(k,z,trg.bubbleCount[j]),z]);
							}
						}
						
						#endregion
					}
					
					if trg.actionInd[j] = 3 { // Camera pan action
						str += string_hash_to_newline("#" + string(trg.xNode[j]));
						str += string_hash_to_newline("#" + string(trg.yNode[j]));
						str += string_hash_to_newline("#" + string(trg.zoomVal[j]));
					}
					
					if trg.actionInd[j] = 5 { // Walk speed action
						str += string_hash_to_newline("#" + string(trg.slowSpd[j]));
					}
					
					if trg.actionInd[j] = 6 { // Arbitrary action
						str += string_hash_to_newline("#" + string(trg.arbitraryInd[j]));
					}
					
					#endregion
				}
				
				writeVertices = true;
				
				#endregion
			}
			
			if trg.str = "actor" {
				#region
				
				str += string_hash_to_newline("#" + string(trg.actorTxt));
				str += string_hash_to_newline("#" + string(trg.angle));
				
				#endregion
			}
			
			if trg.str = "panScene" {
				#region
				
				str += string_hash_to_newline("#" + string(trg.instId1[0]));
				str += string_hash_to_newline("#" + string(trg.angle));
				str += string_hash_to_newline("#" + string(trg.magnitude));
				str += string_hash_to_newline("#" + string(trg.zoomVal));
				
				writeVertices = true;
				
				#endregion
			}
			
			if trg.str = "anchorScene" {
				#region
				
				str += string_hash_to_newline("#" + string(trg.majorRadius));
				str += string_hash_to_newline("#" + string(trg.minorRadius));
				str += string_hash_to_newline("#" + string(trg.thresholdRadius));
				str += string_hash_to_newline("#" + string(trg.zoomVal));
				
				#endregion
			}
			
			if writeVertices {
				#region
				
				writeVertices = false;
				vertexCount = 0;
				
				for (var j = 0; j < instance_number(obj_trigger_vertex); j+= 1) {
					if instance_find(obj_trigger_vertex,j).trg = trg.id {
						vertexCount += 1;
					}
				}
				
				str += string_hash_to_newline("#" + string(vertexCount));
				
				for (var j = 0; j < instance_number(obj_trigger_vertex); j += 1) {
					vertId = instance_find(obj_trigger_vertex,j).id;
					
					if vertId.trg = trg.id {
						str += string_hash_to_newline("#" + string(vertId.hasThreshold));
						str += string_hash_to_newline("#" + string(vertId.trgXOff));
						str += string_hash_to_newline("#" + string(vertId.trgYOff));
						str += string_hash_to_newline("#" + string(vertId.vertexInd));
						str += string_hash_to_newline("#" + string(vertId.vertexToInd));
						
						if vertId.hasThreshold {
							str += string_hash_to_newline("#" + string(vertId.w));
							str += string_hash_to_newline("#" + string(vertId.girth));
							str += string_hash_to_newline("#" + string(vertId.thresholdX));
							str += string_hash_to_newline("#" + string(vertId.thresholdY));
							str += string_hash_to_newline("#" + string(vertId.edgeMidPointX));
							str += string_hash_to_newline("#" + string(vertId.edgeMidPointY));
						}
					}
				}
				
				#endregion
			}
		}
		
		str += string_hash_to_newline("#");
		
		file_text_write_string(export,str);
		file_text_close(export);
	}
}
