/*
 * EGL binding for Vala
 *
 * Copyright 2015 Jan Magne Tjensvold
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 * Bindings is incomplete. Inclusion of platform specific types is sketchy.
 */ 
[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename="EGL/egl.h")]
namespace EGL
{
	/*
	 * Functions needed to implement Raspberry Pi OpenGL ES example:
	 * 
	 * eglGetDisplay()
	 * eglInitialize()
	 * eglChooseConfig()
	 * eglCreateContext()
	 * eglCreateWindowSurface()
	 * eglMakeCurrent()
	 * eglSwapBuffers()
	 * eglDestroySurface()
	 * eglDestroyContext()
	 * eglTerminate()
	 */


	/*
	typedef void *EGLNativeDisplayType;
	typedef void *EGLNativePixmapType;
	typedef void *EGLNativeWindowType;
	*/
	// TODO: Should be some sort of pointer void*.
	// TODO: Also they are registered in EGL/eglplatform.h
	[SimpleType]
	public struct EGLNativeDisplayType: uint32 { }
	[SimpleType]
	public struct EGLNativePixmapType: uint32 { }
	//[SimpleType]
	//public struct EGLNativeWindowType: uint32 { }


	/* TODO: EGLNativeWindowType is really one of these but I'm leaving it
	* as void* for now, in case changing it would cause problems
	* Broadcom VideoCore specific display manager window!
	*/
	[CCode(cname = "EGL_DISPMANX_WINDOW_T", has_type_id = false, cheader_filename="EGL/eglplatform.h")]
	public struct EGL_DISPMANX_WINDOW_T {
		DISPMANX_ELEMENT_HANDLE_T element;
		int width;   /* This is necessary because dispmanx elements are not queriable. */
		int height;
	}
	 
	[SimpleType]
	public struct DISPMANX_ELEMENT_HANDLE_T: uint32 { }
	
		
	/* Define EGLint. This must be a signed integral type large enough to contain
	 * all legal attribute names and values passed into and out of EGL, whether
	 * their type is boolean, bitmask, enumerant (symbolic constant), integer,
	 * handle, or other.  While in general a 32-bit integer will suffice, if
	 * handles are 64 bit types, then EGLint should be defined as a signed 64-bit
	 * integer type.
	 */
	[SimpleType]
	public struct EGLint: int32 { }
	
	
	
	/* EGL Types */
	/* EGLint is defined in eglplatform.h */
	[SimpleType]
	public struct EGLBoolean: uint { }

	[SimpleType]
	public struct EGLenum: uint { }

	
	/*
	typedef void *EGLConfig;
	typedef void *EGLContext;
	typedef void *EGLDisplay;
	typedef void *EGLSurface;
	typedef void *EGLClientBuffer;
	*/
	// TODO Should be some sort of pointer void*
	[SimpleType]
	public struct EGLConfig: uint32 { }
	[SimpleType]
	public struct EGLContext: uint32 { }
	[SimpleType]
	public struct EGLDisplay: uint32 { }
	[SimpleType]
	public struct EGLSurface: uint32 { }
	[SimpleType]
	public struct EGLClientBuffer: uint32 { }
	
	/* EGL Versioning */
	public const EGLint EGL_VERSION_1_0;
	public const EGLint EGL_VERSION_1_1;
	public const EGLint EGL_VERSION_1_2;
	public const EGLint EGL_VERSION_1_3;
	public const EGLint EGL_VERSION_1_4;

	/* EGL Enumerants. Bitmasks and other exceptional cases aside, most
	 * enums are assigned unique values starting at 0x3000.
	 */

	/* EGL aliases */
	public const EGLBoolean EGL_FALSE;
	public const EGLBoolean EGL_TRUE;

	/* Out-of-band handle values */
	public const EGLNativeDisplayType EGL_DEFAULT_DISPLAY;
	public const EGLContext EGL_NO_CONTEXT;
	public const EGLDisplay EGL_NO_DISPLAY;
	public const EGLSurface EGL_NO_SURFACE;

	/* Out-of-band attribute value */
	public const EGLenum EGL_DONT_CARE;

	/* Errors / GetError return values */
	public const EGLenum EGL_SUCCESS;
	public const EGLenum EGL_NOT_INITIALIZED;
	public const EGLenum EGL_BAD_ACCESS;
	public const EGLenum EGL_BAD_ALLOC;
	public const EGLenum EGL_BAD_ATTRIBUTE;
	public const EGLenum EGL_BAD_CONFIG;
	public const EGLenum EGL_BAD_CONTEXT;
	public const EGLenum EGL_BAD_CURRENT_SURFACE;
	public const EGLenum EGL_BAD_DISPLAY;
	public const EGLenum EGL_BAD_MATCH;
	public const EGLenum EGL_BAD_NATIVE_PIXMAP;
	public const EGLenum EGL_BAD_NATIVE_WINDOW;
	public const EGLenum EGL_BAD_PARAMETER;
	public const EGLenum EGL_BAD_SURFACE;
	public const EGLenum EGL_CONTEXT_LOST;  /* EGL 1.1 - IMG_power_management */
	
