
`timescale 1 ns/ 1 ns
//========================================================
//i2c_master_tb  i2c_master_tb_inst(
//
// .iClk   ( rClk  ),
// .iRstn  ( rRstn ),
// .SCL    ( wSCL  ),
// .SDA    ( wSDA  )
//
//);                                                  
//========================================================
module i2c_master_tb(
input iClk,
input iRstn,
inout SDA,
output SCL

);
// constants                                           
// general purpose registers
reg rRstn;
reg [7:0]  rvReadData_MISO;
reg [7:0]  rvReadData_Status;
reg [7:0]  rvReadData_Control;
reg [31:0] rvAvalonReadData;
pullup(pull1) p00( SDA );  
pullup(pull1) p01( SCL );
parameter time_unit           = 1;					
parameter clk_time            = 10 * time_unit;   
parameter clk_time_div2       = 50 * time_unit;	
parameter clk_time_div10      = (clk_time / 100 );	
parameter wait_time           = clk_time * 1000; 	
parameter wait_little_time    = clk_time * 10; 	
parameter wait_long_time      = clk_time * 10000;	


//==============================================
// i2c address
//==============================================

`define IIC_SPI_UART_ADDR     7'h62
`define IIC_FPGA_ADDR         7'h64

`define UART_TOD_RX_OFFSET    8'h40
`define UART_TOD_TX_OFFSET    8'h44
`define UART_TOD_STATUS       8'h48
`define UART_TOD_CONTROL      8'h4C
`define UART_TOD_DIVISOR      8'h50
`define UART_TOD_ENDOFPACKET  8'h54

`define UART_GPS_RX_OFFSET    8'h20
`define UART_GPS_TX_OFFSET    8'h24
`define UART_GPS_STATUS       8'h28
`define UART_GPS_CONTROL      8'h2C
`define UART_GPS_DIVISOR      8'h30
`define UART_GPS_ENDOFPACKET  8'h34

`define ADDRESS_NONE          8'h00
//FIFO ADDRESS
`define UART_GPS_FIFO_IN      8'hA0
`define UART_GPS_FIFO_OUT     8'hA4
`define UART_GPS_FIFO_STATUS  8'h64
`define UART_ToD_FIFO_IN      8'hB0
`define UART_ToD_FIFO_OUT     8'hB4
`define UART_ToD_FIFO_STATUS  8'h84

