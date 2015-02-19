using GLES2;
using Broadcom.VideoCore;

class untitled : GLib.Object {

    public static int main(string[] args) {
		stdout.printf("Initializing Broadcom host...\n");
		Host.init();
		stdout.printf("Broadcom host initialized. Probably.\n");
		
		stdout.printf("SDRAM address: %u\n", Host.get_sdram_address());
		stdout.printf("Peripheral address: %u\n", Host.get_peripheral_address());
		stdout.printf("Peripheral size: %u\n", Host.get_peripheral_size());
		
		uint width = 0;
		uint height = 0;
		int result = Host.get_display_size(0, &width, &height);
		stdout.printf("Display size: %u x %u (result: %d)\n", width, height, result);
		
		stdout.printf("Deinitializing Broadcom host...\n");
		Host.deinit();
		stdout.printf("Broadcom host deinitialized. Probably.\n");
		
		
        return 0;
    }
}