	/* Reserved 0x300F-0x301F for additional errors */
	
	/* Config attributes */
	public const EGLenum EGL_BUFFER_SIZE;
	public const EGLenum EGL_ALPHA_SIZE;
	public const EGLenum EGL_BLUE_SIZE;
	public const EGLenum EGL_GREEN_SIZE;
	public const EGLenum EGL_RED_SIZE;
	public const EGLenum EGL_DEPTH_SIZE;
	public const EGLenum EGL_STENCIL_SIZE;
	public const EGLenum EGL_CONFIG_CAVEAT;
	public const EGLenum EGL_CONFIG_ID;
	public const EGLenum EGL_LEVEL;
	public const EGLenum EGL_MAX_PBUFFER_HEIGHT;
	public const EGLenum EGL_MAX_PBUFFER_PIXELS;
	public const EGLenum EGL_MAX_PBUFFER_WIDTH;
	public const EGLenum EGL_NATIVE_RENDERABLE;
	public const EGLenum EGL_NATIVE_VISUAL_ID;
	public const EGLenum EGL_NATIVE_VISUAL_TYPE;
	public const EGLenum EGL_SAMPLES;
	public const EGLenum EGL_SAMPLE_BUFFERS;
	public const EGLenum EGL_SURFACE_TYPE;
	public const EGLenum EGL_TRANSPARENT_TYPE;
	public const EGLenum EGL_TRANSPARENT_BLUE_VALUE;
	public const EGLenum EGL_TRANSPARENT_GREEN_VALUE;
	public const EGLenum EGL_TRANSPARENT_RED_VALUE;
	public const EGLenum EGL_NONE;  /* Attrib list terminator */
	public const EGLenum EGL_BIND_TO_TEXTURE_RGB;
	public const EGLenum EGL_BIND_TO_TEXTURE_RGBA;
	public const EGLenum EGL_MIN_SWAP_INTERVAL;
	public const EGLenum EGL_MAX_SWAP_INTERVAL;
	public const EGLenum EGL_LUMINANCE_SIZE;
	public const EGLenum EGL_ALPHA_MASK_SIZE;
	public const EGLenum EGL_COLOR_BUFFER_TYPE;
	public const EGLenum EGL_RENDERABLE_TYPE;
	public const EGLenum EGL_MATCH_NATIVE_PIXMAP;  /* Pseudo-attribute (not queryable) */
	public const EGLenum EGL_CONFORMANT;
	
	/* Reserved 0x3041-0x304F for additional config attributes */

	/* Config attribute values */
	public const EGLenum EGL_SLOW_CONFIG;  /* EGL_CONFIG_CAVEAT value */
	public const EGLenum EGL_NON_CONFORMANT_CONFIG;  /* EGL_CONFIG_CAVEAT value */
	public const EGLenum EGL_TRANSPARENT_RGB;  /* EGL_TRANSPARENT_TYPE value */
	public const EGLenum EGL_RGB_BUFFER;  /* EGL_COLOR_BUFFER_TYPE value */
	public const EGLenum EGL_LUMINANCE_BUFFER;  /* EGL_COLOR_BUFFER_TYPE value */

	/* More config attribute values, for EGL_TEXTURE_FORMAT */
	public const EGLenum EGL_NO_TEXTURE;
	public const EGLenum EGL_TEXTURE_RGB;
	public const EGLenum EGL_TEXTURE_RGBA;
	public const EGLenum EGL_TEXTURE_2D;

	/* Config attribute mask bits */
	public const EGLenum EGL_PBUFFER_BIT;  /* EGL_SURFACE_TYPE mask bits */
	public const EGLenum EGL_PIXMAP_BIT;  /* EGL_SURFACE_TYPE mask bits */
	public const EGLenum EGL_WINDOW_BIT;  /* EGL_SURFACE_TYPE mask bits */
	public const EGLenum EGL_VG_COLORSPACE_LINEAR_BIT;  /* EGL_SURFACE_TYPE mask bits */
	public const EGLenum EGL_VG_ALPHA_FORMAT_PRE_BIT;  /* EGL_SURFACE_TYPE mask bits */
	public const EGLenum EGL_MULTISAMPLE_RESOLVE_BOX_BIT;  /* EGL_SURFACE_TYPE mask bits */
	public const EGLenum EGL_SWAP_BEHAVIOR_PRESERVED_BIT;  /* EGL_SURFACE_TYPE mask bits */

