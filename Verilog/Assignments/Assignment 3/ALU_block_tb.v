//timescale of 1 us with time precision of 1 ns
`timescale 1 us/1 ns   
module ALU_block_tb();
//signal decleration
reg [15:0] A_tb;
reg [15:0] B_tb;
reg clk_tb;
reg [3:0] ALU_FUN_tb;
wire [15:0] ALU_OUT_tb;
wire arith_flag_tb,logic_flag_tb,cmp_flag_tb,shift_flag_tb;

//DUT intantiation
ALU_block DUT(
.A (A_tb),
.B (B_tb),
.clk (clk_tb),
.ALU_FUN (ALU_FUN_tb),
.ALU_OUT (ALU_OUT_tb),
.arith_flag (arith_flag_tb),
.logic_flag (logic_flag_tb),
.cmp_flag (cmp_flag_tb),
.shift_flag (shift_flag_tb)
);

always #5 clk_tb = ~clk_tb ; //clock frequency 100 KHZ

//initial block
initial 
begin
  $dumpfile("ALU_block_tb.vcd");
  $dumpvars;
  clk_tb = 0;
  ALU_FUN_tb = 0;
  A_tb = 16'd20;
  B_tb = 16'd15;
  $display("testcase 1");
  #10
  ALU_FUN_tb = 0;
  #10
  if(ALU_OUT_tb == (A_tb + B_tb))
    $display("test case 1 is passed and the ALU output = %0d at time %0t and arithmetic flag is %0d",ALU_OUT_tb,$time,arith_flag_tb);
  else
    $display("test case 1 is failed");
    
  $display("test case 2");
  ALU_FUN_tb = 1;
  #10
  if(ALU_OUT_tb == (A_tb - B_tb))
    $display("test case 2 is passed and the ALU output = %0d at time %0t and arithmetic flag is %0d",ALU_OUT_tb,$time,arith_flag_tb);
  else
    $display("test case 2 is failed");
    
  $display("test case 3");
  ALU_FUN_tb = 2;
  #10
  if(ALU_OUT_tb == (A_tb * B_tb))
    $display("test case 3 is passed and the ALU output = %0d at time %0t and arithmetic flag is %0d",ALU_OUT_tb,$time,arith_flag_tb);
  else
    $display("test case 3 is failed");
    
  $display("test case 4");
  ALU_FUN_tb = 3;
  #10
  if(ALU_OUT_tb == (A_tb / B_tb))
    $display("test case 4 is passed and the ALU output = %0d at time %0t and arithmetic flag is %0d",ALU_OUT_tb,$time,arith_flag_tb);
  else
    $display("test case 4 is failed");
    
  $display("test case 5");
  ALU_FUN_tb = 4;
  #10
  if(ALU_OUT_tb == (A_tb & B_tb))
    $display("test case 5 is passed and the ALU output = %0d at time %0t and logic flag is %0d",ALU_OUT_tb,$time,logic_flag_tb);
  else
    $display("test case 5 is failed");
    
  $display("test case 6");
  ALU_FUN_tb = 5;
  #10
  if(ALU_OUT_tb == (A_tb | B_tb))
    $display("test case 6 is passed and the ALU output = %0d at time %0t and logic flag is %0d",ALU_OUT_tb,$time,logic_flag_tb);
  else
    $display("test case 6 is failed");
    
  $display("test case 7");
  ALU_FUN_tb = 6;
  #10
  if(ALU_OUT_tb == ~(A_tb & B_tb))
    $display("test case 7 is passed and the ALU output = %0d at time %0t and logic flag is %0d",ALU_OUT_tb,$time,logic_flag_tb);
  else
    $display("test case 7 is failed");
    
  $display("test case 8");
  ALU_FUN_tb = 7;
  #10
  if(ALU_OUT_tb == ~(A_tb | B_tb))
    $display("test case 8 is passed and the ALU output = %0d at time %0t and logic flag is %0d",ALU_OUT_tb,$time,logic_flag_tb);
  else
    $display("test case 8 is failed");
    
  $display("test case 9");
  ALU_FUN_tb = 8;
  #10
  if(ALU_OUT_tb == (A_tb ^ B_tb))
    $display("test case 9 is passed and the ALU output = %0d at time %0t and logic flag is %0d",ALU_OUT_tb,$time,logic_flag_tb);
  else
    $display("test case 9 is failed");
    
  $display("test case 10");
  ALU_FUN_tb = 9;
  #10
  if(ALU_OUT_tb == ~(A_tb ^ B_tb))
    $display("test case 10 is passed and the ALU output = %0d at time %0t and logic flag is %0d",ALU_OUT_tb,$time,logic_flag_tb);
  else
    $display("test case 10 is failed");
    
  $display("test case 11");
  ALU_FUN_tb = 10;
  #10
  if(A_tb == B_tb)
    begin
      if(ALU_OUT_tb == 1)
        $display("test case 11 is passed and the ALU output = %0d at time %0t and cmp flag is %0d",ALU_OUT_tb,$time,cmp_flag_tb);
      else
        $display("test case 11 is failed");
    end
    
  else
    begin
      if(ALU_OUT_tb == 0)
        $display("test case 11 is passed and the ALU output = %0d at time %0t and cmp flag is %0d",ALU_OUT_tb,$time,cmp_flag_tb);
      else
        $display("test case 11 is failed");
    end  
        
  $display("test case 12");
  ALU_FUN_tb = 11;
  #10
  if(A_tb > B_tb)
    begin
      if(ALU_OUT_tb == 2)
        $display("test case 12 is passed and the ALU output = %0d at time %0t and cmp flag is %0d",ALU_OUT_tb,$time,cmp_flag_tb);
      else
        $display("test case 12 is failed");
    end
    
  else
    begin
      if(ALU_OUT_tb == 0)
        $display("test case 12 is passed and the ALU output = %0d at time %0t and cmp flag is %0d",ALU_OUT_tb,$time,cmp_flag_tb);
      else
        $display("test case 12 is failed");
    end  
    
    
  $display("test case 13");
  ALU_FUN_tb = 12;
  #10
  if(A_tb < B_tb)
    begin
      if(ALU_OUT_tb == 3)
        $display("test case 13 is passed and the ALU output = %0d at time %0t and cmp flag is %0d",ALU_OUT_tb,$time,cmp_flag_tb);
      else
        $display("test case 13 is failed");
    end
    
  else
    begin
      if(ALU_OUT_tb == 0)
        $display("test case 13 is passed and the ALU output = %0d at time %0t and cmp flag is %0d",ALU_OUT_tb,$time,cmp_flag_tb);
      else
        $display("test case 13 is failed");
    end  
    
  $display("test case 14");
  ALU_FUN_tb = 13;
  #10
  if(ALU_OUT_tb == (A_tb>>1))
    $display("test case 14 is passed and the ALU output = %0d at time %0t and shift flag is %0d",ALU_OUT_tb,$time,shift_flag_tb);
  else
    $display("test case 14 is failed");
    
  $display("test case 15");
  ALU_FUN_tb = 14;
  #10
  if(ALU_OUT_tb == (A_tb << 1))
    $display("test case 15 is passed and the ALU output = %0d at time %0t and shift flag is %0d",ALU_OUT_tb,$time,shift_flag_tb);
  else
    $display("test case 15 is failed");
    
  $display("test case 16");
  ALU_FUN_tb = 15;
  #10
  if(ALU_OUT_tb == 0)
    $display("test case 16 is passed and the ALU output = %0d at time %0t",ALU_OUT_tb,$time,shift_flag_tb);
  else
    $display("test case 16 is failed");
  $finish;
end
endmodule