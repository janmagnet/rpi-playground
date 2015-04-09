/*
 * Raspberry Pi Broadcom hardware interface binding for Vala
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

namespace Broadcom.VideoCore
{
	[CCode(cprefix = "", lower_case_cprefix = "", cheader_filename="bcm_host.h")]
	namespace Host
	{
		[CCode(cname = "bcm_host_init")]
		public void init();
		
		[CCode(cname = "bcm_host_deinit")]
		public void deinit();
		
		[CCode(cname = "graphics_get_display_size")]
		public int32 get_display_size(uint16 display_number, uint32 *width, uint32 *height);
		
		[CCode(cname = "bcm_host_get_peripheral_address")]
		public uint32 get_peripheral_address();
		
		[CCode(cname = "bcm_host_get_peripheral_size")]
		public uint32 get_peripheral_size();
		
		[CCode(cname = "bcm_host_get_sdram_address")]
		public uint32 get_sdram_address();
	}
	
	[CCode(cprefix = "", lower_case_cprefix = "", cheader_filename="interface/vctypes/vc_image_types.h")]
	namespace Image
	{
	
		[CCode(cname = "VC_RECT_T", has_type_id = false)]
		public struct Rectangle {
			int32 x;
			int32 y;
			int32 width;
			int32 height;
		}

		// TODO Figure out what this means. Reference-counted compact class?
		//struct VC_IMAGE_T;
		//typedef struct VC_IMAGE_T VC_IMAGE_T;
		
		/* Types of image supported. */
		/* Please add any new types to the *end* of this list.  Also update
		* case_VC_IMAGE_ANY_xxx macros (below), and the vc_image_type_info table in
		* vc_image/vc_image_helper.c.
		*/
		[CCode(cname = "VC_IMAGE_TYPE_T", cprefix = "VC_IMAGE_", has_type_id = false)]
		public enum ImageType
		{
			MIN, //bounds for error checking

			RGB565,
			1BPP,
			YUV420,
			48BPP,
			RGB888,
			8BPP,
			4BPP,    // 4bpp palettised image
			3D32,    /* A separated format of 16 colour/light shorts followed by 16 z values */
			3D32B,   /* 16 colours followed by 16 z values */
			3D32MAT, /* A separated format of 16 material/colour/light shorts followed by 16 z values */
			RGB2X9,   /* 32 bit format containing 18 bits of 6.6.6 RGB, 9 bits per short */
			RGB666,   /* 32-bit format holding 18 bits of 6.6.6 RGB */
			PAL4_OBSOLETE,     // 4bpp palettised image with embedded palette
			PAL8_OBSOLETE,     // 8bpp palettised image with embedded palette
			RGBA32,   /* RGB888 with an alpha byte after each pixel */ /* xxx: isn't it BEFORE each pixel? */
			YUV422,   /* a line of Y (32-byte padded), a line of U (16-byte padded), and a line of V (16-byte padded) */
			RGBA565,  /* RGB565 with a transparent patch */
			RGBA16,   /* Compressed (4444) version of RGBA32 */
			YUV_UV,   /* VCIII codec format */
			TF_RGBA32, /* VCIII T-format RGBA8888 */
			TF_RGBX32,  /* VCIII T-format RGBx8888 */
			TF_FLOAT, /* VCIII T-format float */
			TF_RGBA16, /* VCIII T-format RGBA4444 */
			TF_RGBA5551, /* VCIII T-format RGB5551 */
			TF_RGB565, /* VCIII T-format RGB565 */
			TF_YA88, /* VCIII T-format 8-bit luma and 8-bit alpha */
			TF_BYTE, /* VCIII T-format 8 bit generic sample */
			TF_PAL8, /* VCIII T-format 8-bit palette */
			TF_PAL4, /* VCIII T-format 4-bit palette */
			TF_ETC1, /* VCIII T-format Ericsson Texture Compressed */
			BGR888,  /* RGB888 with R & B swapped */
			BGR888_NP,  /* RGB888 with R & B swapped, but with no pitch, i.e. no padding after each row of pixels */
			BAYER,  /* Bayer image, extra defines which variant is being used */
			CODEC,  /* General wrapper for codec images e.g. JPEG from camera */
			YUV_UV32,   /* VCIII codec format */
			TF_Y8,   /* VCIII T-format 8-bit luma */
			TF_A8,   /* VCIII T-format 8-bit alpha */
			TF_SHORT,/* VCIII T-format 16-bit generic sample */
			TF_1BPP, /* VCIII T-format 1bpp black/white */
			OPENGL,
			YUV444I, /* VCIII-B0 HVS YUV 4:4:4 interleaved samples */
			YUV422PLANAR,  /* Y, U, & V planes separately (VC_IMAGE_YUV422 has them interleaved on a per line basis) */
			ARGB8888,   /* 32bpp with 8bit alpha at MS byte, with R, G, B (LS byte) */
			XRGB8888,   /* 32bpp with 8bit unused at MS byte, with R, G, B (LS byte) */

			YUV422YUYV,  /* interleaved 8 bit samples of Y, U, Y, V */
			YUV422YVYU,  /* interleaved 8 bit samples of Y, V, Y, U */
			YUV422UYVY,  /* interleaved 8 bit samples of U, Y, V, Y */
			YUV422VYUY,  /* interleaved 8 bit samples of V, Y, U, Y */

			RGBX32,      /* 32bpp like RGBA32 but with unused alpha */
			RGBX8888,    /* 32bpp, corresponding to RGBA with unused alpha */
			BGRX8888,    /* 32bpp, corresponding to BGRA with unused alpha */

			YUV420SP,    /* Y as a plane, then UV byte interleaved in plane with with same pitch, half height */

			YUV444PLANAR,  /* Y, U, & V planes separately 4:4:4 */

			TF_U8,   /* T-format 8-bit U - same as TF_Y8 buf from U plane */
			TF_V8,   /* T-format 8-bit U - same as TF_Y8 buf from V plane */

			MAX,     //bounds for error checking
			FORCE_ENUM_16BIT = 0xffff,
		}
		
		// TODO The last part of vc_image_types.h is not included.
	}

	[CCode(cprefix = "", lower_case_cprefix = "", cheader_filename="interface/vctypes/vc_display_types.h")]
	namespace Display
	{
		[CCode(cname = "DISPLAY_INPUT_FORMAT_T", cprefix = "DISPLAY_INPUT_FORMAT_", has_type_id = false)]
		public enum InputFormat
		{
			INVALID,
			RGB888,
			RGB565
		}
		
		// Enum determining how image data for 3D displays has to be supplied
		[CCode(cname = "DISPLAY_3D_FORMAT_T", cprefix = "DISPLAY_3D_", has_type_id = false)]
		public enum Input3dFormat
		{
			UNSUPPORTED,       // default
			INTERLEAVED,       // For autosteroscopic displays
			SBS_FULL_AUTO,     // Side-By-Side, Full Width (also used by some autostereoscopic displays)
			SBS_HALF_HORIZ,    // Side-By-Side, Half Width, Horizontal Subsampling (see HDMI spec)
			TB_HALF,           // Top-bottom 3D
			FORMAT_MAX
		}

		//enums of display types
		[CCode(cname = "DISPLAY_INTERFACE_T", cprefix = "DISPLAY_INTERFACE_", has_type_id = false)]
		public enum DisplayType
		{
			MIN,
			SMI,
			DPI,
			DSI,
			LVDS,
			MAX
		}

		/* display dither setting, used on B0 */
		[CCode(cname = "DISPLAY_DITHER_T", cprefix = "DISPLAY_DITHER_", has_type_id = false)]
		public enum Dither {
			NONE,   /* default if not set */
			RGB666,
			RGB565,
			RGB555,
			MAX
		}
		
		//info struct
		[CCode(cname = "DISPLAY_INFO_T", has_type_id = false)]
		public struct DisplayInfo
		{
			//type
			DisplayType type;
			//width / height
			uint32 width;
			uint32 height;
			//output format
			InputFormat input_format;
			//interlaced?
			uint32 interlaced;
			/* output dither setting (if required) */
			Dither output_dither;
			/* Pixel frequency */
			uint32 pixel_freq;
			/* Line rate in lines per second */
			uint32 line_rate;
			// Format required for image data for 3D displays
			Input3dFormat format_3d;
			// If display requires PV1 (e.g. DSI1), special config is required in HVS
			uint32 use_pixelvalve_1;
			// Set for DSI displays which use video mode.
			uint32 dsi_video_mode;
			// Select HVS channel (usually 0).
			uint32 hvs_channel;
		}
	}
	
	
	[CCode(cprefix = "", lower_case_cprefix = "", cheader_filename="interface/vchi/vchi_mh.h")]
	namespace HiMemory
	{
		[SimpleType]
		public struct VCHI_MEM_HANDLE_T: int32 { }
		
		public const VCHI_MEM_HANDLE_T VCHI_MEM_HANDLE_INVALID;
	}

	
	[CCode(cprefix = "", lower_case_cprefix = "", cheader_filename="interface/vmcs_host/vc_dispmanx.h")]
	namespace DisplayManager
	{
		/*-------------------------------------------------------------------------
		 * Data type definitions
		 *-----------------------------------------------------------------------*/
		 
		[SimpleType]
		public struct DISPMANX_DISPLAY_HANDLE_T: uint32 { }
		
		[SimpleType]
		public struct DISPMANX_UPDATE_HANDLE_T: uint32 { }
		
		[SimpleType]
		public struct DISPMANX_ELEMENT_HANDLE_T: uint32 { }
		
		[SimpleType]
		public struct DISPMANX_RESOURCE_HANDLE_T: uint32 { }
		
		[SimpleType]
		public struct DISPMANX_PROTECTION_T: uint32 { }
		
		public const DISPMANX_DISPLAY_HANDLE_T DISPMANX_NO_HANDLE;
		
		[CCode(cname = "int", cprefix = "DISPMANX_PROTECTION_", has_type_id = false)]
		public enum Protection {
			MAX,
			NONE,
			HDCP
		}

		/* Default display IDs.
		   Note: if you overwrite with you own dispmanx_platfrom_init function, you
		   should use IDs you provided during dispmanx_display_attach.
		*/
		[CCode(cname = "int", cprefix = "DISPMANX_ID_", has_type_id = false)]
		public enum DisplayId {
			MAIN_LCD,
			AUX_LCD,
			HDMI,
			SDTV,
			LCD,
			TV,
			OTHER /* non-default display */
		}
		
		/* Return codes. Nonzero ones indicate failure. */
		[CCode(cname = "DISPMANX_STATUS_T", cprefix = "DISPMANX_", has_type_id = false)]
		public enum ReturnCode {
			SUCCESS,
			INVALID
			/* XXX others TBA */
		}

		[CCode(cname = "DISPMANX_TRANSFORM_T", cprefix = "DISPMANX_", has_type_id = false)]
		[Flags]
		public enum Transform {
			/* Bottom 2 bits sets the orientation */
			NO_ROTATE,
			ROTATE_90,
			ROTATE_180,
			ROTATE_270,

			FLIP_HRIZ,
			FLIP_VERT,

			/* extra flags for controlling snapshot behaviour */
			SNAPSHOT_NO_YUV,
			SNAPSHOT_NO_RGB,
			SNAPSHOT_FILL,
			SNAPSHOT_SWAP_RED_BLUE,
			SNAPSHOT_PACK
		}

		[CCode(cname = "DISPMANX_FLAGS_ALPHA_T", cprefix = "DISPMANX_FLAGS_ALPHA_", has_type_id = false)]
		[Flags]
		public enum AlphaMode {
			/* Bottom 2 bits sets the alpha mode */
			FROM_SOURCE,
			FIXED_ALL_PIXELS,
			FIXED_NON_ZERO,
			FIXED_EXCEED_0X07,

			PREMULT,
			MIX
		}
		
		[CCode(cname = "DISPMANX_ALPHA_T", has_type_id = false)]
		public struct Alpha {
			AlphaMode flags;
			uint32 opacity;
			Image.ImageType *mask;
		}

		/* for use with vmcs_host */
		[CCode(cname = "VC_DISPMANX_ALPHA_T", has_type_id = false)]
		public struct AlphaVC {
			AlphaMode flags;
			uint32 opacity;
			DISPMANX_RESOURCE_HANDLE_T mask;
		}  

		[CCode(cname = "DISPMANX_FLAGS_CLAMP_T", cprefix = "DISPMANX_FLAGS_CLAMP_", has_type_id = false)]
		[Flags]
		public enum ClampMode {
			NONE,
			LUMA_TRANSPARENT,
			TRANSPARENT,
			REPLACE,
			CHROMA_TRANSPARENT
		}
		
		[CCode(cname = "DISPMANX_FLAGS_KEYMASK_T", cprefix = "DISPMANX_FLAGS_KEYMASK_", has_type_id = false)]
		[Flags]
		public enum KeyMask {
			OVERRIDE,
			SMOOTH,
			CR_INV,
			CB_INV,
			YY_INV
		}
		
		[CCode(cname = "DISPMANX_CLAMP_KEYS_T", has_type_id = false)]
		public struct ClampKeys {
			[CCode(cname = "yuv.yy_upper")]
			uint8 yy_upper;
			[CCode(cname = "yuv.yy_lower")]
			uint8 yy_lower;
			[CCode(cname = "yuv.cr_upper")]
			uint8 cr_upper;
			[CCode(cname = "yuv.cr_lower")]
			uint8 cr_lower;
			[CCode(cname = "yuv.cb_upper")]
			uint8 cb_upper;
			[CCode(cname = "yuv.cb_lower")]
			uint8 cb_lower;
			[CCode(cname = "rgb.red_upper")]
			uint8 red_upper;
			[CCode(cname = "rgb.red_lower")]
			uint8 red_lower;
			[CCode(cname = "rgb.blue_upper")]
			uint8 blue_upper;
			[CCode(cname = "rgb.blue_lower")]
			uint8 blue_lower;
			[CCode(cname = "rgb.green_upper")]
			uint8 green_upper;
			[CCode(cname = "rgb.green_lower")]
			uint8 green_lower;
		}
		
		[CCode(cname = "DISPMANX_CLAMP_T", has_type_id = false)]
		public struct Clamp {
			ClampMode mode;
			KeyMask key_mask;
			ClampKeys key_value;
			uint32 replace_value;
		}

		[CCode(cname = "DISPMANX_MODEINFO_T", has_type_id = false)]
		public struct ModeInfo {
			int32 width;
			int32 height;
			Transform transform;
			Display.InputFormat input_format;
		}
		
		/* Update callback. */
		[CCode(cname = "DISPMANX_CALLBACK_FUNC_T", has_type_id = false)]
		public delegate void UpdateCallback(DISPMANX_UPDATE_HANDLE_T u);
		
		/* Progress callback */
		[CCode(cname = "DISPMANX_PROGRESS_CALLBACK_FUNC_T", has_type_id = false)]
		public delegate void ProgressCallback(DISPMANX_UPDATE_HANDLE_T u, uint32 line);
		
		
		/* Pluggable display interface delegates */
		[CCode(cname = "get_hvs_config", has_target = false)]
		public delegate int32 GetHvsConfig(void *instance, uint32 *pchan, uint32 *poptions, Display.DisplayInfo *info, uint32 *bg_colour, uint32 *test_mode);

		[CCode(cname = "get_gamma_params", has_target = false)]
		public delegate int32 GetGammaParams(void * instance, int32 gain[3], int32 offset[3], int32 gamma[3]);
		[CCode(cname = "get_oled_params", has_target = false)]
		public delegate int32 GetOledParams(void * instance, uint32 * poffsets, uint32 coeffs[3]);
		[CCode(cname = "get_dither", has_target = false)]
		public delegate int32 GetDither(void * instance, uint32 * dither_depth, uint32 * dither_type);

		[CCode(cname = "get_info", has_target = false)]
		public delegate int32 GetInfo(void * instance, ModeInfo * info);

		[CCode(cname = "open", has_target = false)]
		public delegate int32 Open(void * instance);
		[CCode(cname = "close", has_target = false)]
		public delegate int32 Close(void * instance);

		[CCode(cname = "dlist_updated", has_target = false)]
		public delegate void DlistUpdated(void * instance, uint32 * fifo_reg);

		[CCode(cname = "eof_callback", has_target = false)]
		public delegate void EofCallback(void * instance);

		[CCode(cname = "get_input_format", has_target = false)]
		public delegate ModeInfo GetInputFormat(void * instance);

		[CCode(cname = "suspend_resume", has_target = false)]
		public delegate int32 SuspendResume(void *instance, int up);

		[CCode(cname = "get_3d_format", has_target = false)]
		public delegate Display.Input3dFormat Get3dFormat(void * instance);
		
		
		/* Pluggable display interface */
		[CCode(cname = "DISPMANX_DISPLAY_FUNCS_T", has_type_id = false)]
		public struct DisplayFunctions {
			// Get essential HVS configuration to be passed to the HVS driver. Options
			// is any combination of the following flags: HVS_ONESHOT, HVS_FIFOREG,
			// HVS_FIFO32, HVS_AUTOHSTART, HVS_INTLACE; and if HVS_FIFOREG, one of;
			// { HVS_FMT_RGB888, HVS_FMT_RGB565, HVS_FMT_RGB666, HVS_FMT_YUV }.
			[CCode(delegate_target_cname = "get_hvs_config")]
			public unowned GetHvsConfig get_hvs_config;
			
			// Get optional HVS configuration for gamma tables, OLED matrix and dither controls.
			// Set these function pointers to NULL if the relevant features are not required.
			[CCode(delegate_target_cname = "get_gamma_params")]
			public unowned GetGammaParams get_gamma_params;
			[CCode(delegate_target_cname = "get_oled_params")]
			public unowned GetOledParams get_oled_params;
			[CCode(delegate_target_cname = "get_dither")]
			public unowned GetDither get_dither;

			// Get mode information, which may be returned to the applications as a courtesy.
			// Transform should be set to 0, and {width,height} should be final dimensions.
			[CCode(delegate_target_cname = "get_info")]
			public unowned GetInfo get_info;

			// Inform driver that the application refcount has become nonzero / zero
			// These callbacks might perhaps be used for backlight and power management.
			[CCode(delegate_target_cname = "open")]
			public unowned Open open;
			[CCode(delegate_target_cname = "close")]
			public unowned Close close;

			// Display list updated callback. Primarily of use to a "one-shot" display.
			// For convenience of the driver, we pass the register address of the HVS FIFO.
			[CCode(delegate_target_cname = "dlist_updated")]
			public unowned DlistUpdated dlist_updated;

			// End-of-field callback. This may occur in an interrupt context.
			[CCode(delegate_target_cname = "eof_callback")]
			public unowned EofCallback eof_callback;

			// Return screen resolution format
			[CCode(delegate_target_cname = "get_input_format")]
			public unowned GetInputFormat get_input_format;

			[CCode(delegate_target_cname = "suspend_resume")]
			public unowned SuspendResume suspend_resume;

			[CCode(delegate_target_cname = "get_3d_format")]
			public unowned Get3dFormat get_3d_format;
		}		
		
		// TODO: Methods above should use Vala naming convention of lower_snake_case.
		
			 
		/*-------------------------------------------------------------------------
		 * vchostif and related functions.
		 *-----------------------------------------------------------------------*/
		
		[CCode(cname = "vc_dispmanx_init")]
		int32 init();
		
		// Stop the service from being used
		[CCode(cname = "vc_dispmanx_stop")]
		void stop();
		
		
		// Set the entries in the rect structure
		[CCode(cname = "vc_dispmanx_rect_set")]
		int32 rect_set( Image.Rectangle *rect, uint32 x_offset, uint32 y_offset, uint32 width, uint32 height );
		
		
		/*-------------------------------------------------------------------------
		 * Resources
		 *-----------------------------------------------------------------------*/
		 
		// Create a new resource
		[CCode(cname = "vc_dispmanx_resource_create")]
		DISPMANX_RESOURCE_HANDLE_T resource_create( Image.ImageType type, uint32 width, uint32 height, uint32 *native_image_handle );
		// Write the bitmap data to VideoCore memory
		[CCode(cname = "vc_dispmanx_resource_write_data")]
		int32 resource_write_data( DISPMANX_RESOURCE_HANDLE_T res, Image.ImageType src_type, int32 src_pitch, void * src_address, Image.Rectangle * rect );
		[CCode(cname = "vc_dispmanx_resource_write_data_handle")]
		int32 resource_write_data_handle( DISPMANX_RESOURCE_HANDLE_T res, Image.ImageType src_type, int32 src_pitch, HiMemory.VCHI_MEM_HANDLE_T handle, uint32 offset, Image.Rectangle * rect );
		[CCode(cname = "vc_dispmanx_resource_read_data")]
		int32 resource_read_data( DISPMANX_RESOURCE_HANDLE_T handle, Image.Rectangle* p_rect, void * dst_address, uint32 dst_pitch );
		// Delete a resource
		[CCode(cname = "vc_dispmanx_resource_delete")]
		int32 resource_delete( DISPMANX_RESOURCE_HANDLE_T res );
		
		
		/*-------------------------------------------------------------------------
		 * Displays
		 *-----------------------------------------------------------------------*/
		
		// Opens a display on the given device
		[CCode(cname = "vc_dispmanx_display_open")]
		DISPMANX_DISPLAY_HANDLE_T display_open( uint32 device );
		// Opens a display on the given device in the request mode
		[CCode(cname = "vc_dispmanx_display_open_mode")]
		DISPMANX_DISPLAY_HANDLE_T display_open_mode( uint32 device, uint32 mode );
		// Open an offscreen display
		[CCode(cname = "vc_dispmanx_display_open_offscreen")]
		DISPMANX_DISPLAY_HANDLE_T display_open_offscreen( DISPMANX_RESOURCE_HANDLE_T dest, Transform orientation );
		// Change the mode of a display
		[CCode(cname = "vc_dispmanx_display_reconfigure")]
		int32 display_reconfigure( DISPMANX_DISPLAY_HANDLE_T display, uint32 mode );
		// Sets the desstination of the display to be the given resource
		[CCode(cname = "vc_dispmanx_display_set_destination")]
		int32 display_set_destination( DISPMANX_DISPLAY_HANDLE_T display, DISPMANX_RESOURCE_HANDLE_T dest );
		// Set the background colour of the display
		[CCode(cname = "vc_dispmanx_display_set_background")]
		int32 display_set_background( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_DISPLAY_HANDLE_T display, uint8 red, uint8 green, uint8 blue );
		// get the width, height, frame rate and aspect ratio of the display
		[CCode(cname = "vc_dispmanx_display_get_info")]
		int32 display_get_info( DISPMANX_DISPLAY_HANDLE_T display, ModeInfo * pinfo );
		// Closes a display
		[CCode(cname = "vc_dispmanx_display_close")]
		int32 display_close( DISPMANX_DISPLAY_HANDLE_T display );

		
		/*-------------------------------------------------------------------------
		 * Updates
		 *-----------------------------------------------------------------------*/

		// Start a new update, DISPMANX_NO_HANDLE on error
		[CCode(cname = "vc_dispmanx_update_start")]
		DISPMANX_UPDATE_HANDLE_T update_start( int32 priority );
		// Add an elment to a display as part of an update
		[CCode(cname = "vc_dispmanx_element_add")]
		DISPMANX_ELEMENT_HANDLE_T element_add ( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_DISPLAY_HANDLE_T display,
																			 int32 layer, Image.Rectangle *dest_rect, DISPMANX_RESOURCE_HANDLE_T src,
																			 Image.Rectangle *src_rect, DISPMANX_PROTECTION_T protection, 
																			 AlphaVC *alpha,
																			 Clamp *clamp, Transform transform );
		// Change the source image of a display element
		[CCode(cname = "vc_dispmanx_element_change_source")]
		int32 element_change_source( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element,
																DISPMANX_RESOURCE_HANDLE_T src );
		// Change the layer number of a display element
		[CCode(cname = "vc_dispmanx_element_change_layer")]
		int32 element_change_layer ( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element,
																int32 layer );
		// Signal that a region of the bitmap has been modified
		[CCode(cname = "vc_dispmanx_element_modified")]
		int32 element_modified( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element, Image.Rectangle * rect );
		// Remove a display element from its display
		[CCode(cname = "vc_dispmanx_element_remove")]
		int32 element_remove( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element );
		// Ends an update
		[CCode(cname = "vc_dispmanx_update_submit")]
		int32 update_submit( DISPMANX_UPDATE_HANDLE_T update, UpdateCallback cb_func, void *cb_arg );
		// End an update and wait for it to complete
		[CCode(cname = "vc_dispmanx_update_submit_sync")]
		int32 update_submit_sync( DISPMANX_UPDATE_HANDLE_T update );
		// Query the image formats supported in the VMCS build
		[CCode(cname = "vc_dispmanx_query_image_formats")]
		int32 query_image_formats( uint32 *supported_formats );

		//New function added to VCHI to change attributes, set_opacity does not work there.
		[CCode(cname = "vc_dispmanx_element_change_attributes")]
		int32 element_change_attributes( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element, uint32 change_flags, int32 layer, uint8 opacity, Image.Rectangle *dest_rect, Image.Rectangle *src_rect, DISPMANX_RESOURCE_HANDLE_T mask, Transform transform );

		//xxx hack to get the image pointer from a resource handle, will be obsolete real soon
		[CCode(cname = "vc_dispmanx_vresource_get_image_handle")]
		uint32 vresource_get_image_handle( DISPMANX_RESOURCE_HANDLE_T res);

		// TODO Commented out due to VCHI includes not yet handled.
		//Call this instead of vc_dispman_init (vc_dispmanx_init)
		//[CCode(cname = "vc_vchi_dispmanx_init")]
		//void vchi_init (VCHI_INSTANCE_T initialise_instance, VCHI_CONNECTION_T **connections, uint32 num_connections );

		// Take a snapshot of a display in its current state.
		// This call may block for a time; when it completes, the snapshot is ready.
		// only transform=0 is supported
		[CCode(cname = "vc_dispmanx_snapshot")]
		int32 snapshot( DISPMANX_DISPLAY_HANDLE_T display, DISPMANX_RESOURCE_HANDLE_T snapshot_resource, Transform transform );

		// Set the resource palette (for VC_IMAGE_4BPP and VC_IMAGE_8BPP)
		[CCode(cname = "vc_dispmanx_resource_set_palette")]
		int32 resource_set_palette( DISPMANX_RESOURCE_HANDLE_T handle, void * src_address, int32 offset, int32 size);

		// Start triggering callbacks synced to vsync
		[CCode(cname = "vc_dispmanx_vsync_callback")]
		int32 vsync_callback( DISPMANX_DISPLAY_HANDLE_T display, UpdateCallback cb_func, void *cb_arg );

	}
	
	[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename="interface/vmcs_host/vc_tvservice.h")]
	namespace TvService
	{
	}
	
	[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename="interface/vmcs_host/vc_cecservice.h")]
	namespace CecService
	{
	}
	
	[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename="interface/vmcs_host/vcgencmd.h")]
	namespace GenCmd
	{
	}
}
