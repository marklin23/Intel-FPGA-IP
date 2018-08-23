//=============================================
// edit by Mark 2017/10/10
// Support Repeat Start and Burst Write/read
// Support WatchDog and IIC Filter
// Bug fix oWriteEn , oReadEn 
//=============================================
// 2017-10-10  add Burst Read Option
// 2018-01-02  add Read Offset Pointer 
//=============================================
//wire       wSDAoe           ;
//wire [7:0] wvTxData         ;
//wire [6:0] wvRxAddr         ;
//wire [7:0] wvRxData         ;
//wire [7:0] wvRxOffset       ;
//wire       wWriteEn         ;
//wire       wReadEn          ;
//wire [3:0] wvSCLCnt         ;
//wire [3:0] wvState          ;
//
//IIC_Decoder #(
//   .WRITE_BYTE    ( 1      ),
//   .READ_BYTE     ( 1      ),
//   .WATCHDOG_TIME ( 131000 )    //unit us  
//   
//)IIC_Decoder_INST(
//	.iRstn      ( rRstn      ),
// .iClk       ( rSysClk    ),
// .iFlag      (            ),
// .iWDTEn     (            ), 
//	.iSCL       ( SCL        ),
//	.iSDA       ( SDA        ),
//	.oSDAoe     ( wSDAoe     ),
//	.ivIICADDR  ( `IIC_ADDR  ),
//	.ivTxData   ( wvTxData   ),
//	.ovRxAddr   ( wvRxAddr   ),
//	.ovRxData   ( wvRxData   ),
//	.ovRxOffset ( wvRxOffset ),
//	.oWriteEn   ( wWriteEn   ),
//	.oReadEn    ( wReadEn    ),
//	.ovSCLCnt   ( wvSCLCnt   ),
//	.ovState    ( wvState    )
//);
//=============================================
module IIC_Decoder#(
   parameter      WRITE_BYTE    = 1,
   parameter      READ_BYTE     = 1,
   parameter      WATCHDOG_TIME = 131000    //unit us
   
)(
	input          iRstn, 
   input          iClk,
   //Wdt timer sig
   input          iFlag,
   input          iWDTEn,
	// I2C_Interface 
	input          iSCL,
	input          iSDA,
	output         oSDAoe,
   // Decode sig
	input    [6:0] ivIICADDR,
	input    [7:0] ivTxData,
	output   [6:0] ovRxAddr,	
	output   [7:0] ovRxData,
	output   [7:0] ovRxOffset,
	output         oWriteEn,
	output         oReadEn,
	output   [4:0] ovSCLCnt,
	output   [4:0] ovState

);
//iic state
   localparam   ST_IDLE        =  4'd0;
	localparam   ST_ADDR        =  4'd1;
	localparam   ST_ADDRACK     =  4'd2;
	localparam   ST_OFFSET      =  4'd3;
	localparam   ST_OFFSETACK   =  4'd4;
	localparam   ST_WRDATA      =  4'd5;
	localparam   ST_RDDATA      =  4'd6;
	localparam   ST_WRACK       =  4'd7;
	localparam   ST_RDACK       =  4'd8;
	localparam   ST_WAITST_STOP =  4'd9;
	localparam   ST_STOP        =  4'd10;
   
   
// iic sig
	reg	[4:0]    rvState      ;
	reg	[10:0]   rvDecodeData ;
	reg	[4:0]    rvSCLCnt     ;
	reg	[6:0]    rvAddrData   ;
	reg			   rWRn         ;
	reg	[7:0]    rvOffsetData ;
	reg	[7:0]    rvWriteData  ;
	reg            rSDAo        ;
	reg	[7:0]    rvShifttemp  ;
	reg	[1:0]    rvRdCnt      ;
   reg   [1:0]    rvWrCnt      ; 
	reg	[1:0]    rvSDAPipe    ;
	reg	[1:0]    rvSCLPipe    ;
   wire           wTxShift     ;
   wire           wLoad        ;   
   wire           wIICRstn     ;
   wire           wFilteredSCL ;
   wire           wFilteredSDA ;
