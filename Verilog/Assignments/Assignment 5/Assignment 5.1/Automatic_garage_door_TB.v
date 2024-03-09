`timescale 1ns/1ps

module Automatic_garage_door_TB ();

//******parameter decleration******
parameter CLOCK_PERIOD = 20;

//******DUT Signals*******
reg     UP_Max_TB;
reg     DN_Max_TB;
reg     Activate_TB;
reg     CLK_TB;
reg     RST_TB;
wire    UP_M_TB;
wire    DN_M_TB;

//******DUT instantiation*******
Automatic_garage_door DUT (
    .UP_Max(UP_Max_TB),
    .DN_Max(DN_Max_TB),
    .Activate(Activate_TB),
    .CLK(CLK_TB),
    .RST(RST_TB),
    .UP_M(UP_M_TB),
    .DN_M(DN_M_TB)
);

//*****CLOCK generation******
always #(CLOCK_PERIOD/2) CLK_TB =~CLK_TB;

//*****initial block******
initial
begin
    //system functions
    $dumpfile("Automatic_garage_door_TB.vcd");
    $dumpvars;
    //initialize
    initialize();
    //reset
    reset();
    //testcases
    Activate_TB = 'b1;
    UP_Max_TB = 'b1;
    DN_Max_TB = 'b0;
    #CLOCK_PERIOD
    if(UP_M_TB==0 && DN_M_TB==1)
    begin
        $display("test case 1 is successed");
    end
    else
    begin
        $display("test case 1 is failed");
    end
    DN_Max_TB = 'b1;
    #CLOCK_PERIOD
    Activate_TB = 'b1;
    UP_Max_TB = 'b0;
    DN_Max_TB = 'b1;
    #CLOCK_PERIOD
    if(UP_M_TB == 1 && DN_M_TB == 0)
    begin
        $display("test case 2 is successed");
    end
    else
    begin
        $display("test case 2 is failed");
    end
    UP_Max_TB = 'b1;
    #CLOCK_PERIOD
    $finish;
end


//******Tasks*******
task initialize;
begin
    CLK_TB = 'b0;
    Activate_TB = 'b0;
    UP_Max_TB = 'b0;
    DN_Max_TB = 'b0;
    RST_TB = 'b1;
end
endtask

task reset;
begin
    RST_TB = 'b1;
    #(CLOCK_PERIOD)
    RST_TB = 'b0;
    #(CLOCK_PERIOD)
    RST_TB = 'b1;
end
endtask

endmodule
