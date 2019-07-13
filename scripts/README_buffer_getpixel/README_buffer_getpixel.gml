//////////////////////////////////////////////////////////////////////////////
/*    

How to use each command:

buffer_getpixel_begin(surface) = creates the buffer for checking using a specified surface id
                                 (or surface drawing) and returns you a buffer index.
								 (NOTE: application_surface only picks the regular Draw events; 
								         not the GUI events.)
							     If your surface image is static, you can set it to create event,
								 otherwise, set it in the event that you will get the pixel.

buffer_getpixel(ind,x,y) = Gets the RGB of a pixel within the specified buffer id (surface).

buffer_getpixel_ext(ind,x,y) = Gets the RGBA of a pixel within the specified buffer id.

buffer_getpixel_r(ind x,y) = Gets the Red value of a pixel

buffer_getpixel_g(ind x,y) = Gets the Green value of a pixel

buffer_getpixel_b(ind x,y) = Gets the Blue value of a pixel

buffer_getpixel_a(ind x,y) = Gets the Alpha value of a pixel

//////////////////////////////////////////////////////////////////////////////
THANK YOU FOR DOWNLOADING THIS :)
Any questions or feedbacks are welcome. 

Special thanks to several users, including Mordwaith