	public const EGLenum EGL_OPENGL_ES_BIT;  /* EGL_RENDERABLE_TYPE mask bits */
	public const EGLenum EGL_OPENVG_BIT;  /* EGL_RENDERABLE_TYPE mask bits */
	public const EGLenum EGL_OPENGL_ES2_BIT;  /* EGL_RENDERABLE_TYPE mask bits */
	public const EGLenum EGL_OPENGL_BIT;  /* EGL_RENDERABLE_TYPE mask bits */

	/* QueryString targets */
	public const EGLenum EGL_VENDOR;
	public const EGLenum EGL_VERSION;
	public const EGLenum EGL_EXTENSIONS;
	public const EGLenum EGL_CLIENT_APIS;

	/* QuerySurface / SurfaceAttrib / CreatePbufferSurface targets */
	public const EGLenum EGL_HEIGHT;
	public const EGLenum EGL_WIDTH;
	public const EGLenum EGL_LARGEST_PBUFFER;
	public const EGLenum EGL_TEXTURE_FORMAT;
	public const EGLenum EGL_TEXTURE_TARGET;
	public const EGLenum EGL_MIPMAP_TEXTURE;
	public const EGLenum EGL_MIPMAP_LEVEL;
	public const EGLenum EGL_RENDER_BUFFER;
	public const EGLenum EGL_VG_COLORSPACE;
	public const EGLenum EGL_VG_ALPHA_FORMAT;
	public const EGLenum EGL_HORIZONTAL_RESOLUTION;
	public const EGLenum EGL_VERTICAL_RESOLUTION;
	public const EGLenum EGL_PIXEL_ASPECT_RATIO;
	public const EGLenum EGL_SWAP_BEHAVIOR;
	public const EGLenum EGL_MULTISAMPLE_RESOLVE;

	/* EGL_RENDER_BUFFER values / BindTexImage / ReleaseTexImage buffer targets */
	public const EGLenum EGL_BACK_BUFFER;
	public const EGLenum EGL_SINGLE_BUFFER;

	/* OpenVG color spaces */
	public const EGLenum EGL_VG_COLORSPACE_sRGB;  /* EGL_VG_COLORSPACE value */
	public const EGLenum EGL_VG_COLORSPACE_LINEAR;  /* EGL_VG_COLORSPACE value */

	/* OpenVG alpha formats */
	public const EGLenum EGL_VG_ALPHA_FORMAT_NONPRE;  /* EGL_ALPHA_FORMAT value */
	public const EGLenum EGL_VG_ALPHA_FORMAT_PRE;  /* EGL_ALPHA_FORMAT value */

	/* Constant scale factor by which fractional display resolutions &
	 * aspect ratio are scaled when queried as integer values.
	 */
	public const EGLenum EGL_DISPLAY_SCALING;

	/* Unknown display resolution/aspect ratio */
	public const EGLenum EGL_UNKNOWN;

	/* Back buffer swap behaviors */
	public const EGLenum EGL_BUFFER_PRESERVED;  /* EGL_SWAP_BEHAVIOR value */
	public const EGLenum EGL_BUFFER_DESTROYED;  /* EGL_SWAP_BEHAVIOR value */

	/* CreatePbufferFromClientBuffer buffer types */
	public const EGLenum EGL_OPENVG_IMAGE;

	/* QueryContext targets */
	public const EGLenum EGL_CONTEXT_CLIENT_TYPE;

	/* CreateContext attributes */
	public const EGLenum EGL_CONTEXT_CLIENT_VERSION;

	/* Multisample resolution behaviors */
	public const EGLenum EGL_MULTISAMPLE_RESOLVE_DEFAULT;  /* EGL_MULTISAMPLE_RESOLVE value */
	public const EGLenum EGL_MULTISAMPLE_RESOLVE_BOX;  /* EGL_MULTISAMPLE_RESOLVE value */

	/* BindAPI/QueryAPI targets */
	public const EGLenum EGL_OPENGL_ES_API;
	public const EGLenum EGL_OPENVG_API;
	public const EGLenum EGL_OPENGL_API;

	/* GetCurrentSurface targets */
	public const EGLenum EGL_DRAW;
	public const EGLenum EGL_READ;

	/* WaitNative engines */
	public const EGLenum EGL_CORE_NATIVE_ENGINE;

