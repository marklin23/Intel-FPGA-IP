#!/bin/sh

echo ""
echo "Creating Qsys TCL header..."
echo ""

./build_tcl_header.sh

echo ""
echo "Launching system-console..."

system-console --desktop_script=main_run.tcl &

echo ""
echo "NOTE: to interact with the JTAG UART component in System Console, please"
echo "launch the nios2-terminal utility after the board is initialized inside"
echo "System Console."
echo ""
