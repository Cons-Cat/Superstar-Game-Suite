/// @description Efficiently write to the end of a text file
/// @param val1 file to write to
/// @param val2 string to write to file

var file, str;
file = argument[0];
str = argument[1];

while !file_text_eof(file) {
	file_text_writeln(file);
}
file_text_write_string(file,string_hash_to_newline("#") + str);
