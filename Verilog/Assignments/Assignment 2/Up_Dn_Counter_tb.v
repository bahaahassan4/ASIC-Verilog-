`timescale 1ns/1ps
module Up_Dn_Counter_tb ();
//declare testbench signals
  reg [4:0] in_tb;
  reg load_tb;
  reg up_tb;
  reg down_tb;
  reg clk_tb;
  wire [4:0] counter_tb;
  wire high_tb,low_tb;
  
//DUT instantiation
  Up_Dn_Counter DUT(  
  .in (in_tb),
  .load (load_tb),
  .up (up_tb),
  .down (down_tb),
  .clk (clk_tb),
  .counter (counter_tb),
  .high (high_tb),
  .low (low_tb)
  );
  
//clock generator
  always #5 clk_tb = ~clk_tb ;  // clock frequency 100 MHZ
  
//initial block
  initial
  begin
    $dumpfile("Up_Dn_Counter.vcd");
    $dumpvars;
    clk_tb = 1'b0;
    up_tb = 1'b0;
    down_tb = 1'b0;
    load_tb = 1'b0;
    in_tb = 5'b01010;
    $display("test case 1"); //testing the load flag
    #10
    load_tb = 1'b1;
    #10
    if (counter_tb == 5'b01010)
      $display ("test case 1 is passed and the counter = %0d at time",counter_tb,$time);
    else
      $display ("test case 1 is failed and the counter = %0d at time",counter_tb,$time);
    $display("test case 2"); //testing priority of the load flag
    load_tb = 1'b1;
    up_tb = 1'b1;
    #10
    if (counter_tb == 5'b01010)
      $display ("test case 2 is passed and the counter = %0d at time",counter_tb,$time);
    else
      $display ("test case 2 is failed and the counter = %0d at time",counter_tb,$time);
    $display("test case 3"); //testing up flag
    load_tb = 1'b0;
    up_tb = 1'b1;
    #40
    if (counter_tb == 5'b01110) 
      $display ("test case 3 is passed and the counter = %0d at time",counter_tb,$time);
    else
      $display ("test case 3 is failed and the counter = %0d at time",counter_tb,$time);
    $display("test case 4"); //testing down flag and it's priority and low flag is up when counter reaches 0 and stops
    load_tb = 1'b0;
    up_tb = 1'b0;
    down_tb = 1'b1;
    #150
    if ((counter_tb == 5'b00000) && low_tb)
      $display ("test case 4 is passed and the counter = %0d and low flag is equal to %0b at time",counter_tb,low_tb,$time);
    else
      $display ("test case 4 is failed and the counter = %0d at time",counter_tb,$time);
    $display("test case 5"); //testing high flag when counter reaches 31 and stops 
    load_tb = 1'b0;
    down_tb = 1'b0;
    up_tb = 1'b1;
    #320
    if ((counter_tb == 5'b11111) && high_tb)
      $display ("test case 5 is passed and the counter = %0d and high flag is equal to %0b at time",counter_tb,high_tb,$time);
    else
      $display ("test case 5 is failed and the counter = %0d at time",counter_tb,$time);
    $display("test case 6"); //priority of load over up and down flag
    load_tb = 1;
    up_tb = 1;
    down_tb = 1;
    #20
    if (counter_tb == 5'b01010)
      $display("test case 6 is passed and the counter = %0d at time",counter_tb,$time);
    else
      $display ("test case 6 is failed and the counter = %0d at time",counter_tb,$time);
    $display("test case 7"); //testing priority of down signal over up signal
    load_tb = 0;
    up_tb = 1;
    down_tb = 1;
    #10
    if (counter_tb == 5'b01001)
      $display("test case 7 is passed and the counter = %0d at time",counter_tb,$time);
    else
      $display ("test case 7 is failed and the counter = %0d at time",counter_tb,$time);
    end
  endmodule