echo Compiling... && 
cc -DSTANDALONE -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -DTARGET_POSIX -D_LINUX -fPIC -DPIC -D_REENTRANT -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -U_FORTIFY_SOURCE -Wall -g -DHAVE_LIBOPENMAX=2 -DOMX -DOMX_SKIP64BIT -ftree-vectorize -pipe -DUSE_EXTERNAL_OMX -DHAVE_LIBBCM_HOST -DUSE_EXTERNAL_LIBBCM_HOST -DUSE_VCHIQ_ARM -Wno-psabi -I/opt/vc/include/ -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux -I./ -I../libs/ilclient -I../libs/vgfont -I/usr/include/glib-2.0 -I/usr/include/glib-2.0/glib -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include -g -c test.c -o test.o -Wno-deprecated-declarations &&
echo Linking... &&
cc -o test.bin -Wl,--whole-archive test.o -L/opt/vc/lib/ -lGLESv2 -lEGL -lopenmaxil -lbcm_host -lvcos -lvchiq_arm -lpthread -lrt -lm -lglib-2.0 -lgobject-2.0 -L../libs/ilclient -L../libs/vgfont -L/lib/arm-linux-gnueabihf -Wl,--no-whole-archive -rdynamic