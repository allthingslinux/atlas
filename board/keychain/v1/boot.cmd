# Atlas Keychain Boot Script - Direct SPI Flash Boot
# This script forces SPI flash boot, bypassing distro_bootcmd

echo "=== Keychain SPI Flash Boot Sequence ==="

# Set bootargs for UBI filesystem on SPI flash  
setenv bootargs "console=ttyS0,115200 console=ttyGS0,115200 ubi.mtd=1 ubi.block=0,root root=/dev/ubiblock0_2"

# Probe SPI flash
echo "Probing SPI flash..."
sf probe 0

# Debug: List MTD devices
echo "Available MTD devices:"
mtd list

# Attach UBI partition using MTD device (mtd1 should be the rootubi partition)
echo "Loading kernel and device tree from UBI..."
if ubi part mtd1; then
    echo "UBI partition attached successfully"
    ubi info l
    if ubi read ${kernel_addr_r} kernel; then
        echo "Kernel loaded successfully"
        if ubi read ${fdt_addr_r} dtb; then
            echo "Device tree loaded successfully"
            echo "Booting kernel..."
            bootz ${kernel_addr_r} - ${fdt_addr_r}
        else
            echo "ERROR: Failed to load device tree from UBI"
        fi
    else
        echo "ERROR: Failed to load kernel from UBI"
    fi
else
    echo "ERROR: Failed to attach UBI partition"
    echo "Trying alternative partition names..."
    if ubi part rootubi; then
        echo "Found rootubi partition"
        ubi info l
        if ubi read ${kernel_addr_r} kernel; then
            echo "Kernel loaded successfully"
            if ubi read ${fdt_addr_r} dtb; then
                echo "Device tree loaded successfully"
                echo "Booting kernel..."
                bootz ${kernel_addr_r} - ${fdt_addr_r}
            else
                echo "ERROR: Failed to load device tree from UBI"
            fi
        else
            echo "ERROR: Failed to load kernel from UBI"
        fi
    fi
fi

echo "=== SPI Flash boot failed ==="
