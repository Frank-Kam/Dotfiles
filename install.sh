#!/bin/bash

# Main installation script for UmmIt OS

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all library functions
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/display-utils.sh"

# Main function
main() {

    if ! check_git && check_paru; then
        echo "${COLOR_BLUE}:: Checking dependencies...${COLOR_RESET}"
        echo "${COLOR_RED}:: Dependencies not verified!${COLOR_RESET}"
        echo "${COLOR_RED}:: That seems like you dont have git or paru installed.${COLOR_RESET}"
        echo "${COLOR_RED}:: you will need to install them to continue.${COLOR_RESET}"
        exit 1
    fi
    
    # Install packages from install-packages.sh
    source ./install/install-packages.sh

    # Copy configuration files
    source ./install/copy-config.sh

    # Setup display manager
    source ./install/setup-dm.sh

    # Display completion message
    display_completion_message
}

# Main script execution, only run if the script is executed directly, not sourced
# Only allow Arch Linux to run the script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [ -f /etc/arch-release ]; then
        clear_screen
        draw_header_cli
        prompt_installation
        main
    else
        echo "${COLOR_YELLOW}:: Sorry, Script only allows Arch Linux to run.${COLOR_RESET}"
        exit 1
    fi
fi