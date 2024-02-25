`timescale 1us/1ns
module Register_File_8x16_TB ();
  //signal decleration
  reg WrEn_TB , RdEn_TB;
  reg CLK_TB,RST_TB;
  reg [2:0] Address_TB;
  reg [15:0] WrData_TB;
  wire [15:0] RdData_TB;
  
  //DUT instantiation
  Register_File_8x16 DUT(
  .WrEn(WrEn_TB),
  .RdEn(RdEn_TB),
  .CLK(CLK_TB),
  .RST(RST_TB),
  .Address(Address_TB),
  .WrData(WrData_TB),
  .RdData(RdData_TB)
  );
  
  //clock generator
  always #5 CLK_TB = ~CLK_TB;
  
  //initial block
  
  initial
  begin
    $dumpfile("Register_File_8x16_TB.vcd");
    $dumpvars;
    CLK_TB = 0;
    #10
    RST_TB = 0;
    #10
    RST_TB = 1;
    Address_TB = 3'b000;
    WrEn_TB = 0;
    RdEn_TB = 0;
    WrData_TB = 'd0;
    $display("****Test case 1****");
    #10
    WrEn_TB = 1;
    WrData_TB = 'd5;
    Address_TB = 3'b001;
    #10
    $display("****Test case 2****");
    Address_TB = 3'b010;
    WrData_TB = 'd7;
    WrEn_TB = 1;
    #10
    $display("****Test case 3****");
    Address_TB = 3'b001;
    WrEn_TB = 0;
    RdEn_TB = 1;
    #10
    if(RdData_TB == 'd5)
      $display("Test case 3 is PASSED");
    else
      $display("Test case 3 is FAILED");
      
    Address_TB = 3'b010;
    WrEn_TB = 0;
    RdEn_TB = 1;
    $display("Test case 4");
    #10
    if(RdData_TB == 'd7)
      $display("Test case 4 is PASSED");
    else
      $display("Test case 4 is FAILED");
      
    $finish;
    
  end
endmodule