namespace eval pbPIO {

    variable initialized 0
    variable pbValue 0
    variable dash_path ""
    variable dashboardActive 0

    proc init {} {

        if { ![ namespace exists ::systemID ] } {
            return -code error "namespace systemID does not appear to exist"
        }

        if { ${::systemID::isValid} == 0 } {
            return -code ok "systemID is not validated"
        }

        set ::pbPIO::pbValue [ expr [ master_read_32 ${::boardInit::masterPath} [ expr ${::QSYS_HEADER::MASTER_0_PB_PIO_IN1_BASE} + 0 ] 1 ] & 0x01 ]
        
        set ::pbPIO::initialized 1

        return -code ok
    }

    proc dashBoard {} {

        if { ${::pbPIO::dashboardActive} == 1 } {
            return -code ok "dashboard already active"
        }

        set ::pbPIO::dashboardActive 1
        #
        # Create dashboard 
        #
        variable ::pbPIO::dash_path [ add_service dashboard pbPIO "pbPIO" "Tools/pbPIO"]

        #
        # Set dashboard properties
        #
        dashboard_set_property ${::pbPIO::dash_path} self developmentMode true
        dashboard_set_property ${::pbPIO::dash_path} self itemsPerRow 1
        dashboard_set_property ${::pbPIO::dash_path} self visible true
        
        #
        # top group widget
        #
        dashboard_add ${::pbPIO::dash_path} topGroup group self
        dashboard_set_property ${::pbPIO::dash_path} topGroup expandableX false
        dashboard_set_property ${::pbPIO::dash_path} topGroup expandableY false
        dashboard_set_property ${::pbPIO::dash_path} topGroup itemsPerRow 1
        dashboard_set_property ${::pbPIO::dash_path} topGroup title ""

        #
        # state group widget
        #
        dashboard_add ${::pbPIO::dash_path} stateGroup group topGroup
        dashboard_set_property ${::pbPIO::dash_path} stateGroup expandableX false
        dashboard_set_property ${::pbPIO::dash_path} stateGroup expandableY false
        dashboard_set_property ${::pbPIO::dash_path} stateGroup preferredWidth 150
        dashboard_set_property ${::pbPIO::dash_path} stateGroup itemsPerRow 1
        dashboard_set_property ${::pbPIO::dash_path} stateGroup title "PB Input Current State"

        #
        # state widgets
        #
        dashboard_add ${::pbPIO::dash_path} stateLED led stateGroup
        dashboard_set_property ${::pbPIO::dash_path} stateLED expandableX false
        dashboard_set_property ${::pbPIO::dash_path} stateLED expandableY false
        dashboard_set_property ${::pbPIO::dash_path} stateLED text "State"
        dashboard_set_property ${::pbPIO::dash_path} stateLED color "green_off"

        #
        # history widgets
        #
        dashboard_add ${::pbPIO::dash_path} historyChart timeChart topGroup 
        dashboard_set_property ${::pbPIO::dash_path} historyChart expandableX true
        dashboard_set_property ${::pbPIO::dash_path} historyChart expandableY true
        dashboard_set_property ${::pbPIO::dash_path} historyChart labelX "Time"
        dashboard_set_property ${::pbPIO::dash_path} historyChart labelY "Value"
        dashboard_set_property ${::pbPIO::dash_path} historyChart maximumItemCount [ expr 3 * 120 ]
        dashboard_set_property ${::pbPIO::dash_path} historyChart title "PB Input History"
        dashboard_set_property ${::pbPIO::dash_path} historyChart latest 0

        after idle ::pbPIO::updateDashboard

        return -code ok
    }
    
    proc updateDashboard {} {

        ::pbPIO::init

        if { ${::pbPIO::dashboardActive} > 0 } {

            if { ${::pbPIO::initialized} > 0 } {
                dashboard_set_property ${::pbPIO::dash_path} stateLED text "State"
                if { ${::pbPIO::pbValue} == 0 } {
                    dashboard_set_property ${::pbPIO::dash_path} stateLED color "green"
                    dashboard_set_property ${::pbPIO::dash_path} historyChart latest 1
                } else {
                    dashboard_set_property ${::pbPIO::dash_path} stateLED color "green_off"
                    dashboard_set_property ${::pbPIO::dash_path} historyChart latest 0
                }
                after 300 ::pbPIO::updateDashboard
            } else {
                dashboard_set_property ${::pbPIO::dash_path} stateLED text "Uninitialized"
                dashboard_set_property ${::pbPIO::dash_path} stateLED color "green_off"
                after 1000 ::pbPIO::updateDashboard
            }
        }
    }
}
