using GLES2;
using EGL;
using Broadcom.VideoCore;
using Broadcom.VideoCore.DisplayManager;
using Broadcom.VideoCore.Image;

class untitled : GLib.Object {

    public static int main(string[] args) {
		Host.init();
		stdout.printf("Broadcom VideoCore host initialized.\n");
		
		//stdout.printf("SDRAM address: %u\n", Host.get_sdram_address());
		//stdout.printf("Peripheral address: %u\n", Host.get_peripheral_address());
		//stdout.printf("Peripheral size: %u\n", Host.get_peripheral_size());
		
			
		stdout.printf("Initializing EGL.\n");
		// Get an EGL display connection.
		var display = eglGetDisplay(EGL_DEFAULT_DISPLAY);
		assert(display != EGL_NO_DISPLAY);
		
		// Initialize the EGL display connection.
		var result = eglInitialize(display, null, null);
		assert(result != EGL_FALSE);
		
		// Get an appropriate EGL frame buffer configuration.
		EGLint num_config;
		EGLConfig config = 0;
		EGLenum[] attribute_list = {
			EGL_RED_SIZE, 8,
			EGL_GREEN_SIZE, 8,
			EGL_BLUE_SIZE, 8,
			EGL_ALPHA_SIZE, 8,
			EGL_DEPTH_SIZE, 16,   // You need this line for depth buffering to work
			EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
			EGL_NONE
		};
		result = eglChooseConfig(display, attribute_list, &config, 1, &num_config);
		assert(result != EGL_FALSE);
		
		// Create an EGL rendering context.
		var context = eglCreateContext(display, config, EGL_NO_CONTEXT, null);
		assert(context != EGL_NO_CONTEXT);
		
		// Create an EGL window surface
		var displayId = DisplayId.MAIN_LCD;
		var displayHandle = display_open(displayId);
		assert(display != DISPMANX_NO_HANDLE);
		
		var info = ModeInfo();
		result = display_get_info(displayHandle, &info);
		assert(result == ReturnCode.SUCCESS);
		
		stdout.printf("Display size: %u x %u\n", info.width, info.height);
		
		//uint32 screen_width;
		//uint32 screen_height;
		//result = Host.get_display_size(displayId, &screen_width, &screen_height);
		//assert(result >= 0);
		
		var update = update_start(0);
		assert(update != DISPMANX_NO_HANDLE);
		
		var dst_rect = Rectangle();
		dst_rect.x = 0;
		dst_rect.y = 0;
		dst_rect.width = info.width;
		dst_rect.height = info.height;
		
		var src_rect = Rectangle();
		src_rect.x = 0;
		src_rect.y = 0;
		src_rect.width = info.width << 16;
		src_rect.height = info.height << 16;        
		
		var alpha = AlphaVC();
		var clamp = Clamp();
		var element = element_add(update, display, 0, &dst_rect, 0, &src_rect, Protection.NONE, &alpha, &clamp, Transform.NO_ROTATE);
		assert(element != DISPMANX_NO_HANDLE);
		
		result = update_submit_sync(update);
		assert(result == ReturnCode.SUCCESS);

		EGL_DISPMANX_WINDOW_T window = EGL_DISPMANX_WINDOW_T();
		window.element = element;
		window.width = info.width;
		window.height = info.height;
		
		var surface = eglCreateWindowSurface(display, config, &window, null);
		assert(surface != EGL_NO_SURFACE);

		
		// connect the context to the surface
		result = eglMakeCurrent(display, surface, surface, context);
		assert(result != EGL_FALSE);
		
		// Set background color and clear buffers
		glClearColor(0.15f, 0.25f, 0.35f, 1.0f);

		// Enable back face culling.
		glEnable(GL_CULL_FACE);
		
		// Set background color and clear buffers
		glClearColor(0.15f, 0.25f, 0.35f, 1.0f);
		glClear( GL_COLOR_BUFFER_BIT );

		glViewport ( 0, 0, info.width, info.height );

		//glMatrixMode(GL_MODELVIEW);
		
				
		stdout.printf("EGL initialized. Ready to do some useful stuff.\n\n");
		
		
		// TODO Do useful stuff.
		
		
		stdout.printf("\nTerminating EGL.\n");
		// clear screen
		//glClear( GL_COLOR_BUFFER_BIT );
		//eglSwapBuffers( display, surface );
		
		// Release OpenGL resources
		//eglMakeCurrent( display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT );
		//eglDestroySurface( display, surface );
		//eglDestroyContext( display, context );
		//eglTerminate( display );
		
		// release texture buffers
		//free(state->tex_buf1);
		//free(state->tex_buf2);
		//free(state->tex_buf3);
		
		
		result = display_close(displayId);
		assert(result == ReturnCode.SUCCESS);
		
		result = eglTerminate(display);
		assert(result != EGL_FALSE);
		stdout.printf("EGL terminated.\n");
		
		Host.deinit();
		stdout.printf("Broadcom VideoCore host deinitialized.\n");
		
		
        return 0;
    }
}
