#!/bin/sh

SOPCINFO_FILE="../test_sys_top_qsys.sopcinfo"
SHELL_HEADER_OUTPUT_FILE="./headers/test_sys_top_qsys.sh"
TCL_HEADER_OUTPUT_FILE="./headers/test_sys_top_qsys.tcl"

#
# if headers directory does not exist, create it
#
[ -d "headers" ] || {
    mkdir headers
}

#
# make sure the sopcinfo file exists before we begin
#
[ -f "${SOPCINFO_FILE}" ] || {

    echo ""
    echo "ERROR: Could not locate sopcinfo input file."
    echo ""
    exit 1
}

#
# remove the expected output file before we begin
#
[ -f "${SHELL_HEADER_OUTPUT_FILE}" ] && {

    rm -f "${SHELL_HEADER_OUTPUT_FILE}"
}

#
# create the shell formatted header output
#
sopc-create-header-files ${SOPCINFO_FILE} --format sh --output-dir headers

#
# make sure the expected output file exists
#
[ -f "${SHELL_HEADER_OUTPUT_FILE}" ] || {

    echo ""
    echo "ERROR: Could not locate shell header output file."
    echo ""
    exit 1
}

#
# include the shell header file
#
. "${SHELL_HEADER_OUTPUT_FILE}"

#
# make sure that we collected all the macros that we expected
#
echo "
${MASTER_0_OCRAM_1K_BASE:?}
${MASTER_0_TEMP_SPI_BASE:?}
${MASTER_0_LED_PIO_OUT8_BASE:?}
${MASTER_0_PB_PIO_IN1_BASE:?}
${MASTER_0_SYSID_BASE:?}
${MASTER_0_SYSID_ID:?}
${MASTER_0_SYSID_TIMESTAMP:?}
${MASTER_0_JTAG_UART_BASE:?}
" >> /dev/null

cat << EOF > ${TCL_HEADER_OUTPUT_FILE}

namespace eval QSYS_HEADER {

    variable MASTER_0_OCRAM_1K_BASE ${MASTER_0_OCRAM_1K_BASE}
    variable MASTER_0_TEMP_SPI_BASE ${MASTER_0_TEMP_SPI_BASE}
    variable MASTER_0_LED_PIO_OUT8_BASE ${MASTER_0_LED_PIO_OUT8_BASE}
    variable MASTER_0_PB_PIO_IN1_BASE ${MASTER_0_PB_PIO_IN1_BASE}
    variable MASTER_0_SYSID_BASE ${MASTER_0_SYSID_BASE}
    variable MASTER_0_SYSID_ID ${MASTER_0_SYSID_ID}
    variable MASTER_0_SYSID_TIMESTAMP ${MASTER_0_SYSID_TIMESTAMP}
    variable MASTER_0_JTAG_UART_BASE ${MASTER_0_JTAG_UART_BASE}

}

EOF
