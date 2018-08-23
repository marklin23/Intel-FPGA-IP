#Sysytem Console APIs
#   https://www.altera.com/en_US/pdfs/literature/ug/ug_system_console.pdf


#=============================================================================================================================================================================
# Dashboard Commands
#=============================================================================================================================================================================
#     Command              |                 Arguments                |                  Example                     |                     Description
#=============================================================================================================================================================================
# dashboard_add            | <service-path> <id> <type> <group id>    |dashboard_add $dash $name $widget_type $parent|   Adds a specified widget to your GUI dashboard.
# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# dashboard_remove         | <service-path> <id>                      |                                              |   Removes a specified widget from your GUI dashboard.
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# dashboard_set_property   | <service-path> <property> <id> <value>   |dashboard_set_property $dash self visible true|   Sets the specified properties of the specified widget that
#                          |                                          |                                              |   has been added to your GUI dashboard. 
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# dashboard_get_property   | <service-path> <id> <type>               |                                              |   Determinesthe existing properties of a widget added to your GUI dashboard.
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# dashboard_get_types      | —                                        |                                              |   Returns a list of all possible widgets that you can add to your GUI dashboard.
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# dashboard_get_properties | <widget type>                            |                                              |   
#================================================================================================================================================================================


#=================================================================
# Adding the Service
#=================================================================
set dash [add_service dashboard dashboard_example1 "Dashboard Example" "Tools/Example"]


#Showing the Dashboard Use the dashboard_set_property command to modify the visible property of the root dashboard
dashboard_set_property $dash self visible true






#=================================================================
# Adding Widgets Use the dashboard_add command to add widgets:
#=================================================================
set widget_type "label"
set parent "self"
dashboard_add $dash $name $widget_type $parent

#The following commands add a label widget named "my_label" to the root dashboard. In the GUI, it appears as the text "label." Change the text:
set content "Text to display goes here"
dashboard_set_property $dash $name text $content

#This command sets the text property to that string. In the GUI, the displayed text changes to the new value. Add one more label:
dashboard_add $dash my_label_2 label self
dashboard_set_property $dash my_label_2 text "Another label"


dashboard_set_property $dash self itemsPerRow 1




#=================================================================
# Adding Widgets Use the dashboard_add command to add widgets:
#=================================================================

#init jtag master
set my_service_path [ lindex [ get_service_paths master ] 0 ]
open_service master $my_service_path




# create dash board
set dash [add_service dashboard dashboard_example1 "Dashboard dial Example" "Tools/Example"]
dashboard_set_property $dash self visible true
set widget_type "dial"
set parent "self"
set name   "dial0"
dashboard_add $dash $name $widget_type $parent
dashboard_set_property $dash $name expandableX ture
dashboard_set_property $dash $name expandableY ture
dashboard_set_property $dash $name minHeight 100
dashboard_set_property $dash $name max 0xff
dashboard_set_property $dash $name tickSize [expr 0xff/8]
dashboard_set_property $dash $name title "Counter Mark "
dashboard_set_property $dash $name value 0

proc update_dial {  } {
   global dash
   global my_service_path
   global name
   #0x20: control bit0 hold, bit1 reset, bit2 start counter
   #0x10: read counter  pio_in[31:0] = { 8'b0, rvCounter1, rvCounter2, rvCounter3 };
   
   set value [ master_read_8 $my_service_path 0x10 1]
   
   #for { set i 0 } { ${i} < 100000 } { incr i } {
   #         set value i
   #     }
        
        
   #master_read_16 specific address from qsys
   #dashboard_set_property $dash $name value $value
   dashboard_set_property $dash $name value $value
   after 1 update_dial  
   #unit ms
}


proc stop_counter {  } {
   global dash
   global my_service_path
   global name
   
   master_write_32 $my_service_path 0x20 0x01

}

proc start_counter {  } {
   global dash
   global my_service_path
   global name
   
   master_write_32 $my_service_path 0x20 0x04

}

proc reset_counter {  } {
   global dash
   global my_service_path
   global name
   
   master_write_32 $my_service_path 0x20 0x02

}

proc update_timechart (){
   global dash
   global my_service_path
   global name
   set value [ master_read_16 $my_service_path 0x04 1]
   #master_read_16 specific address from qsys
   dashboard_set_property $dash $name latest $value
   after 300 update_timechart  
   #unit ms
}





