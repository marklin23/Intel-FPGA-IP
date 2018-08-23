./start_everything.sh - this script will run build_tcl_header.sh and then it will launch system console and execute the main_run.tcl script within the console.

./build_tcl_header.sh - this script builds the Qsys header required by the rest of the TCL scripts.

./main_load.tcl - this script is used to load all of the dashboard modules into the console.

./main_run.tcl - this script wraps the main_load.tcl script such that after it loads the environment into the console it runs the initialization and validation procedures to get things going.

./boardInit.tcl - this module is responsible for loading hte device and setting up the console environment for all the rest of the modules.

./systemID.tcl - this module validates the system ID peripheral in the Qsys system to ensure that we're communicating with the proper system in the FPGA.

./byteStream.tcl - this module provides a dashboard that interacts with the bytestream component in the Qsys system.

./jtagUart.tcl - this module provides a dashboard that interacts with the jtaguart component in the Qsys system.

./ledPIO.tcl - this module provides a dashboard that interacts with the LED PIO component in the Qsys system.

./ocRAM.tcl - this module provides a dashboard that interacts with the onchip RAM component in the Qsys system.

./pbPIO.tcl- this module provides a dashboard that interacts with the push button PIO component in the Qsys system.

./thermSPI.tcl - this module provides a dashboard that interacts with the thermometer SPI component in the Qsys system.

./cycle.tcl - this is a simple script that illustrates how a collection of commands can be sourced into the console.

./cycle_proc.tcl - this is a simple script that shows how the commands from cycle.tcl can be wrapped as a TCL proc so that when it's sourced it persists in the TCL environment.
