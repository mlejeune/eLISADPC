####eLISA DPC
eLISADPC is an image of the the proto-dpc environment.

Is designed for developers that want contribute to the eLISA proto-dpc, to minimize incompatibility between local environment and continuous integration environment.

The image provide all the tools necessary to build a project: compilers, libraries, etc. and is updated regularly. 
 
The container is based upon a Centos 7 system. 

Some tools and libraries are installed to deal with codes already integrated in the eLISA proto-dpc system. At the moment, these are the installed libraries and tools: 

**Tools & compilers**

1. git
2. make
3. cmake
4. gcc-c++
5. numpy 
6. boost boost-devel boost-doc

**Libraries**

1. fftw3
2. gsl



####How to use

To use the image you need [Docker](http://docker.io) installed on your system. Once installed Docker, you have to download the image from Docker Hub using the following command:

	docker pull gabrimaine/elisadpc
	
and then launch the image using the following command:

	docker run -v /Local/dir:/Container/dir -it gabrimaine/elisadpc
	

This command launch the image and link a directory on your system (/Local/dir) with a directory within the image (/Container/dir, if the container dir doesn't exist, Docker will create it automatically). Once launched, you will be logged-in in the Centos image and you have all the tools to compile and test your code. 


You can continue to use your preferred editor on your machine, e.g. Eclipse, or install editor on the eLISAdpc image (e.g., vim or emacs). 

An example of workflow for a developer working with XCode on Mac:

1. Launch docker
2. pull the image
3. run the image linking the workspace on Mac to a dir on the image
4. continue to edit your code using XCode
5. go to the image and run the compiler to test that modified code works fine




Contact:  mainetti@apc.in2p3.fr


