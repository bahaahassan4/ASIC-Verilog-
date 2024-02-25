`timescale 1us/1ns
module ALU_TB#(parameter IN_DATA_WIDTH_TB = 16)();
//signal decleration
reg signed [IN_DATA_WIDTH_TB-1:0] A_TB;
reg signed [IN_DATA_WIDTH_TB-1:0] B_TB;
reg clk_TB,rst_TB;
reg [3:0] ALU_FUN_TB;
wire signed [2*IN_DATA_WIDTH_TB-1:0] Arith_OUT_TB;
wire Carry_OUT_TB;
wire Arith_Flag_TB;
wire [IN_DATA_WIDTH_TB-1:0] Logic_OUT_TB;
wire Logic_Flag_TB;
wire [IN_DATA_WIDTH_TB-1:0] CMP_OUT_TB;
wire CMP_Flag_TB;
wire [IN_DATA_WIDTH_TB-1:0] SHIFT_OUT_TB;
wire SHIFT_Flag_TB;


//DUT instantiation
ALU_Top DUT(
.A(A_TB),
.B(B_TB),
.clk(clk_TB),
.rst(rst_TB),
.ALU_FUN(ALU_FUN_TB),
.Arith_OUT(Arith_OUT_TB),
.Carry_OUT(Carry_OUT_TB),
.Arith_Flag(Arith_Flag_TB),
.Logic_OUT(Logic_OUT_TB),
.Logic_Flag(Logic_Flag_TB),
.CMP_OUT(CMP_OUT_TB),
.CMP_Flag(CMP_Flag_TB),
.SHIFT_OUT(SHIFT_OUT_TB),
.SHIFT_Flag(SHIFT_Flag_TB)
);

//clock generator
always #4 
begin
clk_TB = ~clk_TB;
if(clk_TB==1)
  #2; 
else
  #0;
end

//initial block
initial 
begin
  $dumpfile("ALU_TB.vcd");
  $dumpvars;
  clk_TB = 0;
  #10
  rst_TB = 0;
  #10
  rst_TB = 1;
  ALU_FUN_TB = 4'b0000;
  A_TB = -'d5;
  B_TB = -'d5;
  $display("****test case 1 --Addition-- Negative + Negative");
  #10
  ALU_FUN_TB = 4'b0000;
  #10
  if(Arith_OUT_TB == A_TB + B_TB)
    $display("****Test case 1 is PASSED, --ALU OUTPUT = %0d + %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 1 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
  
  A_TB = 'd10;
  B_TB = -'d5;  
  $display("****test case 2 --Addition-- Positive + Negative");
  #10
  ALU_FUN_TB = 4'b0000;
  #10
  if(Arith_OUT_TB == A_TB + B_TB)
    $display("****Test case 2 is PASSED, --ALU OUTPUT = %0d + %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 2 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);  
    
  A_TB = -'d10;
  B_TB = 'd5;  
  $display("****test case 3 --Addition-- Negative + Positive");
  #10
  ALU_FUN_TB = 4'b0000;
  #10
  if(Arith_OUT_TB == A_TB + B_TB)
    $display("****Test case 3 is PASSED, --ALU OUTPUT = %0d + %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 3 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
  
  A_TB = 'd10;
  B_TB = 'd5;  
  $display("****test case 4 --Addition-- Positive + Positive");
  #10
  ALU_FUN_TB = 4'b0000;
  #10
  if(Arith_OUT_TB == A_TB + B_TB)
    $display("****Test case 4 is PASSED, --ALU OUTPUT = %0d + %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 4 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
    
  A_TB = -'d5;
  B_TB = -'d5;
  $display("****test case 5 --Subtraction-- Negative - Negative");
  #10
  ALU_FUN_TB = 4'b0001;
  #10
  if(Arith_OUT_TB == A_TB - B_TB)
    $display("****Test case 5 is PASSED, --ALU OUTPUT = %0d - %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 5 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
    
  A_TB = 'd10;
  B_TB = -'d5;  
  $display("****test case 6 --Subtraction-- Positive - Negative");
  #10
  ALU_FUN_TB = 4'b0001;
  #10
  if(Arith_OUT_TB == A_TB - B_TB)
    $display("****Test case 6 is PASSED, --ALU OUTPUT = %0d - %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 6 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);  
    
  A_TB = -'d10;
  B_TB = 'd5;  
  $display("****test case 7 --Subtraction-- Negative - Positive");
  #10
  ALU_FUN_TB = 4'b0001;
  #10
  if(Arith_OUT_TB == A_TB - B_TB)
    $display("****Test case 7 is PASSED, --ALU OUTPUT = %0d - %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 7 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
  
  A_TB = 'd10;
  B_TB = 'd5;  
  $display("****test case 8 --Subtraction-- Positive + Positive");
  #10
  ALU_FUN_TB = 4'b0001;
  #10
  if(Arith_OUT_TB == A_TB - B_TB)
    $display("****Test case 8 is PASSED, --ALU OUTPUT = %0d - %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 8 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
    
  A_TB = -'d1;
  B_TB = -'d1;
  $display("****test case 9 --Multplication-- Negative * Negative");
  #10
  ALU_FUN_TB = 4'b0010;
  #10
  if(Arith_OUT_TB == A_TB * B_TB)
    $display("****Test case 9 is PASSED, --ALU OUTPUT = %0d * %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 9 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
    
  A_TB = 'd10;
  B_TB = -'d5;  
  $display("****test case 10 --Multiplication-- Positive * Negative");
  #10
  ALU_FUN_TB = 4'b0010;
  #10
  if(Arith_OUT_TB == A_TB * B_TB)
    $display("****Test case 10 is PASSED, --ALU OUTPUT = %0d * %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 10 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);  
    
  A_TB = -'d10;
  B_TB = 'd5;  
  $display("****test case 11 --Multiplication-- Negative * Positive");
  #10
  ALU_FUN_TB = 4'b0010;
  #10
  if(Arith_OUT_TB == A_TB * B_TB)
    $display("****Test case 11 is PASSED, --ALU OUTPUT = %0d * %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 11 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
  
  A_TB = 'd100;
  B_TB = 'd5;  
  $display("****test case 12 --Multiplication-- Positive * Positive");
  #10
  ALU_FUN_TB = 4'b0010;
  #10
  if(Arith_OUT_TB == A_TB * B_TB)
    $display("****Test case 12 is PASSED, --ALU OUTPUT = %0d * %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 12 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
  
  A_TB = -'d1;
  B_TB = -'d1;
  $display("****test case 13 --Division-- Negative / Negative");
  #10
  ALU_FUN_TB = 4'b0011;
  #10
  if(Arith_OUT_TB == A_TB / B_TB)
    $display("****Test case 13 is PASSED, --ALU OUTPUT = %0d / %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 13 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
    
  A_TB = 'd10;
  B_TB = -'d5;  
  $display("****test case 14 --Division-- Positive / Negative");
  #10
  ALU_FUN_TB = 4'b0011;
  #10
  if(Arith_OUT_TB == A_TB / B_TB)
    $display("****Test case 14 is PASSED, --ALU OUTPUT = %0d / %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 14 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);  
    
  A_TB = -'d10;
  B_TB = 'd5;  
  $display("****test case 15 --Division-- Negative / Positive");
  #10
  ALU_FUN_TB = 4'b0011;
  #10
  if(Arith_OUT_TB == A_TB / B_TB)
    $display("****Test case 15 is PASSED, --ALU OUTPUT = %0d / %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 15 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
  
  A_TB = 'd100;
  B_TB = 'd5;  
  $display("****test case 16 --Division-- Positive / Positive");
  #10
  ALU_FUN_TB = 4'b0011;
  #10
  if(Arith_OUT_TB == A_TB / B_TB)
    $display("****Test case 16 is PASSED, --ALU OUTPUT = %0d / %0d = %0d-- , Arithmetic Flag = %0d and Carry out = %0d at time = %0t",A_TB,B_TB,Arith_OUT_TB,Arith_Flag_TB,Carry_OUT_TB,$time);
  else
    $display("****Test case 16 is FAILED, --ALU OUTPUT = %0d-- , Arithmetic Flag = %0d at time = %0t",Arith_OUT_TB,Arith_Flag_TB,$time);
    
  A_TB = 'd7;
  B_TB = 'd5;  
  $display("****test case 17 --AND--");
  #10
  ALU_FUN_TB = 4'b0100;
  #10
  if(Logic_OUT_TB == (A_TB & B_TB))
    $display("****Test case 17 is PASSED, --ALU OUTPUT = %0d & %0d = %0d-- , Logic Flag = %0d at time = %0t",A_TB,B_TB,Logic_OUT_TB,Logic_Flag_TB,$time);
  else
    $display("****Test case 17 is FAILED, --ALU OUTPUT = %0d-- , Logic Flag = %0d at time = %0t",Logic_OUT_TB,Logic_Flag_TB,$time);
    
  A_TB = 'd7;
  B_TB = 'd5;  
  $display("****test case 18 --OR--");
  #10
  ALU_FUN_TB = 4'b0101;
  #10
  if(Logic_OUT_TB == A_TB | B_TB)
    $display("****Test case 18 is PASSED, --ALU OUTPUT = %0d | %0d = %0d-- , Logic Flag = %0d at time = %0t",A_TB,B_TB,Logic_OUT_TB,Logic_Flag_TB,$time);
  else
    $display("****Test case 18 is FAILED, --ALU OUTPUT = %0d-- , Logic Flag = %0d at time = %0t",Logic_OUT_TB,Logic_Flag_TB,$time);
    
  A_TB = 'd7;
  B_TB = 'd5;  
  $display("****test case 19 --NAND--");
  #10
  ALU_FUN_TB = 4'b0110;
  #10
  if(Logic_OUT_TB == ~(A_TB & B_TB))
    $display("****Test case 19 is PASSED, --ALU OUTPUT = %0d ~& %0d = %0d-- , Logic Flag = %0d at time = %0t",A_TB,B_TB,Logic_OUT_TB,Logic_Flag_TB,$time);
  else
    $display("****Test case 19 is FAILED, --ALU OUTPUT = %0d-- , Logic Flag = %0d at time = %0t",Logic_OUT_TB,Logic_Flag_TB,$time);
    
  A_TB = 'd7;
  B_TB = 'd5;  
  $display("****test case 20 --NOR--");
  #10
  ALU_FUN_TB = 4'b0111;
  #10
  if(Logic_OUT_TB == ~(A_TB | B_TB))
    $display("****Test case 20 is PASSED, --ALU OUTPUT = %0d ~| %0d = %0d-- , Logic Flag = %0d at time = %0t",A_TB,B_TB,Logic_OUT_TB,Logic_Flag_TB,$time);
  else
    $display("****Test case 20 is FAILED, --ALU OUTPUT = %0d-- , Logic Flag = %0d at time = %0t",Logic_OUT_TB,Logic_Flag_TB,$time);
    
  A_TB = 'd7;
  B_TB = 'd5;
  $display("****test case 21 --A=B--");
  #10
  ALU_FUN_TB = 4'b1001;
  #10
  if(A_TB == B_TB)
    begin
      if(CMP_OUT_TB == 1)
        $display("****Test case 21 is PASSED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
      else
        $display("****Test case 21 is FAILED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
    end
    
  else
    begin
      if(CMP_OUT_TB == 0)
        $display("****Test case 21 is PASSED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
      else
        $display("****Test case 21 is FAILED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
    end
    
  A_TB = 'd7;
  B_TB = 'd5;
  $display("****test case 22 --A>B--");
  #10
  ALU_FUN_TB = 4'b1010;
  #10
  if(A_TB > B_TB)
    begin
      if(CMP_OUT_TB == 2)
        $display("****Test case 22 is PASSED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
      else
        $display("****Test case 22 is FAILED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
    end
    
  else
    begin
      if(CMP_OUT_TB == 0)
        $display("****Test case 22 is PASSED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
      else
        $display("****Test case 22 is FAILED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
    end
    
  A_TB = 'd7;
  B_TB = 'd5;
  $display("****test case 23 --A<B--");
  #10
  ALU_FUN_TB = 4'b1011;
  #10
  if(A_TB < B_TB)
    begin
      if(CMP_OUT_TB == 3)
        $display("****Test case 23 is PASSED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
      else
        $display("****Test case 23 is FAILED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
    end
    
  else
    begin
      if(CMP_OUT_TB == 0)
        $display("****Test case 23 is PASSED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
      else
        $display("****Test case 23 is FAILED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time = %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
    end
    
  A_TB = 'd4;
  $display("****test case 24 --A shift right--");
  #10
  ALU_FUN_TB = 4'b1100;
  #10
  if(SHIFT_OUT_TB == (A_TB>>1))
    $display("****Test case 24 is PASSED, --ALU OUTPUT = %0d-- , Shift Flag = %0d at time = %0t",SHIFT_OUT_TB,SHIFT_Flag_TB,$time);
  else
    $display("****Test case 24 is FAILED, --ALU OUTPUT = %0d-- , Shift Flag = %0d at time = %0t",SHIFT_OUT_TB,SHIFT_Flag_TB,$time);
  
  A_TB = 'd4;
  $display("****test case 25 --A shift left--");
  #10
  ALU_FUN_TB = 4'b1101;
  #10
  if(SHIFT_OUT_TB == (A_TB<<1))
    $display("****Test case 25 is PASSED, --ALU OUTPUT = %0d-- , Shift Flag = %0d at time = %0t",SHIFT_OUT_TB,SHIFT_Flag_TB,$time);
  else
    $display("****Test case 25 is FAILED, --ALU OUTPUT = %0d-- , Shift Flag = %0d at time = %0t",SHIFT_OUT_TB,SHIFT_Flag_TB,$time);
    
  B_TB = 'd2;
  $display("****test case 26 --B shift right--");
  #10
  ALU_FUN_TB = 4'b1110;
  #10
  if(SHIFT_OUT_TB == (B_TB>>1))
    $display("****Test case 26 is PASSED, --ALU OUTPUT = %0d-- , Shift Flag = %0d at time = %0t",SHIFT_OUT_TB,SHIFT_Flag_TB,$time);
  else
    $display("****Test case 26 is FAILED, --ALU OUTPUT = %0d-- , Shift Flag = %0d at time = %0t",SHIFT_OUT_TB,SHIFT_Flag_TB,$time);
    
  B_TB = 'd2;
  $display("****test case 27 --B shift left--");
  #10
  ALU_FUN_TB = 4'b1111;
  #10
  if(SHIFT_OUT_TB == (B_TB<<1))
    $display("****Test case 27 is PASSED, --ALU OUTPUT = %0d-- , Shift Flag = %0d at time = %0t",SHIFT_OUT_TB,SHIFT_Flag_TB,$time);
  else
    $display("****Test case 27 is FAILED, --ALU OUTPUT = %0d-- , Shift Flag = %0d at time = %0t",SHIFT_OUT_TB,SHIFT_Flag_TB,$time);
    
  $display("****test case 28 --NOP--");
  #10
  ALU_FUN_TB = 4'b1000;
  #10
  if(CMP_OUT_TB == 0)
    $display("****Test case 28 is PASSED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
  else
    $display("****Test case 28 is FAILED, --ALU OUTPUT = %0d-- , CMP Flag = %0d at time %0t",CMP_OUT_TB,CMP_Flag_TB,$time);
    
  $finish;
end

  
endmodule