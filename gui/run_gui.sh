#!/bin/bash
# Launcher script for Kernel Installer GUI
# Author: Alexia Michelle <alexia@goldendoglinux.org>

# Determine if we're running from installation or source
if [ -f "/usr/local/share/kernel-installer-gui/kernel_installer_gui.py" ]; then
    # Running from system installation
    GUI_SCRIPT="/usr/local/share/kernel-installer-gui/kernel_installer_gui.py"
else
    # Running from source directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    GUI_SCRIPT="$SCRIPT_DIR/kernel_installer_gui.py"
fi

# Verify that Python3 and GTK3 are installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python3 is not installed."
    echo "Please install it with: sudo apt install python3"
    exit 1
fi

# Verify Python dependencies
python3 -c "import gi; gi.require_version('Gtk', '3.0')" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Error: GTK3 Python bindings are not installed."
    echo "Please install with: sudo apt install python3-gi gir1.2-gtk-3.0 gir1.2-vte-2.91"
    exit 1
fi

# Run the GUI
python3 "$GUI_SCRIPT" "$@"
