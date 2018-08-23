`timescale 1ns/1ns
//========================================================
//tb_mac_led_decoder  tb_mac_led_decoder_inst(
//
//   .iRstn    () ,
//   .LED_CLK0 () ,
//   .LED_DATA0()    
//
//   
//);                                                  
//========================================================
module tb_mac_led_decoder(

   input      iRstn     ,
   output reg LED_CLK0  ,
   output reg LED_DATA0    

   
);


    parameter time_unit          = 1;
    parameter clk_time           = 40  * time_unit;   // 25MHz
    parameter clk_time_div2      = ( clk_time     / 2 );
    parameter led_clk_time       = 200 * time_unit;   // 5MHz
    parameter led_clk_time_div2  = ( led_clk_time / 2 );
    parameter wait_time          = clk_time * 1000;
    parameter wait_long_time     = clk_time * 10000;

    initial
    begin
      wait(iRstn ==1)
                           LED_CLK0      = 1'b0;
                           LED_DATA0     = 1'b0;
      
                           LED_WDATA_64B(16'b00_00_00_00_00_00_00_00); //
      # wait_time                                                
                           LED_WDATA_64B(16'b00_01_00_00_10_10_10_10); //
      # wait_time                                                
                           LED_WDATA_64B(16'b00_11_11_11_11_11_11_11); //1g
      # wait_time                                                
                           LED_WDATA_64B(16'b00_00_00_01_01_01_01_01); //10g  speed 00
      # wait_time                                                
                           LED_WDATA_64B(16'b00_10_10_01_01_01_01_01); //25g  speed 10
      # wait_time                                                
                           LED_WDATA_64B(16'b10_00_00_01_01_01_01_01); //40g  speed 00
      # wait_time                                                
                           LED_WDATA_64B(16'b10_10_10_01_01_01_01_01); //100g speed 10
      # wait_time                                                
                           LED_WDATA_64B(16'b00_00_00_00_00_00_00_00); //off
 
    
    end
    
 task LED_PORT_DATA_16b;
    input [15: 0] port_data_0;
    begin
    
    
                           LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[15];
      # led_clk_time_div2  LED_CLK0  = 1'b1;
      
      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[14];
      # led_clk_time_div2  LED_CLK0  = 1'b1;
      
      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[13];
      # led_clk_time_div2  LED_CLK0  = 1'b1;      

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[12];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[11];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[10];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[9];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[8];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[7];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[6];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[5];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[4];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[3];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[2];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[1];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 
                           LED_DATA0 = port_data_0[0];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

    end
    endtask
    
    
    task LED_PORT_DATA;
    input [13: 0] port_data_0;
    begin
                           LED_CLK0  = 1'b0;          //  bit 1
                           LED_DATA0 = port_data_0[13];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 2
                           LED_DATA0 = port_data_0[12];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 3
                           LED_DATA0 = port_data_0[11];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 4
                           LED_DATA0 = port_data_0[10];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 5
                           LED_DATA0 = port_data_0[9];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 6
                           LED_DATA0 = port_data_0[8];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 7
                           LED_DATA0 = port_data_0[7];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 8
                           LED_DATA0 = port_data_0[6];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 9
                           LED_DATA0 = port_data_0[5];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 10
                           LED_DATA0 = port_data_0[4];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 11
                           LED_DATA0 = port_data_0[3];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 12
                           LED_DATA0 = port_data_0[2];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 13
                           LED_DATA0 = port_data_0[1];
      # led_clk_time_div2  LED_CLK0  = 1'b1;

      # led_clk_time_div2  LED_CLK0  = 1'b0;          //  bit 14
                           LED_DATA0 = port_data_0[0];
      # led_clk_time_div2  LED_CLK0  = 1'b1;
    end
    endtask
   task LED_WDATA_64B;
   input [15: 0] port_data_16b;
   begin

      # led_clk_time_div2  LED_DATA0     = 1'b1;            // Start Bit
      # led_clk_time_div2  LED_DATA0     = 1'b0;
      # led_clk_time_div2  LED_PORT_DATA_16b( port_data_16b );  
      # led_clk_time_div2  LED_PORT_DATA_16b( port_data_16b );  
      # led_clk_time_div2  LED_PORT_DATA_16b( port_data_16b );  
      # led_clk_time_div2  LED_PORT_DATA_16b( port_data_16b );  
     
     
      # led_clk_time_div2  LED_CLK0      = 1'b0;   
                           LED_DATA0     = 1'b0;

      
   end   
   endtask 
   task LED_WDATA_168B;
   input [13: 0] port_data_14b;
   begin

      # led_clk_time_div2  LED_DATA0     = 1'b1;            // Start Bit
      # led_clk_time_div2  LED_DATA0     = 1'b0;
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );  // Port 1
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );  // Port 2
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );  
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );  
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );


      
      # led_clk_time_div2  LED_CLK0      = 1'b0;   
                           LED_DATA0     = 1'b0;

      
   end   
   endtask  

   task LED_WDATA_140B;
   input [13: 0] port_data_14b;
   begin

      # led_clk_time_div2  LED_DATA0     = 1'b1;            // Start Bit
      # led_clk_time_div2  LED_DATA0     = 1'b0;
      
      
      
      
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );  // Port 1
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );  // Port 2
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );  
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );  
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );
      # led_clk_time_div2  LED_PORT_DATA( port_data_14b );


      
      # led_clk_time_div2  LED_CLK0      = 1'b0;   
                           LED_DATA0     = 1'b0;

      
   end   
   endtask 
   
   
endmodule
