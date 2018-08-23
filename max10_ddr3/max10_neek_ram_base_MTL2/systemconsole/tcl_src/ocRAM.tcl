namespace eval ocRAM {

    variable initialized 0
    variable viewAddress "0x0000"
    variable viewList {}
    variable writeAddress 0
    variable writeData 0
    variable dash_path ""
    variable dashboardActive 0

    proc init {} {

        if { ![ namespace exists ::systemID ] } {
            return -code error "namespace systemID does not appear to exist"
        }

        if { ${::systemID::isValid} == 0 } {
            return -code ok "systemID is not validated"
        }

        set ::ocRAM::viewList [ master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_OCRAM_1K_BASE} + ${::ocRAM::viewAddress} ] 16 ]

        set ::ocRAM::initialized 1

        return -code ok
    }

    proc dashBoard {} {

        if { ${::ocRAM::dashboardActive} == 1 } {
            return -code ok "dashboard already active"
        }

        set ::ocRAM::dashboardActive 1
        #
        # Create dashboard 
        #
        variable ::ocRAM::dash_path [ add_service dashboard ocRAM "ocRAM" "Tools/ocRAM"]

        #
        # Set dashboard properties
        #
        dashboard_set_property ${::ocRAM::dash_path} self developmentMode true
        dashboard_set_property ${::ocRAM::dash_path} self itemsPerRow 1
        dashboard_set_property ${::ocRAM::dash_path} self visible true
        
        #
        # top group widget
        #
        dashboard_add ${::ocRAM::dash_path} topGroup group self
        dashboard_set_property ${::ocRAM::dash_path} topGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} topGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} topGroup itemsPerRow 1
        dashboard_set_property ${::ocRAM::dash_path} topGroup title ""

        #
        # view memory group widget
        #
        dashboard_add ${::ocRAM::dash_path} viewMemoryGroup group topGroup
        dashboard_set_property ${::ocRAM::dash_path} viewMemoryGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} viewMemoryGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} viewMemoryGroup itemsPerRow 1
        dashboard_set_property ${::ocRAM::dash_path} viewMemoryGroup title "View Memory"

        #
        # viewAddress widgets
        #
        dashboard_add ${::ocRAM::dash_path} viewAddressGroup group viewMemoryGroup 
        dashboard_set_property ${::ocRAM::dash_path} viewAddressGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} viewAddressGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} viewAddressGroup itemsPerRow 2
        dashboard_set_property ${::ocRAM::dash_path} viewAddressGroup title "Address"

        dashboard_add ${::ocRAM::dash_path} viewAddressText text viewAddressGroup 
        dashboard_set_property ${::ocRAM::dash_path} viewAddressText expandableX false
        dashboard_set_property ${::ocRAM::dash_path} viewAddressText expandableY false
        dashboard_set_property ${::ocRAM::dash_path} viewAddressText preferredWidth 100
        dashboard_set_property ${::ocRAM::dash_path} viewAddressText editable true
        dashboard_set_property ${::ocRAM::dash_path} viewAddressText htmlCapable false
        dashboard_set_property ${::ocRAM::dash_path} viewAddressText text ${::ocRAM::viewAddress}

        dashboard_add ${::ocRAM::dash_path} viewAddressButton button viewAddressGroup 
        dashboard_set_property ${::ocRAM::dash_path} viewAddressButton enabled true
        dashboard_set_property ${::ocRAM::dash_path} viewAddressButton expandableY false
        dashboard_set_property ${::ocRAM::dash_path} viewAddressButton expandableY false
        dashboard_set_property ${::ocRAM::dash_path} viewAddressButton text "Apply New Address"
        dashboard_set_property ${::ocRAM::dash_path} viewAddressButton onClick ::ocRAM::changeViewAddress

        #
        # viewTable widgets
        #
        dashboard_add ${::ocRAM::dash_path} viewTableGroup group viewMemoryGroup 
        dashboard_set_property ${::ocRAM::dash_path} viewTableGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} viewTableGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} viewTableGroup itemsPerRow 2
        dashboard_set_property ${::ocRAM::dash_path} viewTableGroup title "Data"

        dashboard_add ${::ocRAM::dash_path} viewAddressTable table viewTableGroup 
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable expandableX false
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable expandableY false 
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable rowCount 4
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable columnCount 1
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable columnHorizontalAlignment "center"
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable showGrid true
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable showHorizontalLines true
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable showVerticalLines true
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable columnIndex 0
        dashboard_set_property ${::ocRAM::dash_path} viewAddressTable columnHeader "ADDR"
        for { set i 0 } { ${i} < 4 } { incr i } {
            dashboard_set_property ${::ocRAM::dash_path} viewAddressTable rowIndex ${i}
            dashboard_set_property ${::ocRAM::dash_path} viewAddressTable cellText "uninitialized"
        }

        dashboard_add ${::ocRAM::dash_path} viewDataTable table viewTableGroup 
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable expandableX false
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable expandableY false 
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable rowCount 4
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnCount 4
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnHorizontalAlignment "center"
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable showGrid true
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable showHorizontalLines true
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable showVerticalLines true
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnIndex 0
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnHeader {WORD 0}
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnIndex 1
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnHeader {WORD 1}
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnIndex 2
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnHeader {WORD 2}
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnIndex 3
        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnHeader {WORD 3}
        for { set i 0 } { ${i} < 4 } { incr i } {
            dashboard_set_property ${::ocRAM::dash_path} viewDataTable rowIndex ${i}
            for { set j 0 } { ${j} < 4 } { incr j } {
                dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnIndex ${j}
                dashboard_set_property ${::ocRAM::dash_path} viewDataTable cellText "uninitialized"
            }
        }

        #
        # alter memory group widget
        #
        dashboard_add ${::ocRAM::dash_path} alterMemoryGroup group topGroup
        dashboard_set_property ${::ocRAM::dash_path} alterMemoryGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} alterMemoryGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} alterMemoryGroup itemsPerRow 2
        dashboard_set_property ${::ocRAM::dash_path} alterMemoryGroup title ""

        #
        # change memory group widget
        #
        dashboard_add ${::ocRAM::dash_path} changeMemoryGroup group alterMemoryGroup 
        dashboard_set_property ${::ocRAM::dash_path} changeMemoryGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} changeMemoryGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} changeMemoryGroup itemsPerRow 1
        dashboard_set_property ${::ocRAM::dash_path} changeMemoryGroup title "Change Memory"

        #
        # changeAddress widgets
        #
        dashboard_add ${::ocRAM::dash_path} changeAddressGroup group changeMemoryGroup
        dashboard_set_property ${::ocRAM::dash_path} changeAddressGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} changeAddressGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} changeAddressGroup itemsPerRow 1
        dashboard_set_property ${::ocRAM::dash_path} changeAddressGroup title "Address"

        dashboard_add ${::ocRAM::dash_path} changeAddressText text changeAddressGroup 
        dashboard_set_property ${::ocRAM::dash_path} changeAddressText expandableX false
        dashboard_set_property ${::ocRAM::dash_path} changeAddressText expandableY false
        dashboard_set_property ${::ocRAM::dash_path} changeAddressText preferredWidth 100
        dashboard_set_property ${::ocRAM::dash_path} changeAddressText editable true
        dashboard_set_property ${::ocRAM::dash_path} changeAddressText htmlCapable false
        dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "0x0000"

        #
        # changeData widgets
        #
        dashboard_add ${::ocRAM::dash_path} changeDataGroup group changeMemoryGroup
        dashboard_set_property ${::ocRAM::dash_path} changeDataGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} changeDataGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} changeDataGroup itemsPerRow 1
        dashboard_set_property ${::ocRAM::dash_path} changeDataGroup title "Data"

        dashboard_add ${::ocRAM::dash_path} changeDataText text changeDataGroup 
        dashboard_set_property ${::ocRAM::dash_path} changeDataText expandableX false
        dashboard_set_property ${::ocRAM::dash_path} changeDataText expandableY false
        dashboard_set_property ${::ocRAM::dash_path} changeDataText preferredWidth 100
        dashboard_set_property ${::ocRAM::dash_path} changeDataText editable true
        dashboard_set_property ${::ocRAM::dash_path} changeDataText htmlCapable false
        dashboard_set_property ${::ocRAM::dash_path} changeDataText text "0x00000000"

        #
        # change button widgets
        #
        dashboard_add ${::ocRAM::dash_path} change8Button button changeMemoryGroup
        dashboard_set_property ${::ocRAM::dash_path} change8Button enabled true
        dashboard_set_property ${::ocRAM::dash_path} change8Button expandableY false
        dashboard_set_property ${::ocRAM::dash_path} change8Button expandableY false
        dashboard_set_property ${::ocRAM::dash_path} change8Button text "Write 8-bit Value"
        dashboard_set_property ${::ocRAM::dash_path} change8Button onClick ::ocRAM::change8

        dashboard_add ${::ocRAM::dash_path} change16Button button changeMemoryGroup
        dashboard_set_property ${::ocRAM::dash_path} change16Button enabled true
        dashboard_set_property ${::ocRAM::dash_path} change16Button expandableY false
        dashboard_set_property ${::ocRAM::dash_path} change16Button expandableY false
        dashboard_set_property ${::ocRAM::dash_path} change16Button text "Write 16-bit Value"
        dashboard_set_property ${::ocRAM::dash_path} change16Button onClick ::ocRAM::change16

        dashboard_add ${::ocRAM::dash_path} change32Button button changeMemoryGroup
        dashboard_set_property ${::ocRAM::dash_path} change32Button enabled true
        dashboard_set_property ${::ocRAM::dash_path} change32Button expandableY false
        dashboard_set_property ${::ocRAM::dash_path} change32Button expandableY false
        dashboard_set_property ${::ocRAM::dash_path} change32Button text "Write 32-bit Value"
        dashboard_set_property ${::ocRAM::dash_path} change32Button onClick ::ocRAM::change32

        #
        # fill memory group widget
        #
        dashboard_add ${::ocRAM::dash_path} fillMemoryGroup group alterMemoryGroup 
        dashboard_set_property ${::ocRAM::dash_path} fillMemoryGroup expandableX false
        dashboard_set_property ${::ocRAM::dash_path} fillMemoryGroup expandableY false
        dashboard_set_property ${::ocRAM::dash_path} fillMemoryGroup itemsPerRow 1
        dashboard_set_property ${::ocRAM::dash_path} fillMemoryGroup title "Fill Memory"

        #
        # fill button widgets
        #
        dashboard_add ${::ocRAM::dash_path} fillZeroButton button fillMemoryGroup
        dashboard_set_property ${::ocRAM::dash_path} fillZeroButton enabled true
        dashboard_set_property ${::ocRAM::dash_path} fillZeroButton expandableY false
        dashboard_set_property ${::ocRAM::dash_path} fillZeroButton expandableY false
        dashboard_set_property ${::ocRAM::dash_path} fillZeroButton text "Fill Zero"
        dashboard_set_property ${::ocRAM::dash_path} fillZeroButton onClick ::ocRAM::fillZero

        dashboard_add ${::ocRAM::dash_path} fillOneButton button fillMemoryGroup
        dashboard_set_property ${::ocRAM::dash_path} fillOneButton enabled true
        dashboard_set_property ${::ocRAM::dash_path} fillOneButton expandableY false
        dashboard_set_property ${::ocRAM::dash_path} fillOneButton expandableY false
        dashboard_set_property ${::ocRAM::dash_path} fillOneButton text "Fill One"
        dashboard_set_property ${::ocRAM::dash_path} fillOneButton onClick ::ocRAM::fillOne

        dashboard_add ${::ocRAM::dash_path} fillRandomButton button fillMemoryGroup
        dashboard_set_property ${::ocRAM::dash_path} fillRandomButton enabled true
        dashboard_set_property ${::ocRAM::dash_path} fillRandomButton expandableY false
        dashboard_set_property ${::ocRAM::dash_path} fillRandomButton expandableY false
        dashboard_set_property ${::ocRAM::dash_path} fillRandomButton text "Fill Random"
        dashboard_set_property ${::ocRAM::dash_path} fillRandomButton onClick ::ocRAM::fillRandom

        after idle ::ocRAM::updateDashboard

        return -code ok
    }

    proc change8 {} {

        if { ${::ocRAM::initialized} == 0 } {
            return -code ok "module not initialized yet"
        }

        variable changeAddress [ dashboard_get_property ${::ocRAM::dash_path} changeAddressText text ]
        variable changeData [ dashboard_get_property ${::ocRAM::dash_path} changeDataText text ]

        if { ![ string is integer ${changeData} ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeDataText text "invalid number"
            return -code ok
        }
        
        if { ${changeData} > 0xFF } {

            dashboard_set_property ${::ocRAM::dash_path} changeDataText text "greater than 0xFF"
            return -code ok
        }
        
        if { ![ string is integer ${changeAddress} ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "invalid number"
            return -code ok
        }
        
        if { ${changeAddress} > [ expr 1024 - 1 ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "address too big"
            return -code ok
        }

        if { ${changeAddress} < 0 } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "negative address"
            return -code ok
        }

        master_write_8 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_OCRAM_1K_BASE} + ${changeAddress} ] ${changeData}

        dashboard_set_property ${::ocRAM::dash_path} changeAddressText text [ format "0x%04x" ${changeAddress} ]
        dashboard_set_property ${::ocRAM::dash_path} changeDataText text [ format "0x%08x" ${changeData} ]
    }
    
    proc change16 {} {

        if { ${::ocRAM::initialized} == 0 } {
            return -code ok "module not initialized yet"
        }

        variable changeAddress [ dashboard_get_property ${::ocRAM::dash_path} changeAddressText text ]
        variable changeData [ dashboard_get_property ${::ocRAM::dash_path} changeDataText text ]

        if { ![ string is integer ${changeData} ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeDataText text "invalid number"
            return -code ok
        }
        
        if { ${changeData} > 0xFFFF } {

            dashboard_set_property ${::ocRAM::dash_path} changeDataText text "greater than 0xFFFF"
            return -code ok
        }
        
        if { ![ string is integer ${changeAddress} ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "invalid number"
            return -code ok
        }
        
        if { [ expr ${changeAddress} & 0x01 ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "not mod2 address"
            return -code ok
        }

        if { ${changeAddress} > [ expr 1024 - 2 ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "address too big"
            return -code ok
        }

        if { ${changeAddress} < 0 } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "negative address"
            return -code ok
        }

        master_write_16 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_OCRAM_1K_BASE} + ${changeAddress} ] ${changeData}

        dashboard_set_property ${::ocRAM::dash_path} changeAddressText text [ format "0x%04x" ${changeAddress} ]
        dashboard_set_property ${::ocRAM::dash_path} changeDataText text [ format "0x%08x" ${changeData} ]
    }
    
    proc change32 {} {

        if { ${::ocRAM::initialized} == 0 } {
            return -code ok "module not initialized yet"
        }

        variable changeAddress [ dashboard_get_property ${::ocRAM::dash_path} changeAddressText text ]
        variable changeData [ dashboard_get_property ${::ocRAM::dash_path} changeDataText text ]

        if { ![ string is integer ${changeData} ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeDataText text "invalid number"
            return -code ok
        }
        
        if { ![ string is integer ${changeAddress} ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "invalid number"
            return -code ok
        }
        
        if { [ expr ${changeAddress} & 0x03 ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "not mod4 address"
            return -code ok
        }

        if { ${changeAddress} > [ expr 1024 - 4 ] } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "address too big"
            return -code ok
        }

        if { ${changeAddress} < 0 } {

            dashboard_set_property ${::ocRAM::dash_path} changeAddressText text "negative address"
            return -code ok
        }

        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_OCRAM_1K_BASE} + ${changeAddress} ] ${changeData}

        dashboard_set_property ${::ocRAM::dash_path} changeAddressText text [ format "0x%04x" ${changeAddress} ]
        dashboard_set_property ${::ocRAM::dash_path} changeDataText text [ format "0x%08x" ${changeData} ]
    }
    
    proc fillZero {} {

        if { ${::ocRAM::initialized} == 0 } {
            return -code ok "module not initialized yet"
        }

        set fillList [ list ]
        for { set i 0 } { ${i} < [ expr 1024 / 4 ] } { incr i } {
            lappend fillList [ format "0x%08x" [ expr 0x0 ] ]
        }

        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_OCRAM_1K_BASE} + 0 ] ${fillList}
    }

    proc fillOne {} {

        if { ${::ocRAM::initialized} == 0 } {
            return -code ok "module not initialized yet"
        }

        set fillList [ list ]
        for { set i 0 } { ${i} < [ expr 1024 / 4 ] } { incr i } {
            lappend fillList [ format "0x%08x" [ expr 0xFFFFFFFF ] ]
        }

        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_OCRAM_1K_BASE} + 0 ] ${fillList}
    }

    proc fillRandom {} {

        if { ${::ocRAM::initialized} == 0 } {
            return -code ok "module not initialized yet"
        }

        set fillList [ list ]
        for { set i 0 } { ${i} < [ expr 1024 / 4 ] } { incr i } {
            lappend fillList [ format "0x%08x" [ expr int( 0xFFFFFFFF * rand() ) ] ]
        }

        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_OCRAM_1K_BASE} + 0 ] ${fillList}
    }

    proc changeViewAddress {} {

        variable newValue [ dashboard_get_property ${::ocRAM::dash_path} viewAddressText text ]

        if { [ string is integer ${newValue} ] } {
    
            set newValue [ expr ${newValue} & ( 1024 - 1 ) ]

            if { ${newValue} > [ expr 1024 - ( 16 * 4 ) ] } {
                set newValue [ expr 1024 - ( 16 * 4 ) ]
            }

            set newValue [ expr ${newValue} & ( 1024 - ( 16 * 1 )) ]

            dashboard_set_property ${::ocRAM::dash_path} viewAddressText text [ format "0x%04x" ${newValue} ]
            set ::ocRAM::viewAddress ${newValue}
        } else {
            dashboard_set_property ${::ocRAM::dash_path} viewAddressText text "invalid number"
        }
    }
    
    proc updateDashboard {} {

        ::ocRAM::init

        if { ${::ocRAM::dashboardActive} > 0 } {

            if { ${::ocRAM::initialized} > 0 } {

                set baseAddress ${::ocRAM::viewAddress}
                for { set i 0 } { ${i} < 4 } { incr i } {
                    dashboard_set_property ${::ocRAM::dash_path} viewAddressTable rowIndex ${i}
                    dashboard_set_property ${::ocRAM::dash_path} viewAddressTable cellText [ format "0x%04x" ${baseAddress} ]
                    set baseAddress [ expr ${baseAddress} + 16 ]
                }

                for { set i 0 } { ${i} < 4 } { incr i } {
                    dashboard_set_property ${::ocRAM::dash_path} viewDataTable rowIndex ${i}
                    for { set j 0 } { ${j} < 4 } { incr j } {
                        dashboard_set_property ${::ocRAM::dash_path} viewDataTable columnIndex ${j}
                        dashboard_set_property ${::ocRAM::dash_path} viewDataTable cellText [ format "0x%08x" [ lindex ${::ocRAM::viewList} [ expr ( ${i} * 4 ) + ${j} ] ] ]
                    }
                }

                after 300 ::ocRAM::updateDashboard
            } else {
                after 1000 ::ocRAM::updateDashboard
            }
        }
    }
}
