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
	[CCode (cheader_filename="bcm_host.h")]
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
	
	[CCode (lower_case_cprefix = "vc_dispman_", cheader_filename="interface/vmcs_host/vc_dispmanx.h")]
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
		
		public const uint32 DISPMANX_NO_HANDLE;
		
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
			VC_IMAGE_T *mask;
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
			DISPLAY_INPUT_FORMAT_T input_format;
		}
		
		/* Update callback. */
		[CCode(cname = "DISPMANX_CALLBACK_FUNC_T", has_type_id = false)]
		public delegate void UpdateCallback(DISPMANX_UPDATE_HANDLE_T u);
		
		/* Progress callback */
		[CCode(cname = "DISPMANX_PROGRESS_CALLBACK_FUNC_T", has_type_id = false)]
		public delegate void ProgressCallback(DISPMANX_UPDATE_HANDLE_T u, uint32 line);
		
		
		/* Pluggable display interface delegates */
		[CCode(cname = "get_hvs_config", has_target = false)]
		public delegate int32 GetHvsConfig(void *instance, uint32 *pchan, uint32 *poptions, DISPLAY_INFO_T *info, uint32 *bg_colour, uint32 *test_mode);

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
		public delegate DISPLAY_3D_FORMAT_T Get3dFormat(void * instance);
		
		
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

		
		
			 
		/*-------------------------------------------------------------------------
		 * vchostif and related functions.
		 *-----------------------------------------------------------------------*/
		
		[CCode(cname = "vc_dispman_init")]
		int32 init();
		
		// Stop the service from being used
		[CCode(cname = "vc_dispman_stop")]
		void stop();
		
		
		// Set the entries in the rect structure
		[CCode(cname = "vc_dispman_rect_set")]
		int32 rect_set( VC_RECT_T *rect, uint32 x_offset, uint32 y_offset, uint32 width, uint32 height );
		
		
		/*-------------------------------------------------------------------------
		 * Resources
		 *-----------------------------------------------------------------------*/
		 
		// Create a new resource
		[CCode(cname = "vc_dispman_resource_create")]
		DISPMANX_RESOURCE_HANDLE_T resource_create( VC_IMAGE_TYPE_T type, uint32 width, uint32 height, uint32 *native_image_handle );
		// Write the bitmap data to VideoCore memory
		[CCode(cname = "vc_dispman_resource_write_data")]
		int32 resource_write_data( DISPMANX_RESOURCE_HANDLE_T res, VC_IMAGE_TYPE_T src_type, int32 src_pitch, void * src_address, VC_RECT_T * rect );
		[CCode(cname = "vc_dispman_resource_write_data_handle")]
		int32 resource_write_data_handle( DISPMANX_RESOURCE_HANDLE_T res, VC_IMAGE_TYPE_T src_type, int32 src_pitch, VCHI_MEM_HANDLE_T handle, uint32 offset, VC_RECT_T * rect );
		[CCode(cname = "vc_dispman_resource_read_data")]
		int32 resource_read_data( DISPMANX_RESOURCE_HANDLE_T handle, VC_RECT_T* p_rect, void * dst_address, uint32 dst_pitch );
		// Delete a resource
		[CCode(cname = "vc_dispman_resource_delete")]
		int32 resource_delete( DISPMANX_RESOURCE_HANDLE_T res );
		
		
		/*-------------------------------------------------------------------------
		 * Displays
		 *-----------------------------------------------------------------------*/
		
		// Opens a display on the given device
		[CCode(cname = "vc_dispman_display_open")]
		DISPMANX_DISPLAY_HANDLE_T display_open( uint32 device );
		// Opens a display on the given device in the request mode
		[CCode(cname = "vc_dispman_display_open_mode")]
		DISPMANX_DISPLAY_HANDLE_T display_open_mode( uint32 device, uint32 mode );
		// Open an offscreen display
		[CCode(cname = "vc_dispman_display_open_offscreen")]
		DISPMANX_DISPLAY_HANDLE_T display_open_offscreen( DISPMANX_RESOURCE_HANDLE_T dest, Transform orientation );
		// Change the mode of a display
		[CCode(cname = "vc_dispman_display_reconfigure")]
		int32 display_reconfigure( DISPMANX_DISPLAY_HANDLE_T display, uint32 mode );
		// Sets the desstination of the display to be the given resource
		[CCode(cname = "vc_dispman_display_set_destination")]
		int32 display_set_destination( DISPMANX_DISPLAY_HANDLE_T display, DISPMANX_RESOURCE_HANDLE_T dest );
		// Set the background colour of the display
		[CCode(cname = "vc_dispman_display_set_background")]
		int32 display_set_background( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_DISPLAY_HANDLE_T display, uint8 red, uint8 green, uint8 blue );
		// get the width, height, frame rate and aspect ratio of the display
		[CCode(cname = "vc_dispman_display_get_info")]
		int32 display_get_info( DISPMANX_DISPLAY_HANDLE_T display, ModeInfo * pinfo );
		// Closes a display
		[CCode(cname = "vc_dispman_display_close")]
		int32 display_close( DISPMANX_DISPLAY_HANDLE_T display );

		
		/*-------------------------------------------------------------------------
		 * Updates
		 *-----------------------------------------------------------------------*/

		// Start a new update, DISPMANX_NO_HANDLE on error
		[CCode(cname = "vc_dispman_update_start")]
		DISPMANX_UPDATE_HANDLE_T update_start( int32 priority );
		// Add an elment to a display as part of an update
		[CCode(cname = "vc_dispman_element_add")]
		DISPMANX_ELEMENT_HANDLE_T element_add ( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_DISPLAY_HANDLE_T display,
																			 int32 layer, VC_RECT_T *dest_rect, DISPMANX_RESOURCE_HANDLE_T src,
																			 VC_RECT_T *src_rect, DISPMANX_PROTECTION_T protection, 
																			 VC_DISPMANX_ALPHA_T *alpha,
																			 Clamp *clamp, Transform transform );
		// Change the source image of a display element
		[CCode(cname = "vc_dispman_element_change_source")]
		int32 element_change_source( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element,
																DISPMANX_RESOURCE_HANDLE_T src );
		// Change the layer number of a display element
		[CCode(cname = "vc_dispman_element_change_layer")]
		int32 element_change_layer ( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element,
																int32 layer );
		// Signal that a region of the bitmap has been modified
		[CCode(cname = "vc_dispman_element_modified")]
		int32 element_modified( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element, VC_RECT_T * rect );
		// Remove a display element from its display
		[CCode(cname = "vc_dispman_element_remove")]
		int32 element_remove( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element );
		// Ends an update
		[CCode(cname = "vc_dispman_update_submit")]
		int32 update_submit( DISPMANX_UPDATE_HANDLE_T update, UpdateCallback cb_func, void *cb_arg );
		// End an update and wait for it to complete
		[CCode(cname = "vc_dispman_update_submit_sync")]
		int32 update_submit_sync( DISPMANX_UPDATE_HANDLE_T update );
		// Query the image formats supported in the VMCS build
		[CCode(cname = "vc_dispman_query_image_formats")]
		int32 query_image_formats( uint32 *supported_formats );

		//New function added to VCHI to change attributes, set_opacity does not work there.
		[CCode(cname = "vc_dispman_element_change_attributes")]
		int32 element_change_attributes( DISPMANX_UPDATE_HANDLE_T update, DISPMANX_ELEMENT_HANDLE_T element, uint32 change_flags, int32 layer, uint8 opacity, VC_RECT_T *dest_rect, VC_RECT_T *src_rect, DISPMANX_RESOURCE_HANDLE_T mask, Transform transform );

		//xxx hack to get the image pointer from a resource handle, will be obsolete real soon
		[CCode(cname = "vc_dispman_vresource_get_image_handle")]
		uint32 vresource_get_image_handle( DISPMANX_RESOURCE_HANDLE_T res);

		//Call this instead of vc_dispman_init (vc_dispmanx_init)
		[CCode(cname = "vc_vchi_dispmanx_init")]
		void vchi_init (VCHI_INSTANCE_T initialise_instance, VCHI_CONNECTION_T **connections, uint32 num_connections );

		// Take a snapshot of a display in its current state.
		// This call may block for a time; when it completes, the snapshot is ready.
		// only transform=0 is supported
		[CCode(cname = "vc_dispman_snapshot")]
		int32 snapshot( DISPMANX_DISPLAY_HANDLE_T display, DISPMANX_RESOURCE_HANDLE_T snapshot_resource, Transform transform );

		// Set the resource palette (for VC_IMAGE_4BPP and VC_IMAGE_8BPP)
		[CCode(cname = "vc_dispman_resource_set_palette")]
		int32 resource_set_palette( DISPMANX_RESOURCE_HANDLE_T handle, void * src_address, int32 offset, int32 size);

		// Start triggering callbacks synced to vsync
		[CCode(cname = "vc_dispman_vsync_callback")]
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
