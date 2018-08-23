namespace eval jtagUart {

    variable initialized 0
    variable dash_path ""
    variable dashboardActive 0

    proc init {} {

        if { ![ namespace exists ::systemID ] } {
            return -code error "namespace systemID does not appear to exist"
        }

        if { ${::systemID::isValid} == 0 } {
            return -code ok "systemID is not validated"
        }

        set ::jtagUart::initialized 1

        return -code ok
    }

    proc dashBoard {} {

        if { ${::jtagUart::dashboardActive} == 1 } {
            return -code ok "dashboard already active"
        }

        set ::jtagUart::dashboardActive 1
        #
        # Create dashboard 
        #
        variable ::jtagUart::dash_path [ add_service dashboard jtagUart "jtagUart" "Tools/jtagUart"]

        #
        # Set dashboard properties
        #
        dashboard_set_property ${::jtagUart::dash_path} self developmentMode true
        dashboard_set_property ${::jtagUart::dash_path} self itemsPerRow 1
        dashboard_set_property ${::jtagUart::dash_path} self visible true
        
        #
        # top group widget
        #
        dashboard_add ${::jtagUart::dash_path} topGroup group self
        dashboard_set_property ${::jtagUart::dash_path} topGroup expandableX false
        dashboard_set_property ${::jtagUart::dash_path} topGroup expandableY false
        dashboard_set_property ${::jtagUart::dash_path} topGroup itemsPerRow 1
        dashboard_set_property ${::jtagUart::dash_path} topGroup title ""

        #
        # sendText widgets
        #
        dashboard_add ${::jtagUart::dash_path} sendTextGroup group topGroup 
        dashboard_set_property ${::jtagUart::dash_path} sendTextGroup expandableX false
        dashboard_set_property ${::jtagUart::dash_path} sendTextGroup expandableY false
        dashboard_set_property ${::jtagUart::dash_path} sendTextGroup itemsPerRow 1
        dashboard_set_property ${::jtagUart::dash_path} sendTextGroup title "Send Data"

        dashboard_add ${::jtagUart::dash_path} sendTextText text sendTextGroup 
        dashboard_set_property ${::jtagUart::dash_path} sendTextText expandableX false
        dashboard_set_property ${::jtagUart::dash_path} sendTextText expandableY false
        dashboard_set_property ${::jtagUart::dash_path} sendTextText preferredWidth 200
        dashboard_set_property ${::jtagUart::dash_path} sendTextText preferredHeight 200
        dashboard_set_property ${::jtagUart::dash_path} sendTextText editable true
        dashboard_set_property ${::jtagUart::dash_path} sendTextText htmlCapable false
        dashboard_set_property ${::jtagUart::dash_path} sendTextText text ""

        dashboard_add ${::jtagUart::dash_path} sendTextButton button sendTextGroup 
        dashboard_set_property ${::jtagUart::dash_path} sendTextButton enabled false
        dashboard_set_property ${::jtagUart::dash_path} sendTextButton expandableY false
        dashboard_set_property ${::jtagUart::dash_path} sendTextButton expandableY false
        dashboard_set_property ${::jtagUart::dash_path} sendTextButton text "Send Now"
        dashboard_set_property ${::jtagUart::dash_path} sendTextButton onClick ::jtagUart::sendText

        #
        # receiveText widgets
        #
        dashboard_add ${::jtagUart::dash_path} receiveTextGroup group topGroup 
        dashboard_set_property ${::jtagUart::dash_path} receiveTextGroup expandableX false
        dashboard_set_property ${::jtagUart::dash_path} receiveTextGroup expandableY false
        dashboard_set_property ${::jtagUart::dash_path} receiveTextGroup itemsPerRow 1
        dashboard_set_property ${::jtagUart::dash_path} receiveTextGroup title "Receive Data"

        dashboard_add ${::jtagUart::dash_path} receiveTextText text receiveTextGroup 
        dashboard_set_property ${::jtagUart::dash_path} receiveTextText expandableX false
        dashboard_set_property ${::jtagUart::dash_path} receiveTextText expandableY false
        dashboard_set_property ${::jtagUart::dash_path} receiveTextText preferredWidth 200
        dashboard_set_property ${::jtagUart::dash_path} receiveTextText preferredHeight 200
        dashboard_set_property ${::jtagUart::dash_path} receiveTextText editable false
        dashboard_set_property ${::jtagUart::dash_path} receiveTextText htmlCapable false
        dashboard_set_property ${::jtagUart::dash_path} receiveTextText text ""

        after idle ::jtagUart::updateDashboard

        return -code ok
    }
    
    proc sendText {} {

        if { ${::jtagUart::initialized} > 0 } {

            set sendText [ dashboard_get_property ${::jtagUart::dash_path} sendTextText text ]
            binary scan ${sendText} H* hexData
            set hexDataSplit [ split ${hexData} {} ]
            set hexList [ list ]
            foreach { a b } ${hexDataSplit} {
                lappend hexList [ format "0x%s%s" ${a} ${b} ]
            }
            foreach { nextChar } ${hexList} {
                set freeSpace [ expr [ master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_JTAG_UART_BASE} + 4 ] 1 ] >> 16 ]
                if { ${freeSpace} } {
                    master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_JTAG_UART_BASE} + 0 ] [ list ${nextChar} ]
                }
            }
        }
    }

    proc updateDashboard {} {

        ::jtagUart::init

        if { ${::jtagUart::dashboardActive} > 0 } {

            if { ${::jtagUart::initialized} > 0 } {

                dashboard_set_property ${::jtagUart::dash_path} sendTextButton enabled true

                set receiveData [ master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_JTAG_UART_BASE} + 0 ] 1 ]
                while { [ expr ${receiveData} & 0x00008000 ] } {
                    
                    set receiveData [ expr ${receiveData} & 0xFF ]
                    set hexString [ format "%02x" ${receiveData} ]
                    set textString [ binary format H* ${hexString} ]

                    set currentString [ dashboard_get_property ${::jtagUart::dash_path} receiveTextText text ]
                    append currentString ${textString}
                    if { [ string length ${currentString} ] > 500 } {
                        set currentString [ string range ${currentString} [ expr [ string length ${currentString} ] - 500 ] [ expr [ string length ${currentString} ] - 1 ] ]
                    }
                    dashboard_set_property ${::jtagUart::dash_path} receiveTextText text ${currentString}
                    
                    set receiveData [ master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_JTAG_UART_BASE} + 0 ] 1 ]
                }

                after 300 ::jtagUart::updateDashboard
            } else {
                after 1000 ::jtagUart::updateDashboard
            }
        }
    }
}
