`timescale 1ns/1ps

module LFSR_TB #(parameter OP_WIDTH = 8)();

//*********parameters decleration**********

parameter CLOCK_PERIOD = 10;
parameter Test_Cases = 10;


//*********Memories**********

reg [OP_WIDTH-1:0] TEST_DATA [Test_Cases-1:0];
reg [OP_WIDTH-1:0] Expec_OUT [Test_Cases-1:0];


//*********integer LOOPS***********

integer i;

//**********DUT Signals*************
reg [OP_WIDTH-1:0]  DATA_TB;
reg                 ACTIVE_TB;
reg                 CLK_TB;
reg                 RST_TB;
wire                CRC_TB;
wire                Valid_TB;

//**********DUT Instantiation************
LFSR DUT (
.DATA(DATA_TB),
.ACTIVE(ACTIVE_TB),
.CLK(CLK_TB),
.RST(RST_TB),
.CRC(CRC_TB),
.Valid(Valid_TB)
);


//***********CLOCK GENERATOR*************

always #(CLOCK_PERIOD/2) CLK_TB = ~CLK_TB;

//***********Initial block***************

initial
begin
//systemfunctions
$dumpfile("LFSR_TB.vcd");
$dumpvars;

//read files
$readmemh("DATA_h.txt",TEST_DATA);  
$readmemh("Expec_Out_h.txt",Expec_OUT);

//initialize
intialize();

// Test Cases
for (i=0;i<Test_Cases;i=i+1)
  begin
   operation(TEST_DATA[i]) ;                       // do_lfsr_operation
   testing(Expec_OUT[i],i) ;           // check output response
  end

#100
$finish ;


 
  
end
 
//***********Tasks***************

task intialize ; 
  begin
    DATA_TB = 'b0;
    CLK_TB = 'b0;
    RST_TB = 'b1;
    ACTIVE_TB = 'b0;
  end 
endtask

task RESET ;
  begin
    RST_TB = 'b1;
    #CLOCK_PERIOD
    RST_TB = 'b0;
    #CLOCK_PERIOD
    RST_TB = 'b1;
  end
endtask

task operation ;
  input [OP_WIDTH-1:0] IN_DATA;
  
  begin
    DATA_TB = IN_DATA;
    RESET();
    ACTIVE_TB = 'b1;
    #(OP_WIDTH * CLOCK_PERIOD)
    ACTIVE_TB = 'b0;
  end
endtask

task testing ;
  input [OP_WIDTH-1:0] IN_TEST;
  input integer        OPERATION_no;
  integer j;
  reg [OP_WIDTH-1:0] gener_out;
  begin
   ACTIVE_TB = 'b0;
   @(posedge Valid_TB)
   for(j = 0;j<OP_WIDTH;j = j+1)
    begin
      #CLOCK_PERIOD gener_out[j] = CRC_TB;
    end 
   if(gener_out == IN_TEST)
     begin
       $display("Test Case %d is succeeded",OPERATION_no+1);
     end
  
   else
     begin
       $display("Test Case %d is failed",OPERATION_no+1);
     end
  end
endtask
endmodule

