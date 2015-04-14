using GLES2;
using EGL;
using Broadcom.VideoCore;
using Broadcom.VideoCore.DisplayManager;
using Broadcom.VideoCore.Image;

class Main : GLib.Object {

    public static int main(string[] args) {
		var state = new GlState();
		Host.init();
		stdout.printf("Broadcom VideoCore host initialized.\n");
		
		stdout.printf("Initializing EGL.\n");
		// Get an EGL display connection.
		state.display = eglGetDisplay(EGL_DEFAULT_DISPLAY);
		assert(state.display != EGL_NO_DISPLAY);
		
		// Initialize the EGL display connection.
		var result = eglInitialize(state.display, null, null);
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
		result = eglChooseConfig(state.display, attribute_list, &config, 1, &num_config);
		assert(result != EGL_FALSE);
		
		// Create an EGL rendering context.
		var context = eglCreateContext(state.display, config, EGL_NO_CONTEXT, null);
		assert(context != EGL_NO_CONTEXT);
		
		// Create an EGL window surface
		var displayHandle = display_open(state.displayId);
		assert(state.display != DISPMANX_NO_HANDLE);
		
		var info = ModeInfo();
		result = display_get_info(displayHandle, &info);
		assert(result == ReturnCode.SUCCESS);
		
		state.screen_width = info.width;
		state.screen_height = info.height;
		//var resultX = Host.get_display_size(displayId, &screen_width, &screen_height);
		//assert(resultX >= 0);
		
		stdout.printf("Display size: %u x %u\n", state.screen_width, state.screen_height);
		
		var update = update_start(0);
		assert(update != DISPMANX_NO_HANDLE);
		
		var dst_rect = Rectangle();
		dst_rect.x = 0;
		dst_rect.y = 0;
		dst_rect.width = state.screen_width;
		dst_rect.height = state.screen_height;
		
		var src_rect = Rectangle();
		src_rect.x = 0;
		src_rect.y = 0;
		src_rect.width = state.screen_width << 16;
		src_rect.height = state.screen_height << 16;
		
		var alpha = AlphaVC();
		var clamp = Clamp();
		var element = element_add(update, displayHandle, 0, &dst_rect, 0, &src_rect, Protection.NONE, &alpha, &clamp, Transform.NO_ROTATE);
		assert(element != DISPMANX_NO_HANDLE);
		
		result = update_submit_sync(update);
		assert(result == ReturnCode.SUCCESS);

		EGL_DISPMANX_WINDOW_T window = EGL_DISPMANX_WINDOW_T();
		window.element = element;
		window.width = state.screen_width;
		window.height = state.screen_height;
		
		state.surface = eglCreateWindowSurface(state.display, config, &window, null);
		assert(state.surface != EGL_NO_SURFACE);
		
		// connect the context to the surface
		result = eglMakeCurrent(state.display, state.surface, state.surface, context);
		assert(result != EGL_FALSE);
		
		// Enable back face culling.
		glEnable(GL_CULL_FACE);
		
		// Set background color and clear buffers
		glClearColor(0.549f, 0.765f, 0.298f, 1.0f);

		glViewport(0, 0, state.screen_width, state.screen_height);

        // Enable depth test
        glEnable(GL_DEPTH_TEST);
        
        // Accept fragment if it closer to the camera than the former one
        glDepthFunc(GL_LESS); 

		stdout.printf("EGL initialized. Ready to do some useful stuff.\n\n");
		
		
		// Main render loop.
		for (int32 i = 0; i < 200; i++) {
			// Clear the screen
			glClear( GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT);
			
			// TODO Do useful stuff.
			
			
			
			eglSwapBuffers(state.display, state.surface);
		}
		
		
		
		stdout.printf("\nTerminating EGL.\n");

		result = display_close(state.displayId);
		assert(result == ReturnCode.SUCCESS);
		
		// Release OpenGL resources
		result = eglMakeCurrent(state.display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
		assert(result != EGL_FALSE);

		result = eglDestroySurface(state.display, state.surface);
		assert(result != EGL_FALSE);

		result = eglDestroyContext(state.display, context );
		assert(result != EGL_FALSE);
		
		result = eglTerminate(state.display );
		assert(result != EGL_FALSE);
		
		result = eglTerminate(state.display);
		assert(result != EGL_FALSE);
		stdout.printf("EGL terminated.\n");
		
		Host.deinit();
		stdout.printf("Broadcom VideoCore host deinitialized.\n");

		
		
        return 0;
    }
}

class GlState : GLib.Object {
	public EGLSurface surface;
	public EGLDisplay display;
	public uint16 displayId = 0; //DisplayId.MAIN_LCD;
	public int32 screen_width = 0;
	public int32 screen_height = 0;
	
}
