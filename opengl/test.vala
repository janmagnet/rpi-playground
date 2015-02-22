using GLES2;
using Broadcom.VideoCore;
using Broadcom.VideoCore.DisplayManager;

class untitled : GLib.Object {

    public static int main(string[] args) {
		Host.init();
		stdout.printf("Broadcom VideoCore host initialized.\n");
		
		//stdout.printf("SDRAM address: %u\n", Host.get_sdram_address());
		//stdout.printf("Peripheral address: %u\n", Host.get_peripheral_address());
		//stdout.printf("Peripheral size: %u\n", Host.get_peripheral_size());
		
		ModeInfo info = ModeInfo();
		var displayId = DisplayId.MAIN_LCD;
		
		var displayHandle = display_open(displayId);
		display_get_info(displayHandle, &info);
		display_close(displayId);
		
		stdout.printf("Display size: %u x %u\n", info.width, info.height);
		
		Host.deinit();
		stdout.printf("Broadcom VideoCore host deinitialized.\n");
		
		
        return 0;
    }
}
