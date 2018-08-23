//-----------------------
// MTL2 800x480 LCD panel


//----------------------------------------------------------------------//----------------------------------------------------------------------//
//LCD Horizontal Timing Specifications                                  //LCD Vertical Timing Specifications                                    //
//----------------------------------------------------------------------//----------------------------------------------------------------------//
//    Item                | Symbol      | Typical Value       |  Unit   //    Item                 |  Symbol   |  Typical Value       |  Unit   //
//----------------------------------------------------------------------//----------------------------------------------------------------------//
//                        |             | min  | typ  | max   |         //                         |           |  min  | typ  | max   |         //
//----------------------------------------------------------------------//----------------------------------------------------------------------//
//Horizontal Display Area |  thd        | -    | 800  | -     |  DCLK   // Vertical Display Area   |  tvd      |  -    | 480  | -     |  TH     //
//----------------------------------------------------------------------//----------------------------------------------------------------------//
//DCLK Frequency          |  fclk       | 26.4 | 33.3 | 46.8  |  MHz    // VS period time          |  tv       |  510  | 525  | 650   |  TH     //
//----------------------------------------------------------------------//----------------------------------------------------------------------//
//One Horizontal Line     |  th         | 862  | 1056 | 1200  |  DCLK   // VS pulse width          |  tvpw     |  1    | -    | 20    |  TH     //
//----------------------------------------------------------------------//----------------------------------------------------------------------//
//HS pulse width          |  thpw       | 1    |      | 40    |  DCLK   // VS Blanking             |  tvb      |  23   | 23   | 23    |  TH     //
//----------------------------------------------------------------------//----------------------------------------------------------------------//
//HS Blanking             |  thb        | 46   | 46   | 46    |  DCLK   // HS Front Porch          |  tvfp     |  7    | 22   | 147   |  TH     //
//----------------------------------------------------------------------//----------------------------------------------------------------------//
//HS Front Porch          |  thfp       | 16   | 210  | 354   |  DCLK   //
//----------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------------------//
//  Horizontal  Timing
//       H pulse width(thpw)
// HS   _____ <----> _____________________________....._________________________         _______________                
//           |______|          |                                   |            |_______|
//                             |                                   |            |
//             fclk            |                                   |            |
//            <---->           |                                   |            |
// DCLK _____    __    __    __|   __    __    __          __    __|   __    __ |  __    __                 
//           |__|  |__|  |__|  |__|  |__|  |__|  |......__|  |__|  |__|  |__|  ||_|  |__|  |
//                             |                                   |            |
// R0~R7      _____ _____ _____|_____ _____ _____ _____ _____ _____|_____ _____ |     _____ _____ 
//           |_____|_____|_____|__R__|__R__|__R__|__R__|__R__|__R__|_____|_____||....|_____|_____|
// G0~G7      _____ _____ _____|_____ _____ _____ _____ _____ _____|_____ _____ |     _____ _____ 
//           |_____|_____|_____|__G__|__G__|__G__|__G__|__G__|__G__|_____|_____||....|_____|_____|
// B0~B7      _____ _____ _____|_____ _____ _____ _____ _____ _____|_____ _____ |     _____ _____ 
//           |_____|_____|_____|__B__|__B__|__B__|__B__|__B__|__B__|_____|_____||....|_____|_____|
//             H Blanking (thb)|   Horizontal Display Area (thd)   | H FrontPorch(thfp)
//           <---------------->|<--------------------------------->|<---------->|
//                                Total Area ( th )  
//           <-----------------------------------------------------------------> 
//-------------------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------------------//
//  Vertical  Timing
//       VS pulse width(tvpw)
// VS   _____ <----> _____________________________.....________________________         _______________                
//           |______|          |                                   |           |_______|
//                             |                                   |           |
//             th              |                                   |           |
//            <---->           |                                   |           |
// HS   _____    __    __    __|   __    __    __          __    __|   __    __|  __    __                 
//           |__|  |__|  |__|  |__|  |__|  |__|  |......__|  |__|  |__|  |__|  |_|  |__|  |
//                             |                                   |           |
//                             |                                   |           |
//             V Blanking (tvb)|   Vertical Display Area (tvd)     | V FrontPorch(tvfp)
//             V Blanking (tvb)|   Vertical Display Area (tvd)     | V FrontPorch(tvfp)
//           <---------------->|<--------------------------------->|<--------->|
//                                Total Area ( tv )  
//           <-----------------------------------------------------------------> 
//-------------------------------------------------------------------------------------------------------//




