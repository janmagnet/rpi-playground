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
 * Bindings is incomplete. Only bindings necessary for Raspberry Pi
 * OpenGL ES example has been included at this time.
 */ 
[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename="EGL/egl.h")]
namespace EGL
{
	/*
	 * Additional functions needed to implement Raspberry Pi
	 * OpenGL ES example:
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
	 
    /*-------------------------------------------------------------------------
     * Data type definitions
     *-----------------------------------------------------------------------*/
     
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
	
	// TODO Should be some soft of pointer void*
	[SimpleType]
	public struct EGLNativeDisplayType: uint32 { }
		
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
	// TODO Should be some soft of pointer void*
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
	public const EGLenum EGL_CONTEXT_LOST;
	
	/* Config attribute mask bits */
	// TODO Missing the rest of this section.
	public const EGLenum EGL_WINDOW_BIT;	/* EGL_SURFACE_TYPE mask bits */
	
	/* Config attributes */
	// TODO Missing the rest of this section.
	public const EGLenum EGL_BUFFER_SIZE;
	public const EGLenum EGL_ALPHA_SIZE;
	public const EGLenum EGL_BLUE_SIZE;
	public const EGLenum EGL_GREEN_SIZE;
	public const EGLenum EGL_RED_SIZE;
	public const EGLenum EGL_SURFACE_TYPE;
	public const EGLenum EGL_NONE;	/* Attrib list terminator */
	
}
