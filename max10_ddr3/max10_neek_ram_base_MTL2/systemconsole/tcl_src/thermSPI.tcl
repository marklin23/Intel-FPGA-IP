namespace eval thermSPI {

    variable initialized 0
    variable thermRaw 0
    variable dash_path ""
    variable dashboardActive 0

    proc init {} {

        if { ![ namespace exists ::systemID ] } {
            return -code error "namespace systemID does not appear to exist"
        }

        if { ${::systemID::isValid} == 0 } {
            return -code ok "systemID is not validated"
        }

        ::thermSPI::thermRead 
        
        set ::thermSPI::initialized 1

        return -code ok
    }

    proc thermRead { } {

        #
        # assert the chip select to the device
        #
        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 3 ) ] 0x400

        #
        # wait for the spi tx port to be available, realistically since we're going over jtag this is never an issue
        #
        # master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 2 ) ] 1

        #
        # write all f's to the device, this line is opendrain so it allows the thermometer to be read
        #
        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 1 ) ] 0xFFFF

        #
        # wait for the spi rx port to be available, realistically since we're going over jtag this is never an issue
        #
        # master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 2 ) ] 1

        #
        # read the spi data register, this is the thermal sample
        #
        set ::thermSPI::thermRaw [ master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 0 ) ] 1 ]

        #
        # write all 0's to the thermometer so that it continuously samples
        #
        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 1 ) ] 0x0000

        #
        # wait for the spi tx port to be available, realistically since we're going over jtag this is never an issue
        #
        # master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 2 ) ] 1

        #
        # read the returned read data and throw it away
        #
        master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 0 ) ] 1

        #
        # deassert the chip select to the device
        #
        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_TEMP_SPI_BASE} + ( 4 * 3 ) ] 0x000
    }

    proc dashBoard {} {

        if { ${::thermSPI::dashboardActive} == 1 } {
            return -code ok "dashboard already active"
        }

        set ::thermSPI::dashboardActive 1
        #
        # Create dashboard 
        #
        variable ::thermSPI::dash_path [ add_service dashboard thermSPI "thermSPI" "Tools/thermSPI"]

        #
        # Set dashboard properties
        #
        dashboard_set_property ${::thermSPI::dash_path} self developmentMode true
        dashboard_set_property ${::thermSPI::dash_path} self itemsPerRow 1
        dashboard_set_property ${::thermSPI::dash_path} self visible true
        
        #
        # top group widget
        #
        dashboard_add ${::thermSPI::dash_path} topGroup group self
        dashboard_set_property ${::thermSPI::dash_path} topGroup expandableX false
        dashboard_set_property ${::thermSPI::dash_path} topGroup expandableY false
        dashboard_set_property ${::thermSPI::dash_path} topGroup itemsPerRow 1
        dashboard_set_property ${::thermSPI::dash_path} topGroup title ""

        #
        # dial widget
        #
        dashboard_add ${::thermSPI::dash_path} thermDial dial topGroup 
        dashboard_set_property ${::thermSPI::dash_path} thermDial min 0
        dashboard_set_property ${::thermSPI::dash_path} thermDial max 200
        dashboard_set_property ${::thermSPI::dash_path} thermDial title "Fahrenheit"
        dashboard_set_property ${::thermSPI::dash_path} thermDial expandableX true
        dashboard_set_property ${::thermSPI::dash_path} thermDial expandableY true
        dashboard_set_property ${::thermSPI::dash_path} thermDial minHeight 200
        dashboard_set_property ${::thermSPI::dash_path} thermDial minWidth 200
        dashboard_set_property ${::thermSPI::dash_path} thermDial enabled true
        dashboard_set_property ${::thermSPI::dash_path} thermDial tickSize 10
        dashboard_set_property ${::thermSPI::dash_path} thermDial value 0

        #
        # history widgets
        #
        dashboard_add ${::thermSPI::dash_path} thermChart timeChart topGroup 
        dashboard_set_property ${::thermSPI::dash_path} thermChart expandableX true
        dashboard_set_property ${::thermSPI::dash_path} thermChart expandableY true
        dashboard_set_property ${::thermSPI::dash_path} thermChart labelX "Time"
        dashboard_set_property ${::thermSPI::dash_path} thermChart labelY "Raw"
        dashboard_set_property ${::thermSPI::dash_path} thermChart maximumItemCount [ expr 3 * 120 ]
        dashboard_set_property ${::thermSPI::dash_path} thermChart title "Raw Thermal History"
        dashboard_set_property ${::thermSPI::dash_path} thermChart latest 3750

        after idle ::thermSPI::updateDashboard

        return -code ok
    }
    
    proc updateDashboard {} {

        ::thermSPI::init

        if { ${::thermSPI::dashboardActive} > 0 } {

            if { ${::thermSPI::initialized} > 0 } {
                dashboard_set_property ${::thermSPI::dash_path} thermDial title "Fahrenheit"
                dashboard_set_property ${::thermSPI::dash_path} thermChart latest ${::thermSPI::thermRaw}
                dashboard_set_property ${::thermSPI::dash_path} thermDial value [ expr ((((${::thermSPI::thermRaw} / 4) * 0.03125) * 9) / 5) + 32 ]
                after 300 ::thermSPI::updateDashboard
            } else {
                dashboard_set_property ${::thermSPI::dash_path} thermDial title "Uninitialized"
                after 1000 ::thermSPI::updateDashboard
            }
        }
    }
}
