# This file was automatically generated by the swinfo2header utility.
# 
# Created from SOPC Builder system 'test_sys_top_qsys' in
# file '../test_sys_top_qsys.sopcinfo'.

# This file contains macros for module 'master_0' and devices
# connected to the following master:
#   master
# 
# Do not include this header file and another header file created for a
# different module or master group at the same time.
# Doing so may result in duplicate macro names.
# Instead, use the system header file which has macros with unique names.

# Macros for device 'ocram_1k', class 'altera_avalon_onchip_memory2'
# The macros are prefixed with 'OCRAM_1K_'.
# The prefix is the slave descriptor.
OCRAM_1K_COMPONENT_TYPE=altera_avalon_onchip_memory2
OCRAM_1K_COMPONENT_NAME=ocram_1k
OCRAM_1K_BASE=0x0
OCRAM_1K_SPAN=1024
OCRAM_1K_END=0x3ff
OCRAM_1K_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR=0
OCRAM_1K_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE=0
OCRAM_1K_CONTENTS_INFO=""
OCRAM_1K_DUAL_PORT=0
OCRAM_1K_GUI_RAM_BLOCK_TYPE=AUTO
OCRAM_1K_INIT_CONTENTS_FILE=test_sys_top_qsys_ocram_1k
OCRAM_1K_INIT_MEM_CONTENT=1
OCRAM_1K_INSTANCE_ID=NONE
OCRAM_1K_NON_DEFAULT_INIT_FILE_ENABLED=0
OCRAM_1K_RAM_BLOCK_TYPE=AUTO
OCRAM_1K_READ_DURING_WRITE_MODE=DONT_CARE
OCRAM_1K_SINGLE_CLOCK_OP=0
OCRAM_1K_SIZE_MULTIPLE=1
OCRAM_1K_SIZE_VALUE=1024
OCRAM_1K_WRITABLE=1
OCRAM_1K_MEMORY_INFO_DAT_SYM_INSTALL_DIR=SIM_DIR
OCRAM_1K_MEMORY_INFO_GENERATE_DAT_SYM=1
OCRAM_1K_MEMORY_INFO_GENERATE_HEX=1
OCRAM_1K_MEMORY_INFO_HAS_BYTE_LANE=0
OCRAM_1K_MEMORY_INFO_HEX_INSTALL_DIR=QPF_DIR
OCRAM_1K_MEMORY_INFO_MEM_INIT_DATA_WIDTH=32
OCRAM_1K_MEMORY_INFO_MEM_INIT_FILENAME=test_sys_top_qsys_ocram_1k

# Macros for device 'temp_spi', class 'altera_avalon_spi'
# The macros are prefixed with 'TEMP_SPI_'.
# The prefix is the slave descriptor.
TEMP_SPI_COMPONENT_TYPE=altera_avalon_spi
TEMP_SPI_COMPONENT_NAME=temp_spi
TEMP_SPI_BASE=0x400
TEMP_SPI_SPAN=32
TEMP_SPI_END=0x41f
TEMP_SPI_CLOCKMULT=1
TEMP_SPI_CLOCKPHASE=0
TEMP_SPI_CLOCKPOLARITY=0
TEMP_SPI_CLOCKUNITS="Hz"
TEMP_SPI_DATABITS=16
TEMP_SPI_DATAWIDTH=16
TEMP_SPI_DELAYMULT="1.0E-9"
TEMP_SPI_DELAYUNITS="ns"
TEMP_SPI_EXTRADELAY=0
TEMP_SPI_INSERT_SYNC=0
TEMP_SPI_ISMASTER=1
TEMP_SPI_LSBFIRST=0
TEMP_SPI_NUMSLAVES=1
TEMP_SPI_PREFIX="spi_"
TEMP_SPI_SYNC_REG_DEPTH=2
TEMP_SPI_TARGETCLOCK=50000
TEMP_SPI_TARGETSSDELAY="0.0"

# Macros for device 'led_pio_out8', class 'altera_avalon_pio'
# The macros are prefixed with 'LED_PIO_OUT8_'.
# The prefix is the slave descriptor.
LED_PIO_OUT8_COMPONENT_TYPE=altera_avalon_pio
LED_PIO_OUT8_COMPONENT_NAME=led_pio_out8
LED_PIO_OUT8_BASE=0x420
LED_PIO_OUT8_SPAN=16
LED_PIO_OUT8_END=0x42f
LED_PIO_OUT8_BIT_CLEARING_EDGE_REGISTER=0
LED_PIO_OUT8_BIT_MODIFYING_OUTPUT_REGISTER=0
LED_PIO_OUT8_CAPTURE=0
LED_PIO_OUT8_DATA_WIDTH=8
LED_PIO_OUT8_DO_TEST_BENCH_WIRING=0
LED_PIO_OUT8_DRIVEN_SIM_VALUE=0
LED_PIO_OUT8_EDGE_TYPE=NONE
LED_PIO_OUT8_FREQ=50000000
LED_PIO_OUT8_HAS_IN=1
LED_PIO_OUT8_HAS_OUT=1
LED_PIO_OUT8_HAS_TRI=0
LED_PIO_OUT8_IRQ_TYPE=NONE
LED_PIO_OUT8_RESET_VALUE=255

# Macros for device 'pb_pio_in1', class 'altera_avalon_pio'
# The macros are prefixed with 'PB_PIO_IN1_'.
# The prefix is the slave descriptor.
PB_PIO_IN1_COMPONENT_TYPE=altera_avalon_pio
PB_PIO_IN1_COMPONENT_NAME=pb_pio_in1
PB_PIO_IN1_BASE=0x430
PB_PIO_IN1_SPAN=16
PB_PIO_IN1_END=0x43f
PB_PIO_IN1_BIT_CLEARING_EDGE_REGISTER=0
PB_PIO_IN1_BIT_MODIFYING_OUTPUT_REGISTER=0
PB_PIO_IN1_CAPTURE=1
PB_PIO_IN1_DATA_WIDTH=1
PB_PIO_IN1_DO_TEST_BENCH_WIRING=0
PB_PIO_IN1_DRIVEN_SIM_VALUE=0
PB_PIO_IN1_EDGE_TYPE=FALLING
PB_PIO_IN1_FREQ=50000000
PB_PIO_IN1_HAS_IN=1
PB_PIO_IN1_HAS_OUT=0
PB_PIO_IN1_HAS_TRI=0
PB_PIO_IN1_IRQ_TYPE=LEVEL
PB_PIO_IN1_RESET_VALUE=0

# Macros for device 'sysid', class 'altera_avalon_sysid_qsys'
# The macros are prefixed with 'SYSID_'.
# The prefix is the slave descriptor.
SYSID_COMPONENT_TYPE=altera_avalon_sysid_qsys
SYSID_COMPONENT_NAME=sysid
SYSID_BASE=0x440
SYSID_SPAN=8
SYSID_END=0x447
SYSID_ID=4207856382
SYSID_TIMESTAMP=1476823578

# Macros for device 'jtag_uart', class 'altera_avalon_jtag_uart'
# The macros are prefixed with 'JTAG_UART_'.
# The prefix is the slave descriptor.
JTAG_UART_COMPONENT_TYPE=altera_avalon_jtag_uart
JTAG_UART_COMPONENT_NAME=jtag_uart
JTAG_UART_BASE=0x448
JTAG_UART_SPAN=8
JTAG_UART_END=0x44f
JTAG_UART_READ_DEPTH=64
JTAG_UART_READ_THRESHOLD=8
JTAG_UART_WRITE_DEPTH=64
JTAG_UART_WRITE_THRESHOLD=8


return 0