	/* EGL 1.2 tokens renamed for consistency in EGL 1.3 */
	public const EGLenum EGL_COLORSPACE;
	public const EGLenum EGL_ALPHA_FORMAT;
	public const EGLenum EGL_COLORSPACE_sRGB;
	public const EGLenum EGL_COLORSPACE_LINEAR;
	public const EGLenum EGL_ALPHA_FORMAT_NONPRE;
	public const EGLenum EGL_ALPHA_FORMAT_PRE;

	/* EGL extensions must request enum blocks from the Khronos
	 * API Registrar, who maintains the enumerant registry. Submit
	 * a bug in Khronos Bugzilla against task "Registry".
	 */


	/* EGL Functions */

	public EGLint eglGetError();

	public EGLDisplay eglGetDisplay(EGLNativeDisplayType display_id);
	public EGLBoolean eglInitialize(EGLDisplay dpy, EGLint *major, EGLint *minor);
	public EGLBoolean eglTerminate(EGLDisplay dpy);

	public string eglQueryString(EGLDisplay dpy, EGLint name);

	public EGLBoolean eglGetConfigs(EGLDisplay dpy, EGLConfig *configs, EGLint config_size, EGLint *num_config);
	public EGLBoolean eglChooseConfig(EGLDisplay dpy, EGLint *attrib_list, EGLConfig *configs, EGLint config_size, EGLint *num_config);
	public EGLBoolean eglGetConfigAttrib(EGLDisplay dpy, EGLConfig config, EGLint attribute, EGLint *value);

	public EGLSurface eglCreateWindowSurface(EGLDisplay dpy, EGLConfig config, EGL_DISPMANX_WINDOW_T *win, EGLint *attrib_list); // TODO: Change window type to proper EGL type.
	public EGLSurface eglCreatePbufferSurface(EGLDisplay dpy, EGLConfig config, EGLint *attrib_list);
	public EGLSurface eglCreatePixmapSurface(EGLDisplay dpy, EGLConfig config, EGLNativePixmapType pixmap, EGLint *attrib_list);
	public EGLBoolean eglDestroySurface(EGLDisplay dpy, EGLSurface surface);
	public EGLBoolean eglQuerySurface(EGLDisplay dpy, EGLSurface surface, EGLint attribute, EGLint *value);

	public EGLBoolean eglBindAPI(EGLenum api);
	public EGLenum eglQueryAPI();

	public EGLBoolean eglWaitClient();

	public EGLBoolean eglReleaseThread();

	public EGLSurface eglCreatePbufferFromClientBuffer(EGLDisplay dpy, EGLenum buftype, EGLClientBuffer buffer, EGLConfig config, EGLint *attrib_list);

	public EGLBoolean eglSurfaceAttrib(EGLDisplay dpy, EGLSurface surface, EGLint attribute, EGLint value);
	public EGLBoolean eglBindTexImage(EGLDisplay dpy, EGLSurface surface, EGLint buffer);
	public EGLBoolean eglReleaseTexImage(EGLDisplay dpy, EGLSurface surface, EGLint buffer);

	public EGLBoolean eglSwapInterval(EGLDisplay dpy, EGLint interval);

	public EGLContext eglCreateContext(EGLDisplay dpy, EGLConfig config, EGLContext share_context, EGLint *attrib_list);
	public EGLBoolean eglDestroyContext(EGLDisplay dpy, EGLContext ctx);
	public EGLBoolean eglMakeCurrent(EGLDisplay dpy, EGLSurface draw, EGLSurface read, EGLContext ctx);

	public EGLContext eglGetCurrentContext();
	public EGLSurface eglGetCurrentSurface(EGLint readdraw);
	public EGLDisplay eglGetCurrentDisplay();
	public EGLBoolean eglQueryContext(EGLDisplay dpy, EGLContext ctx, EGLint attribute, EGLint *value);

	public EGLBoolean eglWaitGL();
	public EGLBoolean eglWaitNative(EGLint engine);
	public EGLBoolean eglSwapBuffers(EGLDisplay dpy, EGLSurface surface);
	public EGLBoolean eglCopyBuffers(EGLDisplay dpy, EGLSurface surface, EGLNativePixmapType target);

	// TODO: Not yet done.
	/* This is a generic function pointer type, whose name indicates it must
	 * be cast to the proper type *and calling convention* before use.
	 */
	//typedef void (*__eglMustCastToProperFunctionPointerType)(void);

	/* Now, define eglGetProcAddress using the generic function ptr. type */
	//EGLAPI __eglMustCastToProperFunctionPointerType EGLAPIENTRY
	//	   eglGetProcAddress(const char *procname);	
	
}
