namespace eval byteStream {

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

        set ::byteStream::initialized 1

        return -code ok
    }

    proc dashBoard {} {

        if { ${::byteStream::dashboardActive} == 1 } {
            return -code ok "dashboard already active"
        }

        set ::byteStream::dashboardActive 1
        #
        # Create dashboard 
        #
        variable ::byteStream::dash_path [ add_service dashboard byteStream "byteStream" "Tools/byteStream"]

        #
        # Set dashboard properties
        #
        dashboard_set_property ${::byteStream::dash_path} self developmentMode true
        dashboard_set_property ${::byteStream::dash_path} self itemsPerRow 1
        dashboard_set_property ${::byteStream::dash_path} self visible true
        
        #
        # top group widget
        #
        dashboard_add ${::byteStream::dash_path} topGroup group self
        dashboard_set_property ${::byteStream::dash_path} topGroup expandableX false
        dashboard_set_property ${::byteStream::dash_path} topGroup expandableY false
        dashboard_set_property ${::byteStream::dash_path} topGroup itemsPerRow 1
        dashboard_set_property ${::byteStream::dash_path} topGroup title ""

        #
        # sendText widgets
        #
        dashboard_add ${::byteStream::dash_path} sendTextGroup group topGroup 
        dashboard_set_property ${::byteStream::dash_path} sendTextGroup expandableX false
        dashboard_set_property ${::byteStream::dash_path} sendTextGroup expandableY false
        dashboard_set_property ${::byteStream::dash_path} sendTextGroup itemsPerRow 1
        dashboard_set_property ${::byteStream::dash_path} sendTextGroup title "Send Data"

        dashboard_add ${::byteStream::dash_path} sendTextText text sendTextGroup 
        dashboard_set_property ${::byteStream::dash_path} sendTextText expandableX false
        dashboard_set_property ${::byteStream::dash_path} sendTextText expandableY false
        dashboard_set_property ${::byteStream::dash_path} sendTextText preferredWidth 200
        dashboard_set_property ${::byteStream::dash_path} sendTextText preferredHeight 200
        dashboard_set_property ${::byteStream::dash_path} sendTextText editable true
        dashboard_set_property ${::byteStream::dash_path} sendTextText htmlCapable false
        dashboard_set_property ${::byteStream::dash_path} sendTextText text ""

        dashboard_add ${::byteStream::dash_path} sendTextButton button sendTextGroup 
        dashboard_set_property ${::byteStream::dash_path} sendTextButton enabled false
        dashboard_set_property ${::byteStream::dash_path} sendTextButton expandableY false
        dashboard_set_property ${::byteStream::dash_path} sendTextButton expandableY false
        dashboard_set_property ${::byteStream::dash_path} sendTextButton text "Send Now"
        dashboard_set_property ${::byteStream::dash_path} sendTextButton onClick ::byteStream::sendText

        #
        # receiveText widgets
        #
        dashboard_add ${::byteStream::dash_path} receiveTextGroup group topGroup 
        dashboard_set_property ${::byteStream::dash_path} receiveTextGroup expandableX false
        dashboard_set_property ${::byteStream::dash_path} receiveTextGroup expandableY false
        dashboard_set_property ${::byteStream::dash_path} receiveTextGroup itemsPerRow 1
        dashboard_set_property ${::byteStream::dash_path} receiveTextGroup title "Receive Data"

        dashboard_add ${::byteStream::dash_path} receiveTextText text receiveTextGroup 
        dashboard_set_property ${::byteStream::dash_path} receiveTextText expandableX false
        dashboard_set_property ${::byteStream::dash_path} receiveTextText expandableY false
        dashboard_set_property ${::byteStream::dash_path} receiveTextText preferredWidth 200
        dashboard_set_property ${::byteStream::dash_path} receiveTextText preferredHeight 200
        dashboard_set_property ${::byteStream::dash_path} receiveTextText editable false
        dashboard_set_property ${::byteStream::dash_path} receiveTextText htmlCapable false
        dashboard_set_property ${::byteStream::dash_path} receiveTextText text ""

        after idle ::byteStream::updateDashboard

        return -code ok
    }
    
    proc sendText {} {

        if { ${::byteStream::initialized} > 0 } {

            set sendText [ dashboard_get_property ${::byteStream::dash_path} sendTextText text ]
            binary scan ${sendText} H* hexData
            set hexDataSplit [ split ${hexData} {} ]
            set hexList [ list ]
            foreach { a b } ${hexDataSplit} {
                lappend hexList [ format "0x%s%s" ${a} ${b} ]
            }
            bytestream_send $::boardInit::bytestreamPath ${hexList}
        }
    }

    proc updateDashboard {} {

        ::byteStream::init

        if { ${::byteStream::dashboardActive} > 0 } {

            if { ${::byteStream::initialized} > 0 } {

                dashboard_set_property ${::byteStream::dash_path} sendTextButton enabled true

                set receiveData [ bytestream_receive ${::boardInit::bytestreamPath} 64 ]
                if { [ llength ${receiveData} ] } {
                    
                    set hexString ""
                    foreach { a } ${receiveData} {
                        append hexString [ format "%02x" ${a} ]
                    }
                    set textString [ binary format H* ${hexString} ]

                    set currentString [ dashboard_get_property ${::byteStream::dash_path} receiveTextText text ]
                    append currentString ${textString}
                    if { [ string length ${currentString} ] > 500 } {
                        set currentString [ string range ${currentString} [ expr [ string length ${currentString} ] - 500 ] [ expr [ string length ${currentString} ] - 1 ] ]
                    }
                    dashboard_set_property ${::byteStream::dash_path} receiveTextText text ${currentString}
                }

                after 300 ::byteStream::updateDashboard
            } else {
                after 1000 ::byteStream::updateDashboard
            }
        }
    }
}