//=========================================================================================================================
GlitchFilter #
(
    .TOTAL_STAGES(10)
) mSCLGlitchFilter
(
    .iClk                   ( iClk   ),
    .iRst                   ( !iRstn ),
    .iCE                    ( 1'b1   ),
    .iSignal                ( iSCL ),
    .oGlitchlessSignal      ( wFilteredSCL )
);

GlitchFilter #
(
    .TOTAL_STAGES(10)
) mSDAGlitchFilter
(
    .iClk                   ( iClk ),
    .iRst                   ( !iRstn ),
    .iCE                    ( 1'b1 ),
    .iSignal                ( iSDA ),
    .oGlitchlessSignal      ( wFilteredSDA )
);
//=========================================================================================================================                              

// WatchDog sig

   reg            rSoftRstn    ;
   reg   [2:0]    rvWDState    ;        
   reg   [2:0]    rvWDStateNext;
   reg   [17:0]   rvWDCnt      ;
   wire           wWDTRstn     ;
//=============================================
//	WatchDog Function
//=============================================
 	localparam   ST_0           =  3'd0;
	localparam   ST_1           =  3'd1;
	localparam   ST_2           =  3'd2;
   
always @(posedge iClk or negedge wWDTRstn)
	if(!wWDTRstn)
      rvWDState         <= ST_0;
   else 
      rvWDState         <= rvWDStateNext;

always @(posedge iClk or negedge wWDTRstn)
	if(!wWDTRstn)
      rvWDCnt          <= 17'd0;
   else if((rvWDState == ST_0) || (rvSDAPipe[0]^rvSDAPipe[1]) || (iWDTEn == 0))
      rvWDCnt          <= 17'd0;
   else  
      rvWDCnt          <=  (rvWDCnt == WATCHDOG_TIME-1)     ?  rvWDCnt         :
                           (rvWDState == ST_1)&&(iFlag) ?  rvWDCnt + 17'd1 : rvWDCnt;
                           
always @(*)  
   begin
   // default condition
      rvWDStateNext    = ST_0;
      rSoftRstn        = 1'b1;
         begin
            case(rvWDState)
               ST_0:begin 
                        rvWDStateNext    = (rvState[4:0] == ST_STOP ) ? ST_0 :
                                           (rvSDAPipe    == 2'b10   ) ? ST_1 : ST_0 ;
                        rSoftRstn        = 1'b1;
                       end
               ST_1   :begin
                        rvWDStateNext    = (rvState[4:0] == ST_STOP ) ? ST_0 :
                                           (rvWDCnt== WATCHDOG_TIME-1)? ST_2 : ST_1 ;
                        rSoftRstn        = 1'b1;
                       end
               ST_2   :begin
                        rvWDStateNext     = ST_0;
                        rSoftRstn         = 1'b0;
                       end           
               default:begin
                        rvWDStateNext     = ST_0;
                        rSoftRstn         = 1'b1;
                       end
            endcase
         end      
   end
//========================================================================================================================= 
//========================================================================================================================= 
 
//=============================================
// IIC SLAVE Function
//============================================= 
 
 
 
//=============================================
// IIC Pipe
//=============================================
always @(posedge iClk or negedge wIICRstn)
	begin
		rvSDAPipe	<=	!wIICRstn	?	2'b11	:	{rvSDAPipe[0],wFilteredSDA};
		rvSCLPipe	<=	!wIICRstn	?	2'b11	:	{rvSCLPipe[0],wFilteredSCL};
	end
   
//=============================================
// SCL Counter
//=============================================
always @(posedge iClk or negedge wIICRstn)
	if(!wIICRstn)
		rvSCLCnt    <=	5'b0;
	else if(((rvSCLPipe== 2'b11)&&(rvSDAPipe==2'b10))||((rvSCLPipe== 2'b11)&&(rvSDAPipe==2'b01)))
		rvSCLCnt    <=	5'b0;
	else if (rvSCLPipe==2'b10)
		rvSCLCnt    <=	((rvSCLCnt==5'd9))	?	5'b1	:	rvSCLCnt	+	1'b1;
   else
      rvSCLCnt    <= rvSCLCnt;
//=============================================
//State machine 
//=============================================


always @(posedge iClk or negedge wIICRstn)
	if(!wIICRstn)
		begin
			rvState			<=	ST_IDLE;
			rvDecodeData   <=	11'b0;
			rvRdCnt	   	<=	1'b0;
			rvWrCnt	   	<=	1'b0;
		end
	else if ((rvSCLPipe== 2'b11)&&(rvSDAPipe==2'b10)) //Start
		begin
			rvState			<=	/* (rvState!=ST_IDLE)	?	ST_OFFSET	:	 */ST_IDLE;
			rvRdCnt		   <=	1'b0;
			rvWrCnt	   	<=	1'b0;	
		end
	else if	((rvSCLPipe== 2'b11)&&(rvSDAPipe==2'b01)) //Stop
		begin
			rvState			<=	ST_STOP;
			rvRdCnt		   <=	1'b0;
			rvWrCnt		   <=	1'b0;
		end
	else
		begin
		case(rvState)
			
			ST_IDLE:	begin       //0  unused
						rvState			<=	ST_ADDR;
						rvDecodeData	<=	rvDecodeData;
						rvRdCnt	      <=	1'b0;
						rvWrCnt     	<=	1'b0;
					end
			ST_ADDR:begin         //1
						rvState        <=	(rvSCLCnt==5'd9)		?	ST_ADDRACK		:	ST_ADDR;
						rvDecodeData   <=	(rvSCLPipe== 2'b01)	?	{rvDecodeData[9:0],wFilteredSDA}	:	rvDecodeData;
                  rvRdCnt	      <=	rvRdCnt;
					end					
			ST_ADDRACK:	begin    //2
						rvState        <=	((rvAddrData[6:0] == ivIICADDR)&&(rvSCLPipe== 2'b10))?	((rWRn==1'b0)?ST_OFFSET:ST_RDDATA)
																															:	ST_ADDRACK;
                  rvDecodeData   <= rvDecodeData;                  
                  rvRdCnt	      <=	rvRdCnt;
                  rvWrCnt	      <=	rvWrCnt;
					end		
			
			ST_OFFSET:	begin     //3
						rvState        <=	(rvSCLCnt==5'd9)			?	ST_OFFSETACK		:	ST_OFFSET;
						rvDecodeData   <=	(rvSCLPipe== 2'b01)	?	{rvDecodeData[9:0],wFilteredSDA}	:	rvDecodeData;
                  rvRdCnt     	<=	rvRdCnt;
                  rvWrCnt	      <=	rvWrCnt;
					end	
			ST_OFFSETACK:	begin   //4
						rvState		   <=	(rvSCLPipe!= 2'b10)	?	ST_OFFSETACK	:	ST_WRDATA;
						rvDecodeData   <= rvDecodeData;		
                  rvRdCnt  	   <=	rvRdCnt;
                  rvWrCnt	      <=	rvWrCnt;
					end
			ST_WRDATA:	begin   //5
						rvDecodeData	<=	(rvSCLPipe== 2'b01)	?	{rvDecodeData[9:0],wFilteredSDA}	:	rvDecodeData;
						rvState        <=	(rvSCLCnt==5'd9)		?	ST_WRACK		:	ST_WRDATA;
						rvWrCnt	      <=	(rvSCLCnt==5'd9)		?	((rvWrCnt==WRITE_BYTE)	?	1'b0	:	rvWrCnt	+	1'b1)	:	rvWrCnt;
                  rvRdCnt	      <=	rvRdCnt;
					end
					
			ST_RDDATA:	begin  //6
						rvState		   <=	(rvSCLCnt==5'd9)	?	ST_RDACK		:	ST_RDDATA;
                  rvDecodeData   <= rvDecodeData;
                  rvRdCnt	      <=	rvRdCnt;
                  rvWrCnt	      <=	rvWrCnt;
					end
					
			ST_WRACK:	begin   //7
						rvDecodeData	<= rvDecodeData;
						rvState		   <=	(rvSCLCnt==5'd1)&&(rvWrCnt==WRITE_BYTE)   ?	ST_WAITST_STOP		:	
																(rvSCLCnt==5'd1)              ?	ST_WRDATA         :	ST_WRACK;
                  rvRdCnt	      <=	rvRdCnt;
                  rvWrCnt	      <=	rvWrCnt;
					end
			ST_RDACK:begin       //8
						
						rvState		   <=	(rvSCLPipe== 2'b01)&&(wFilteredSDA==1'b1)		?	ST_WAITST_STOP	:			  //HOST NACK turn to ST_WAITST_STOP
															(rvSCLCnt==5'd1)	            ?	ST_RDDATA		:	ST_RDACK;   //multiple read
                  rvDecodeData	<= rvDecodeData;
						rvRdCnt	      <=	(rvSCLPipe== 2'b01)?	((rvRdCnt==READ_BYTE-1)	?	1'b0	:	rvRdCnt	+	1'b1)	:	rvRdCnt;
						rvWrCnt	      <=	rvWrCnt;
					end
			ST_WAITST_STOP:begin   //9
						rvState		   <=	rvState;
                  rvDecodeData	<= rvDecodeData;
                  rvWrCnt	      <=	rvWrCnt;
                  rvRdCnt	      <=	rvRdCnt;
                  end
			ST_STOP: begin        //10
						rvState		   <=	rvState;
                  rvDecodeData	<= rvDecodeData;
                  rvWrCnt	      <=	rvWrCnt;
                  rvRdCnt	      <=	rvRdCnt;
                  end
			default:begin
						rvState	   	<=	ST_IDLE;
                  rvDecodeData	<= rvDecodeData;
						rvRdCnt	      <=	rvRdCnt;
						rvWrCnt	      <=	rvWrCnt;
					end
					
		
		endcase
		end
//=============================================
//data-capture
//=============================================
always @(posedge iClk or negedge wIICRstn)
	if(!wIICRstn)
		begin
			rvAddrData              <=	7'b0;
			rWRn                    <=	1'b0;
			rvOffsetData            <=	8'b0;
			rvWriteData             <=	8'b0;
		end
	else	
		begin 
			case(rvState)
			 	ST_IDLE	:
					begin
						rvAddrData     <=	rvAddrData;
						rWRn           <=	1'b0;
						rvOffsetData   <=	rvOffsetData;
						rvWriteData    <=	8'b0;
					end 
				ST_ADDRACK		:
					begin
						rvAddrData     <=	rvDecodeData[7:1];
						rWRn           <=	rvDecodeData[0];
                  rvOffsetData   <=	rvOffsetData;
                  rvWriteData    <=	rvWriteData;
					end				
			
				ST_OFFSETACK	:
					begin
                  rvAddrData     <=	rvAddrData;
                  rWRn           <=	rWRn;
						rvOffsetData   <=	rvDecodeData[7:0];
                  rvWriteData    <=	rvWriteData;
					end				
			
				ST_WRACK	:
					begin
                  rvAddrData     <=	rvAddrData;
						rvWriteData    <=	rvDecodeData[7:0];
                  rWRn           <=	rWRn;
						rvOffsetData   <=	rvOffsetData;
					end
            ST_RDACK :
               begin
                  rvAddrData     <=	rvAddrData;
						rvWriteData    <=	rvWriteData;
                  rWRn           <=	rWRn;
						rvOffsetData   <=	((rvSCLPipe== 2'b01)&&(wFilteredSDA==1'b0)) ? rvOffsetData + 1 : rvOffsetData;  // Read Offset Pointer 
					end
				ST_STOP	:
					begin
						rvAddrData     <=	rvAddrData;
						rWRn           <=	rWRn;
						rvOffsetData   <=	rvOffsetData;
						rvWriteData    <=	rvWriteData;
					end	
				default:
					begin
						rvAddrData     <=	rvAddrData;
						rWRn           <=	rWRn;
						rvOffsetData   <=	rvOffsetData;
						rvWriteData    <=	rvWriteData;
					end
			endcase
		end




//=============================================
//	 TX  rSDAo
//=============================================
//always @(posedge iClk or negedge wIICRstn)
always @(*)
	if(!wIICRstn)
		rSDAo	<=	1'b1;
	else if ((rvSCLPipe== 2'b11)&&(rvSDAPipe==2'b10))
		rSDAo	<=	1'b1;
	else if	((rvSCLPipe== 2'b11)&&(rvSDAPipe==2'b01))
		rSDAo	<=	1'b1;
	else	
		begin 
			if(rvState[4:0] == ST_ADDRACK)
         
				rSDAo <=	(rvAddrData[6:0] == ivIICADDR) ? 1'b0 : 1'b1;
            
			else if(rvState[4:0] == ST_OFFSETACK)
         
				rSDAo	<=	((rvSCLCnt==5'd9)) ? 1'b0 : 1'b1;
            
			else if	(rvState[4:0] == ST_WRACK)
         
				rSDAo	<=	(rvSCLCnt==5'd9) ? 1'b0 : 1'b1;
            
			else if(rvState[4:0] == ST_RDACK)
         
				rSDAo	<=	1'b1;
            
 			else if	(wTxShift)	 
         
				rSDAo	<=	rvShifttemp[7]; 
			else
				rSDAo	<=	1'b1;
		end	
//=============================================
//	 TX  SHIFT
//=============================================

always @(posedge iClk or negedge wIICRstn)
 	if(!wIICRstn)
		rvShifttemp[7:0]     <=	8'b0;
	else 
		begin
			if(wLoad)
            rvShifttemp    <=	ivTxData[7:0];
               
			else if((wTxShift==1'b1) && (rvSCLPipe== 2'b10))
         
            rvShifttemp    <=	{rvShifttemp[6:0],1'b0};
		end		


      
//=============================================
//	Assignment Block
//=============================================

	assign	ovRxAddr       =  rvAddrData   [6:0];
	assign	ovRxData       =  rvWriteData  [7:0];
	assign	ovRxOffset     =  rvOffsetData [7:0];
	assign	oWriteEn       =  ((rvState[4:0]  == ST_WRACK	) && (!rWRn)  &&  (rvSCLPipe== 2'b11)	);
	assign	oReadEn        =  (((rvState[4:0] == ST_ADDRACK)||(rvState[4:0] == ST_RDACK)) && (rWRn) && (rvSCLPipe==2'b11) );
	assign	oSDAoe         =  rSDAo;

	assign   ovState        =  rvState[4:0];
	assign	ovSCLCnt       =	rvSCLCnt;
   assign	wLoad          =  (((rvState[4:0] == ST_ADDRACK)||(rvState[4:0] == ST_RDACK))	&&	(rWRn) && (rvSCLPipe==2'b10) );
   assign   wTxShift       =  (rvState[4:0]!=ST_RDDATA)  ?	1'b0  :
                              (rvSCLCnt==5'd9)          ?  1'b0  :  1'b1;
//Reset sig
   assign   wIICRstn       = iRstn && rSoftRstn;
   assign   wWDTRstn       = iRstn && iWDTEn;

endmodule
module GlitchFilter # //% <br>
(
    parameter   TOTAL_STAGES = 3
)
(
                //% Clock Input<br> 
    input       iClk,
                //% Asynchronous Reset Input<br>
    input       iRst,
                //% Clock Enable from a previous stage<br>
    input       iCE,
                //% Input Signals<br>
    input       iSignal,
                //%Glitchless Signal Flag<br>
    output      oGlitchlessSignal
);
//////////////////////////////////////////////////////////////////////////////////
// Includes
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Defines
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Internal Signals
//////////////////////////////////////////////////////////////////////////////////
                        //%Glitchless Signal Register Data Input<br>
reg                     rGlitchlessSignal_d;
                        //%Glitchless Signal Register Output<br>
reg                     rGlitchlessSignal_q;

                        //%Sampled Data Register Data Input<br>
reg [TOTAL_STAGES-1:0]  rvSampledData_d;
                        //%Sampled Data Register Output<br>
reg [TOTAL_STAGES-1:0]  rvSampledData_q;


//////////////////////////////////////////////////////////////////////////////////
// Continous assigments
//////////////////////////////////////////////////////////////////////////////////
assign  oGlitchlessSignal   =   rGlitchlessSignal_q;

//////////////////////////////////////////////////////////////////////////////////
// Sequential logic
//////////////////////////////////////////////////////////////////////////////////
always @(posedge iClk or posedge iRst)
//If Reset, then the GlitchlessSignal is set to 0 and all the Sampled Data  
//Registers outputs are set with the present input Signal value.

//If no, then the Glitchless Signal register data is updated and if the Clock 
//enable is high, also the Sampled Data registers.
//Otherwise, the Sampled Data registers maintains their values.
begin
    if(iRst)                                                    
    begin
        rGlitchlessSignal_q     <=      0;                           
        rvSampledData_q         <=      {TOTAL_STAGES{iSignal}};    
    end
    else
    begin
        rGlitchlessSignal_q     <=      rGlitchlessSignal_d;
        if(iCE)
        begin
            rvSampledData_q     <=      rvSampledData_d;
        end
        else
        begin
            rvSampledData_q     <=      rvSampledData_q;
        end
    end
end
//////////////////////////////////////////////////////////////////////////////////
// Combinational logic
//////////////////////////////////////////////////////////////////////////////////
//Compares the sampled data among themselves and if the data values are consistent 
//in all stages, stablish a Glitchless Signal with it.
always @*
begin
    rvSampledData_d         =    {rvSampledData_q[(TOTAL_STAGES-2):0],iSignal};
    rGlitchlessSignal_d     =    rGlitchlessSignal_q;
    if(~|rvSampledData_q)
    begin
        rGlitchlessSignal_d =   0;
    end
    if(&rvSampledData_q)
    begin
        rGlitchlessSignal_d =   1;
    end
end
//////////////////////////////////////////////////////////////////////////////////
// Instances
//////////////////////////////////////////////////////////////////////////////////

endmodule
//////////////////////////////////////////////////////////////////////////////////