//==============================================
// iic slave test
//==============================================
integer iic_addr;
integer iic_data;
reg [7:0]rvReadData;
reg [31:0]rvReadData32b;
integer p,m;
initial
begin
  release SDA; 
  release SCL;   
  rRstn = 1'b1;
  iic_data = 0;
  wait(iRstn ==1)

  
  
  # wait_time
      I2C_WRITE       ( {`IIC_FPGA_ADDR,1'b0}, 8'h86 , { 6'd60 ,2'b00} );
  # wait_time
      I2C_WRITE       ( {`IIC_FPGA_ADDR,1'b0}, 8'h86 , { 6'd60 ,2'b11} );
  
  

  for (m=0;m<20;m= m+1)
  begin
   # wait_time   
      I2C_WRITE       ( {`IIC_SPI_UART_ADDR,1'b0}, `UART_GPS_TX_OFFSET , m );  
   # wait_time
      rvReadData_Status = 8'b0;
      while (rvReadData_Status[6:5] !=2'b11) // check Transmit ready & Transmit empty.
   # wait_time   
      I2C_READ        ( {`IIC_SPI_UART_ADDR,1'b0}, `UART_GPS_STATUS    , {`IIC_SPI_UART_ADDR,1'b1}, rvReadData_Status );

  end
  
  
  # wait_time
      I2C_WRITE       ( {`IIC_FPGA_ADDR,1'b0}, 8'h86 , { 6'd5 ,2'b00} );
  # wait_time
      I2C_WRITE       ( {`IIC_FPGA_ADDR,1'b0}, 8'h86 , { 6'd5 ,2'b11} );
  
  
  for (m=0;m<20;m= m+1)
  begin  
   rvReadData_Status = 8'b0;
      while (rvReadData_Status[1] == 1'b1)
   # wait_time
      I2C_READ        ( {`IIC_SPI_UART_ADDR,1'b0}, `UART_ToD_FIFO_STATUS , {`IIC_SPI_UART_ADDR,1'b1}, rvReadData_Status );
      
   # wait_time
      I2C_READ        ( {`IIC_SPI_UART_ADDR,1'b0}, `UART_ToD_FIFO_OUT    , {`IIC_SPI_UART_ADDR,1'b1}, rvReadData_Status );
 
  end
 
 
 

  for (m=0;m<20;m= m+1)
  begin
   # wait_time
      I2C_WRITE       ( {`IIC_SPI_UART_ADDR,1'b0}, `UART_TOD_TX_OFFSET , m );       
      rvReadData_Status = 8'b0;
      while (rvReadData_Status[6:5] !=2'b11) // check Transmit ready & Transmit empty.
   # wait_time   
      I2C_READ        ( {`IIC_SPI_UART_ADDR,1'b0}, `UART_TOD_STATUS    , {`IIC_SPI_UART_ADDR,1'b1}, rvReadData_Status ); 
     
  end 

  
  

end

/*********************************************************************
SMBus task section
*********************************************************************/
integer i,j,k;

parameter i2c_frequency  = 2_500 * time_unit; // 400KHz
parameter i2c_cycle_div2 = (i2c_frequency/2); 
parameter i2c_cycle_div4 = (i2c_frequency/4); 

task I2C_START;
begin
  release SDA;
  release SCL;
  # i2c_cycle_div4 force SDA = 1'b0;
  # i2c_cycle_div4 force SCL = 1'b0;
end
endtask

task I2C_WAIT_ACK;
begin
    release SDA;
    # i2c_cycle_div4 release SCL;
    # i2c_cycle_div4 if (SDA) $display ("  !!!!!! Device Not ACK !!!!!!");
    # i2c_cycle_div4 force SCL = 0;
end
endtask

task I2C_HOST_ACK;
begin
    force SDA = 1'b0;
    # i2c_cycle_div4 release SCL;
    # i2c_cycle_div2 force SCL = 0;
end
endtask

task I2C_HOST_NACK;
begin
    force SDA = 1'b1;
    # i2c_cycle_div4 release SCL;
    # i2c_cycle_div2 force SCL = 0;
end
endtask

task I2C_STOP;
begin
  force SDA = 1'b0;
  # i2c_cycle_div4 release SCL;
  # i2c_cycle_div4 release SDA;
  # i2c_cycle_div4;
  $display ("       ");
end
endtask


task I2C_WRITE;
input [7:0] slave_addr; // 8'h46,
input [7:0] reg_addr;   // 8'h08, 
input [7:0] reg_data;   // 8'hA5,
begin
  I2C_START;

  for ( j=0; j<=2; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      if      ( j==0 ) if ( slave_addr[i] ) release SDA; else force SDA = 1'b0;
      else if ( j==1 ) if ( reg_addr[i]   ) release SDA; else force SDA = 1'b0;
      else if ( j==2 ) if ( reg_data[i]   ) release SDA; else force SDA = 1'b0;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div2 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_WAIT_ACK;
  end

  # i2c_cycle_div4;
  I2C_STOP;

  $display ( "-------------------- I2C_Write --------------------" );
  $display ( "  Slave_Address   Register_Address  Register_Data  " );
  $display ("       0x%h              0x%h            0x%h       ",
                 slave_addr,        reg_addr,       reg_data       );
end
endtask


task I2C_READ;
input [7:0] slave_addr_w;
input [7:0] reg_addr;
input [7:0] slave_addr_r;
output[7:0] read_data;
reg   [7:0] reg_data;
begin
  I2C_START;

  for ( j=0; j<=1; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      if      ( j==0 ) if ( slave_addr_w[i] ) release SDA; else force SDA = 1'b0;
      else if ( j==1 ) if ( reg_addr[i]     ) release SDA; else force SDA = 1'b0;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div2 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_WAIT_ACK;
  end

  # i2c_cycle_div4;
  I2C_START;
    
  for ( j=0; j<=0; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      if      ( j==0 ) if ( slave_addr_r[i] ) release SDA; else force SDA = 1'b0;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div2 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_WAIT_ACK;
  end

  for ( j=0; j<=0; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      release SDA;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div4;
      if      ( j==0 ) reg_data[i] = SDA;
      # i2c_cycle_div4 force SCL = 0;
      # i2c_cycle_div4;
    end
    //I2C_HOST_ACK;
    I2C_HOST_NACK;
  end
  read_data = reg_data;
  I2C_STOP;
  $display ( "------------------------------------ I2C_Read -------------------------------------" );
  $display ( "  Slave_Address  Register_Address  Slave_Address    Register_Data  "  );
  $display ( "       0x%h             0x%h            0x%h              0x%h     ",
                slave_addr_w,      reg_addr,      slave_addr_r,      reg_data       );
end
endtask



//*******************************************************************************************************
//PCA9555
//*******************************************************************************************************

task I2C_READ_2Byte;
input [7:0] slave_addr_w;
input [7:0] reg_addr;
input [7:0] slave_addr_r;
reg   [7:0] reg_data;
reg   [7:0] reg_data2;
begin
  I2C_START;

  for ( j=0; j<=1; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      if      ( j==0 ) if ( slave_addr_w[i] ) release SDA; else force SDA = 1'b0;
      else if ( j==1 ) if ( reg_addr[i]     ) release SDA; else force SDA = 1'b0;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div2 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_WAIT_ACK;
  end

  # i2c_cycle_div4;
  I2C_START;
    
  for ( j=0; j<=0; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      if      ( j==0 ) if ( slave_addr_r[i] ) release SDA; else force SDA = 1'b0;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div2 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_WAIT_ACK;
  end

  for ( j=0; j<=0; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      release SDA;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div4;
      if      ( j==0 ) reg_data[i] = SDA;
      # i2c_cycle_div4 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_HOST_ACK;
  end

  for ( j=0; j<=0; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      release SDA;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div4;
      if      ( j==0 ) reg_data2[i] = SDA;
      # i2c_cycle_div4 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_HOST_NACK;
  end
  
  
  I2C_STOP;
  $display ( "------------------------------------ I2C_Read -------------------------------------" );
  $display ( "  Slave_Address  Register_Address  Slave_Address    Register_Data  " );
  $display ("       0x%h             0x%h            0x%h              0x%h       ",
                slave_addr_w,      reg_addr,      slave_addr_r,      reg_data       );
end
endtask
//*******************************************************************************************************

//*******************************************************************************************************

task I2C_WRITE_2Byte;
input [7:0] slave_addr; //
input [7:0] reg_addr;   //
input [7:0] reg_data;   //
input [7:0] reg_data2;  //
begin
   I2C_START;
     for ( j=0; j<=3; j=j+1 )
     begin
       # i2c_cycle_div4
       for ( i=7; i>=0; i=i-1 )
       begin
         if      ( j==0 ) if ( slave_addr[i] ) release SDA; else force SDA = 1'b0;
         else if ( j==1 ) if ( reg_addr[i]   ) release SDA; else force SDA = 1'b0;
         else if ( j==2 ) if ( reg_data[i]   ) release SDA; else force SDA = 1'b0;
        else if  ( j==3 ) if ( reg_data2[i]  ) release SDA; else force SDA = 1'b0;
         # i2c_cycle_div4 release SCL;
         # i2c_cycle_div2 force SCL = 0;
         # i2c_cycle_div4;
       end
       I2C_WAIT_ACK;
     end

     # i2c_cycle_div4;
     I2C_STOP;

     $display ( "-------------------- I2C_Write --------------------" );
     $display ( "  Slave_Address   Register_Address  Register_Data  " );
     $display ("       0x%h              0x%h            0x%h       ",
                    slave_addr,        reg_addr,       reg_data       );
   end
   endtask
//*******************************************************************************************************
// non continue read command 
//*******************************************************************************************************

task I2C_Single_read;
   input [7:0] slave_addr_r;
   input [7:0] reg_addr;
   reg   [7:0] reg_data;
   reg   [7:0] slave_addr;
   begin
      slave_addr = {slave_addr_r[7:1],1'b0};
      I2C_START;
        //Wirte
        for ( j=0; j<=1; j=j+1 )
        begin
          # i2c_cycle_div4
          for ( i=7; i>=0; i=i-1 )
          begin
            if      ( j==0 ) if ( slave_addr[i] ) release SDA; else force SDA = 1'b0;
            else if ( j==1 ) if ( reg_addr[i]   ) release SDA; else force SDA = 1'b0;
            # i2c_cycle_div4 release SCL;
            # i2c_cycle_div2 force SCL = 0;
            # i2c_cycle_div4;
          end
          I2C_WAIT_ACK;
        end

        # i2c_cycle_div4;
      I2C_STOP;

        
        //Read
      I2C_START;

        for ( j=0; j<=0; j=j+1 )
        begin
          # i2c_cycle_div4
          for ( i=7; i>=0; i=i-1 )
          begin
            if      ( j==0 ) if ( slave_addr_r[i] ) release SDA; else force SDA = 1'b0;
            //else if ( j==1 ) if ( reg_addr[i]     ) release SDA; else force SDA = 1'b0;
            # i2c_cycle_div4 release SCL;
            # i2c_cycle_div2 force SCL = 0;
            # i2c_cycle_div4;
          end
          I2C_WAIT_ACK;
        end

        for ( j=0; j<=0; j=j+1 )
        begin
          # i2c_cycle_div4
          for ( i=7; i>=0; i=i-1 )
          begin
            release SDA;
            # i2c_cycle_div4 release SCL;
            # i2c_cycle_div4;
            if      ( j==0 ) reg_data[i] = SDA;
            # i2c_cycle_div4 force SCL = 0;
            # i2c_cycle_div4;
          end
          I2C_HOST_NACK;
        end

      I2C_STOP;
        $display ( "-----------------------------------I2C_Single_read-----------------------------------" );
        $display ( "  Slave_Address  Register_Address      Register_Data  " );
        $display ("       0x%h             0x%h                0x%h       ",
                      slave_addr_r,      reg_addr,           reg_data       );
   end
endtask   
//*******************************************************************************************************
// Avalon 32 bit i2c master  READ
//*******************************************************************************************************
task iic_avalon_r_32b;
input [7:0]  slave_addr_w;
input [31:0] reg_addr;
input [7:0]  slave_addr_r;
output[31:0] read_data;

reg [7:0] reg_addr1;  
reg [7:0] reg_addr2;  
reg [7:0] reg_addr3;  
reg [7:0] reg_addr4;  


reg   [7:0] reg_data1;
reg   [7:0] reg_data2;
reg   [7:0] reg_data3;
reg   [7:0] reg_data4;
begin

  reg_addr1 = reg_addr[ 31 : 24];
  reg_addr2 = reg_addr[ 23 : 16];
  reg_addr3 = reg_addr[ 15 : 08];
  reg_addr4 = reg_addr[ 07 : 00];
  
  I2C_START;

  for ( j=0; j<=4; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      if      ( j==0 ) if ( slave_addr_w[i] ) release SDA; else force SDA = 1'b0;
      else if ( j==1 ) if ( reg_addr1[i]    ) release SDA; else force SDA = 1'b0;
      else if ( j==2 ) if ( reg_addr2[i]    ) release SDA; else force SDA = 1'b0;
      else if ( j==3 ) if ( reg_addr3[i]    ) release SDA; else force SDA = 1'b0;
      else if ( j==4 ) if ( reg_addr4[i]    ) release SDA; else force SDA = 1'b0;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div2 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_WAIT_ACK;
  end

  # i2c_cycle_div4;
  
  I2C_START;
    
  for ( j=0; j<=0; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      if      ( j==0 ) if ( slave_addr_r[i] ) release SDA; else force SDA = 1'b0;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div2 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_WAIT_ACK;
  end

  for ( j=0; j<=2; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      release SDA;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div4;
      if      ( j==0 ) reg_data1[i] = SDA;
      else if ( j==1 ) reg_data2[i] = SDA;
      else if ( j==2 ) reg_data3[i] = SDA; 
      # i2c_cycle_div4 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_HOST_ACK;
  end

  for ( j=0; j<=0; j=j+1 )
  begin
    # i2c_cycle_div4
    for ( i=7; i>=0; i=i-1 )
    begin
      release SDA;
      # i2c_cycle_div4 release SCL;
      # i2c_cycle_div4;
      if      ( j==0 ) reg_data4[i] = SDA;
      # i2c_cycle_div4 force SCL = 0;
      # i2c_cycle_div4;
    end
    I2C_HOST_NACK;
  end
  
  
  I2C_STOP;
  read_data = {reg_data4[7:0],reg_data3[7:0],reg_data2[7:0],reg_data1[7:0]};
  $display ( "------------------------------------ I2C_Read -------------------------------------" );
  $display ( "  Slave_Address        Register_Address         Slave_Address         Register_Data  " );
  $display ("       0x%h           0x%h               0x%h              0x%h        ",
                slave_addr_w,     reg_addr,          slave_addr_r,      read_data       );
  
end
endtask

//*******************************************************************************************************
// Avalon 32 bit i2c master  WRITE
//*******************************************************************************************************  
task iic_avalon_w_32b;
input [7:0] slave_addr; //
input [31:0] reg_addr;
input [31:0] reg_data;

reg [7:0] reg_addr1;   //
reg [7:0] reg_addr2;   //
reg [7:0] reg_addr3;   //
reg [7:0] reg_addr4;   //
reg [7:0] reg_data1;   //
reg [7:0] reg_data2;  //
reg [7:0] reg_data3;   //
reg [7:0] reg_data4;  //
begin
   reg_addr1 = reg_addr[ 31 : 24];
   reg_addr2 = reg_addr[ 23 : 16];
   reg_addr3 = reg_addr[ 15 : 08];
   reg_addr4 = reg_addr[ 07 : 00];
   
   reg_data1 = reg_data[ 31 : 24];
   reg_data2 = reg_data[ 23 : 16];
   reg_data3 = reg_data[ 15 : 08];
   reg_data4 = reg_data[ 07 : 00];
   
   I2C_START;
     for ( j=0; j<=8; j=j+1 )
     begin
       # i2c_cycle_div4
       for ( i=7; i>=0; i=i-1 )
       begin
         if      ( j==0 ) if ( slave_addr[i] ) release SDA; else force SDA = 1'b0;
         else if ( j==1 ) if ( reg_addr1[i]  ) release SDA; else force SDA = 1'b0;
         else if ( j==2 ) if ( reg_addr2[i]  ) release SDA; else force SDA = 1'b0;
         else if ( j==3 ) if ( reg_addr3[i]  ) release SDA; else force SDA = 1'b0;
         else if ( j==4 ) if ( reg_addr4[i]  ) release SDA; else force SDA = 1'b0;
         else if ( j==5 ) if ( reg_data4[i]  ) release SDA; else force SDA = 1'b0;
         else if ( j==6 ) if ( reg_data3[i]  ) release SDA; else force SDA = 1'b0; 
        else if  ( j==7 ) if ( reg_data2[i]  ) release SDA; else force SDA = 1'b0;
        else if  ( j==8 ) if ( reg_data1[i]  ) release SDA; else force SDA = 1'b0;

         # i2c_cycle_div4 release SCL;
         # i2c_cycle_div2 force SCL = 0;
         # i2c_cycle_div4;
       end
       I2C_WAIT_ACK;
     end
  # i2c_cycle_div4;
  I2C_STOP;

  $display ( "-------------------- I2C_Write --------------------" );
  $display ( "  Slave_Address       Register_Address             Register_Data  " );
  $display ("       0x%h              0x%h            0x%h       ",
                 slave_addr,        reg_addr,       reg_data       );
end
endtask
//*******************************************************************************************************
// accton  iic to spi task
// ALTERE SPI IP CORE
//---------------------------------------------------------------------------------------------------------
//Internal | Register   | Type   | 32-11 | 10   | 9    | 8     | 7      | 6    |  5    | 4    |  3   | 2-0 |
//Address  |   Name     | [R/W]  |       |      |      |       |        |      |       |      |      |     |
//-------------------------------------------------------------------------------------------------------- -
//  0(0x00)| rxdata     |  R     |                          RXDATA |(n-1..0)
//-------------------------------------------------------------------------------------------------------- -   
//  1(0x04)| txdata     |  W     |                         TXDATA |(n-1..0)
//-------------------------------------------------------------------------------------------------------- -   
//  2(0x08)| status     | R/W    |       |      | EOP  | E     |RRDY    |TRDY  |  TMT  | TOE  |  ROE |     |
//-------------------------------------------------------------------------------------------------------- -   
//  3(0x0c)| control    | R/W    |       |SSO   | IEOP | IE    |IRRDY   |ITRDY |       | ITOE |  IROE|     |
//---------------------------------------------------------------------------------------------------------   
//  4(0x  )| Reserved   |        
//----------------------------------------------------------------------------------------------------------   
//  5(0x10)| slaveselect| R/W    |                        Slave Select Mask
//---------------------------------------------------------------------------------------------------------  
//  6(0x14)| eop_value  | R/W    |                    End of Packet Value (n-1..0)
//----------------------------------------------------------------------------------------------------------
//*******************************************************************************************************
task iic_w_spi_24bit;

input [7:0] slave_addr;
input [7:0] reg_addr;
input [7:0] reg_data;
   begin
        //1. check TRDY   
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)
      if(rvReadData_Status[6]==0)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6) 
        
        
        //2. Enable SSO bit 
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, 8'h04);	//write 0x0c control register(bit 10)

        
        
        //3. Setting Txdata (Address Data)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h04, slave_addr );  //Write 0x04 txdata register 
       //check TRDY  
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)
      if(rvReadData_Status[6]==0)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6) 
        //Clear IRRDY bit  (bit 7) option
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, rvReadData_Control & 8'h7f);     //write 0x0c control register (bit 7)   
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)   
       
         
         
        //4. Setting Txdata (Offset Data)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h04, reg_addr );  //Write 0x04 txdata register
       //check TRDY  
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)
      if(rvReadData_Status[6]==0)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6) 
        //Clear IRRDY bit  (bit 7) option
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, rvReadData_Control & 8'h7f);     //write 0x0c control register (bit 7)   
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)   
       
        
        
        
        //5. Setting Txdata (Write Data)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h04, reg_data );  //Write 0x04 txdata register
       //check TRDY  
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)
      if(rvReadData_Status[6]==0)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6) 
        //Clear IRRDY bit  (bit 7) option
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, rvReadData_Control & 8'h7f);     //write 0x0c control register (bit 7)   
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)   
       
        
        //6. Read RxData (bit 7~0)
        //# wait_time   I2C_READ_4Byte ( 8'h46, 8'h00, 8'h47 );                 //Read  0x00 rxdata register
        //# wait_time   I2C_READ      ( 8'h46, 8'h00, 8'h47 , rvReadData_MISO);                 //Read  0x00 rxdata register
       
        
        //7. Check RRDY

        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status );	   //Read  0x08 Status register  
          wait (SDA ==1);  
      if(rvReadData_Status[7]==1)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)   
        
        
        //6. Disable SSO bit 
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, 8'h00 );	//write 0x10 control register
   end
endtask


task iic_r_spi_24bit;

input [7:0] slave_addr;
input [7:0] reg_addr;
output[7:0] reg_data;
   begin
        //1. check TRDY   
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)
      if(rvReadData_Status[6]==0)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6) 
        
        
        //2. Enable SSO bit 
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, 8'h04);	//write 0x0c control register(bit 10)

        
        
        //3. Setting Txdata (Address Data)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h04, slave_addr );  //Write 0x04 txdata register 
       //check TRDY  
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)
      if(rvReadData_Status[6]==0)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6) 
        //Clear IRRDY bit  (bit 7) option
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, rvReadData_Control & 8'h7f);     //write 0x0c control register (bit 7)   
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)   
       
         
         
        //4. Setting Txdata (Offset Data)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h04, reg_addr );  //Write 0x04 txdata register
       //check TRDY  
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)
      if(rvReadData_Status[6]==0)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6) 
        //Clear IRRDY bit  (bit 7) option
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, rvReadData_Control & 8'h7f);     //write 0x0c control register (bit 7)   
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)   
       
        
        
        
        //5. Setting Txdata (Write Data)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h04, 8'hzz );  //Write 0x04 txdata register
       //check TRDY  
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)
      if(rvReadData_Status[6]==0)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6) 
        //Clear IRRDY bit  (bit 7) option
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, rvReadData_Control & 8'h7f);     //write 0x0c control register (bit 7)   
        # wait_time   I2C_READ       ( 8'h46, 8'h0d, 8'h47 , rvReadData_Control );    //read  0x0c control register (bit 7~0)   
       
        
        //6. Read RxData (bit 7~0)
        //# wait_time   I2C_READ_4Byte ( 8'h46, 8'h00, 8'h47 );                 //Read  0x00 rxdata register
        # wait_time   I2C_READ      ( 8'h46, 8'h00, 8'h47 , rvReadData_MISO);                 //Read  0x00 rxdata register
       
        
        //7. Check RRDY

        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status );	   //Read  0x08 Status register  
          wait (SDA ==1);  
      if(rvReadData_Status[7]==1)
        # wait_time   I2C_READ       ( 8'h46, 8'h08, 8'h47 , rvReadData_Status  );	//Read  0x08 Status register  (bit 6)   
        
        
        //6. Disable SSO bit 
        # wait_time   I2C_WRITE      ( 8'h46, 8'h0d, 8'h00 );	//write 0x10 control register
        
        reg_data = rvReadData_MISO;
   end
endtask
        
endmodule