module MTL_Driver #(

   parameter  thd  = 800,
   parameter  thpw = 1,
   parameter  thfp = 210,
   parameter  thb  = 46,
   parameter  th   = thb+thfp+thd,
   
   parameter  tvd  = 480,
   parameter  tvpw = 1,
   parameter  tvfp = 22,
   parameter  tvb  = 23,
   parameter  tv   = tvb+tvfp+tvd   

)(

	input                iClk,  // wClk40
	input                iRstn,
   input       [7:0]    ivControl,
	input      [23:0]    ivRGB_Ram,
   output     [10:0]    ovHcounter,
   output     [10:0]    ovVcounter,
	
	input                MTL2_INT,
	output               MTL2_I2C_SCL,
	inout                MTL2_I2C_SDA,	
     
     
  
     
	inout                MTL2_BL_ON_n,
	output               MTL2_DCLK,
	output      [7:0]    MTL2_R,
	output      [7:0]    MTL2_G,
	output      [7:0]    MTL2_B,
	output               MTL2_HSD,
	output               MTL2_VSD
		

);

function integer logb2 ( input integer size );
	integer size_buf;
	begin
		size_buf = size;
		for(logb2=-1; size_buf>0; logb2=logb2+1) size_buf = size_buf >> 1;
	end
endfunction

reg [logb2(th):0] rvHcounter;
reg [logb2(th):0] rvVcounter;
reg rHSync, rVSync;

	assign MTL2_DCLK = iClk;

always@(posedge iClk)
   if(iRstn == 0) begin
      rvHcounter <= 0;
      rvVcounter <= 0;
		rHSync     <= 0;
		rVSync     <= 0;
   end
   else begin
      rvHcounter <= ( rvHcounter < th   ) ? rvHcounter +1 : 0 ;
      rvVcounter <= ( rvHcounter ==  0  ) ? (( rvVcounter >=  tv ) ? 0 : rvVcounter +1) : rvVcounter;						  
		rHSync     <= ( rvHcounter < thpw ) ? 1'b0 : 1'b1;
		rVSync     <= ( rvVcounter < tvpw ) ? 1'b0 : 1'b1;				  
						  
						  
						  
						  
   end
   
	assign MTL2_HSD = rHSync;
	assign MTL2_VSD = rVSync;


//data generater

reg [7:0] rvR,rvG,rvB;



always@(posedge iClk)
   if(iRstn == 0) begin
      rvB <= 0;
      rvG <= 0;
      rvR <= 0;
   end
   else if (rvHcounter == 0 ) begin   
      rvB <= 0;
      rvG <= 0;
      rvR <= 0;      
   end   
   else if ( (rvHcounter > thb) && ( rvHcounter < (thd+thb) )/* && (rvVcounter > tvb ) && (rvVcounter < tvb+tvd) */) begin
      case(ivControl)
      0: begin      
            rvB <= rvB + 1;
            rvG <= rvG + 1;
            rvR <= rvR + 1;      
         end
      
      1: begin      
            rvB <= 8'hFF;
            rvG <= 0;
            rvR <= 0;      
         end

      2: begin      
            rvB <= 0;
            rvG <= 8'hFF;
            rvR <= 0;         
         end

      3: begin      
            rvB <= 0;
            rvG <= 0;
            rvR <= 8'hFF;          
         end

      4: begin      
            rvB <= 0;
            rvG <= 8'hFF;
            rvR <= 8'hFF;  				
         end 
		5: begin      
            rvB <= ivRGB_Ram[ 7: 0];
            rvG <= ivRGB_Ram[15: 8];
            rvR <= ivRGB_Ram[23:16];  				
         end         
      endcase

   end

	assign MTL2_R = rvR;
	assign MTL2_G = rvG;
	assign MTL2_B = rvB;	
	assign ovHcounter[10:0] =  rvHcounter[10:0];
	assign ovVcounter[10:0] =  rvVcounter[10:0];
	
endmodule
