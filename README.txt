NOTE: Majority of the code for my project is implemented in MATLAB. We tried using the following
plugin file to generate Doxygen documentation. 

http://www.mathworks.com/matlabcentral/fileexchange/25925-using-doxygen-with-matlab
 
But was unsuccessful in generating the documentation. 

Each Function file in matlab explains the purpose of the function, its interface at the start of
the file.



Instructions to run the project:
1.Create a 1 bit Monochrome bitmap image with Paint with the desired shapes
 of arbitrary curves, say, “curve.bmp”, save it in Matlab home directory.

2.Read the image into Matlab by the command “im=imread(‘curve’, ‘bmp’);”. 
Now the binary image is stored in a matrix ‘im’.

3.Edit the file path of ‘image.h’ (to which the image data is written by the Matlab file) 
in the newpaths.m according to the directory structure. 

4.Run the command ‘newpaths(im);’ in the Matlab console. This file calculates all
 the required data points, angles etc. (with the help of other matlab source files) 
and populates the ‘image.h’ file with the required data.

5.Create a new project in AVR Studio named TraverseCurve and add the files ‘TraverseCurve.c’
 and ‘image.h’ as source files and compile the code.

6.Burn the hexfile to the Firebird V and place it in a spacious location. 
The Robot traverses along the curve  depicted in the image as required!
