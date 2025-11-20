#!/bin/bash
# Kernel Installer by Alexia Michelle <alexia@goldendoglinux.org>
# License GNU GPL 3.0 (See License for more Information)

# This is a script for those who wish to compile the program. If you don't want to compile it, you can simply run
# ./kernel-installer

compile() {
    # Install compilation dependencies including kernel headers and GUI dependencies
    echo "Installing compilation dependencies..."
    sudo apt update
    sudo apt install -y build-essential gcc make gettext linux-libc-dev libc6-dev \
        python3 python3-gi gir1.2-gtk-3.0 gir1.2-vte-2.91
    
    echo ""
    echo "Compiling..."
    make clean
    make
    
    echo ""
    echo "Installing..."
    sudo make install
    
    echo ""
    echo "✓ Installation complete!"
    echo ""
    echo "How do you want to run the Kernel Installer?"
    echo "1) Terminal (CLI)"
    echo "2) Graphical Interface (GUI)"
    echo -n "Choose an option [1/2]: "
    read mode
    
    case $mode in
        1)
            echo ""
            echo "Starting Kernel Installer in terminal mode..."
            kernel-installer
            ;;
        2)
            echo ""
            echo "Starting Kernel Installer in GUI mode..."
            kernel-installer-gui
            ;;
        *)
            echo ""
            echo "Invalid option. You can run manually:"
            echo "  - Terminal: kernel-installer"
            echo "  - GUI:      kernel-installer-gui"
            ;;
    esac
}


echo -e "\nThis is a script for those who wish to compile the program.\nIf you don't want to compile it, you can simply run ./kernel-installer.\nIt also requires sudo. If your system doesn't have sudo, run it as root\n\nDo you want to compile anyway? [Y/N]"
read i

case $i in

Y|y|S|s)
compile
;;
N|n)
echo -e "\nAborting."
;;
*)
echo "Incorrect option"
;;
esac
