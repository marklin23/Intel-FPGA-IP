namespace eval ledPIO {

    variable initialized 0
    variable ledValue 0
    variable dash_path ""
    variable dashboardActive 0

    proc init {} {

        if { ![ namespace exists ::systemID ] } {
            return -code error "namespace systemID does not appear to exist"
        }

        if { ${::systemID::isValid} == 0 } {
            return -code ok "systemID is not validated"
        }

        set ::ledPIO::ledValue [ expr [ master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_LED_PIO_OUT8_BASE} + 0 ] 1 ] & 0xFF ]
        
        set ::ledPIO::initialized 1

        return -code ok
    }

    proc toggle { position } {

        variable mask [ expr ( 0x01 << ${position} ) & 0xFF ]
        variable inverted_mask [ expr ( 0xFF ^ ${mask} ) & 0xFF ]
        variable temp 0

        if { ![ namespace exists ::systemID ] } {
            return -code error "namespace systemID does not appear to exist"
        }

        if { ${::systemID::isValid} == 0 } {
            return -code ok "systemID is not validated"
        }

        set temp [ expr [ master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_LED_PIO_OUT8_BASE} + 0 ] 1 ] & 0xFF ]
        
        if { [ expr ${temp} & ${mask} ] } {
            set temp [ expr ${temp} & ${inverted_mask} ]
        } else {
            set temp [ expr ${temp} | ${mask} ]
        }
        
        master_write_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_LED_PIO_OUT8_BASE} + 0 ] ${temp} 

        return -code ok
    }

    proc dashBoard {} {

        if { ${::ledPIO::dashboardActive} == 1 } {
            return -code ok "dashboard already active"
        }

        set ::ledPIO::dashboardActive 1
        #
        # Create dashboard 
        #
        variable ::ledPIO::dash_path [ add_service dashboard ledPIO "ledPIO" "Tools/ledPIO"]

        #
        # Set dashboard properties
        #
        dashboard_set_property ${::ledPIO::dash_path} self developmentMode true
        dashboard_set_property ${::ledPIO::dash_path} self itemsPerRow 1
        dashboard_set_property ${::ledPIO::dash_path} self visible true
        
        #
        # top group widget
        #
        dashboard_add ${::ledPIO::dash_path} topGroup group self
        dashboard_set_property ${::ledPIO::dash_path} topGroup expandableX false
        dashboard_set_property ${::ledPIO::dash_path} topGroup expandableY false
        dashboard_set_property ${::ledPIO::dash_path} topGroup itemsPerRow 1
        dashboard_set_property ${::ledPIO::dash_path} topGroup title ""

        #
        # leds group widget
        #
        dashboard_add ${::ledPIO::dash_path} ledsGroup group topGroup
        dashboard_set_property ${::ledPIO::dash_path} ledsGroup expandableX false
        dashboard_set_property ${::ledPIO::dash_path} ledsGroup expandableY false
        dashboard_set_property ${::ledPIO::dash_path} ledsGroup itemsPerRow 2
        dashboard_set_property ${::ledPIO::dash_path} ledsGroup title "LED State"

        #
        # leds widgets
        #
        dashboard_add ${::ledPIO::dash_path} led0Button button ledsGroup 
        dashboard_set_property ${::ledPIO::dash_path} led0Button enabled true
        dashboard_set_property ${::ledPIO::dash_path} led0Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led0Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led0Button text "Toggle"
        dashboard_set_property ${::ledPIO::dash_path} led0Button onClick {::ledPIO::toggle 0}

        dashboard_add ${::ledPIO::dash_path} led0LED led ledsGroup
        dashboard_set_property ${::ledPIO::dash_path} led0LED expandableX false
        dashboard_set_property ${::ledPIO::dash_path} led0LED expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led0LED text "LED 0"
        dashboard_set_property ${::ledPIO::dash_path} led0LED color "green_off"

        dashboard_add ${::ledPIO::dash_path} led1Button button ledsGroup 
        dashboard_set_property ${::ledPIO::dash_path} led1Button enabled true
        dashboard_set_property ${::ledPIO::dash_path} led1Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led1Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led1Button text "Toggle"
        dashboard_set_property ${::ledPIO::dash_path} led1Button onClick {::ledPIO::toggle 1}

        dashboard_add ${::ledPIO::dash_path} led1LED led ledsGroup
        dashboard_set_property ${::ledPIO::dash_path} led1LED expandableX false
        dashboard_set_property ${::ledPIO::dash_path} led1LED expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led1LED text "LED 1"
        dashboard_set_property ${::ledPIO::dash_path} led1LED color "green_off"

        dashboard_add ${::ledPIO::dash_path} led2Button button ledsGroup 
        dashboard_set_property ${::ledPIO::dash_path} led2Button enabled true
        dashboard_set_property ${::ledPIO::dash_path} led2Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led2Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led2Button text "Toggle"
        dashboard_set_property ${::ledPIO::dash_path} led2Button onClick {::ledPIO::toggle 2}

        dashboard_add ${::ledPIO::dash_path} led2LED led ledsGroup
        dashboard_set_property ${::ledPIO::dash_path} led2LED expandableX false
        dashboard_set_property ${::ledPIO::dash_path} led2LED expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led2LED text "LED 2"
        dashboard_set_property ${::ledPIO::dash_path} led2LED color "green_off"

        dashboard_add ${::ledPIO::dash_path} led3Button button ledsGroup 
        dashboard_set_property ${::ledPIO::dash_path} led3Button enabled true
        dashboard_set_property ${::ledPIO::dash_path} led3Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led3Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led3Button text "Toggle"
        dashboard_set_property ${::ledPIO::dash_path} led3Button onClick {::ledPIO::toggle 3}

        dashboard_add ${::ledPIO::dash_path} led3LED led ledsGroup
        dashboard_set_property ${::ledPIO::dash_path} led3LED expandableX false
        dashboard_set_property ${::ledPIO::dash_path} led3LED expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led3LED text "LED 3"
        dashboard_set_property ${::ledPIO::dash_path} led3LED color "green_off"

        dashboard_add ${::ledPIO::dash_path} led4Button button ledsGroup 
        dashboard_set_property ${::ledPIO::dash_path} led4Button enabled true
        dashboard_set_property ${::ledPIO::dash_path} led4Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led4Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led4Button text "Toggle"
        dashboard_set_property ${::ledPIO::dash_path} led4Button onClick {::ledPIO::toggle 4}

        dashboard_add ${::ledPIO::dash_path} led4LED led ledsGroup
        dashboard_set_property ${::ledPIO::dash_path} led4LED expandableX false
        dashboard_set_property ${::ledPIO::dash_path} led4LED expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led4LED text "LED 4"
        dashboard_set_property ${::ledPIO::dash_path} led4LED color "green_off"

        dashboard_add ${::ledPIO::dash_path} led5Button button ledsGroup 
        dashboard_set_property ${::ledPIO::dash_path} led5Button enabled true
        dashboard_set_property ${::ledPIO::dash_path} led5Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led5Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led5Button text "Toggle"
        dashboard_set_property ${::ledPIO::dash_path} led5Button onClick {::ledPIO::toggle 5}

        dashboard_add ${::ledPIO::dash_path} led5LED led ledsGroup
        dashboard_set_property ${::ledPIO::dash_path} led5LED expandableX false
        dashboard_set_property ${::ledPIO::dash_path} led5LED expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led5LED text "LED 5"
        dashboard_set_property ${::ledPIO::dash_path} led5LED color "green_off"

        dashboard_add ${::ledPIO::dash_path} led6Button button ledsGroup 
        dashboard_set_property ${::ledPIO::dash_path} led6Button enabled true
        dashboard_set_property ${::ledPIO::dash_path} led6Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led6Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led6Button text "Toggle"
        dashboard_set_property ${::ledPIO::dash_path} led6Button onClick {::ledPIO::toggle 6}

        dashboard_add ${::ledPIO::dash_path} led6LED led ledsGroup
        dashboard_set_property ${::ledPIO::dash_path} led6LED expandableX false
        dashboard_set_property ${::ledPIO::dash_path} led6LED expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led6LED text "LED 6"
        dashboard_set_property ${::ledPIO::dash_path} led6LED color "green_off"

        dashboard_add ${::ledPIO::dash_path} led7Button button ledsGroup 
        dashboard_set_property ${::ledPIO::dash_path} led7Button enabled true
        dashboard_set_property ${::ledPIO::dash_path} led7Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led7Button expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led7Button text "Toggle"
        dashboard_set_property ${::ledPIO::dash_path} led7Button onClick {::ledPIO::toggle 7}

        dashboard_add ${::ledPIO::dash_path} led7LED led ledsGroup
        dashboard_set_property ${::ledPIO::dash_path} led7LED expandableX false
        dashboard_set_property ${::ledPIO::dash_path} led7LED expandableY false
        dashboard_set_property ${::ledPIO::dash_path} led7LED text "LED 7"
        dashboard_set_property ${::ledPIO::dash_path} led7LED color "green_off"

        after idle ::ledPIO::updateDashboard

        return -code ok
    }
    
    proc updateDashboard {} {

        ::ledPIO::init

        if { ${::ledPIO::dashboardActive} > 0 } {

            if { ${::ledPIO::initialized} > 0 } {
                dashboard_set_property ${::ledPIO::dash_path} ledsGroup title "LED State"
                if { [ expr ${::ledPIO::ledValue} & 0x01 ] } {
                    dashboard_set_property ${::ledPIO::dash_path} led0LED color "green_off"
                } else {
                    dashboard_set_property ${::ledPIO::dash_path} led0LED color "green"
                }
                if { [ expr ${::ledPIO::ledValue} & 0x02 ] } {
                    dashboard_set_property ${::ledPIO::dash_path} led1LED color "green_off"
                } else {
                    dashboard_set_property ${::ledPIO::dash_path} led1LED color "green"
                }
                if { [ expr ${::ledPIO::ledValue} & 0x04 ] } {
                    dashboard_set_property ${::ledPIO::dash_path} led2LED color "green_off"
                } else {
                    dashboard_set_property ${::ledPIO::dash_path} led2LED color "green"
                }
                if { [ expr ${::ledPIO::ledValue} & 0x08 ] } {
                    dashboard_set_property ${::ledPIO::dash_path} led3LED color "green_off"
                } else {
                    dashboard_set_property ${::ledPIO::dash_path} led3LED color "green"
                }
                if { [ expr ${::ledPIO::ledValue} & 0x10 ] } {
                    dashboard_set_property ${::ledPIO::dash_path} led4LED color "green_off"
                } else {
                    dashboard_set_property ${::ledPIO::dash_path} led4LED color "green"
                }
                if { [ expr ${::ledPIO::ledValue} & 0x20 ] } {
                    dashboard_set_property ${::ledPIO::dash_path} led5LED color "green_off"
                } else {
                    dashboard_set_property ${::ledPIO::dash_path} led5LED color "green"
                }
                if { [ expr ${::ledPIO::ledValue} & 0x40 ] } {
                    dashboard_set_property ${::ledPIO::dash_path} led6LED color "green_off"
                } else {
                    dashboard_set_property ${::ledPIO::dash_path} led6LED color "green"
                }
                if { [ expr ${::ledPIO::ledValue} & 0x80 ] } {
                    dashboard_set_property ${::ledPIO::dash_path} led7LED color "green_off"
                } else {
                    dashboard_set_property ${::ledPIO::dash_path} led7LED color "green"
                }
                after 300 ::ledPIO::updateDashboard
            } else {
                dashboard_set_property ${::ledPIO::dash_path} ledsGroup title "Uninitialized"
                after 1000 ::ledPIO::updateDashboard
            }
        }
    }
}
