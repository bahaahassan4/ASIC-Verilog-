`timescale 1us/1ns

module UART_TX_TB ();

//***********parameters************
parameter CLOCK_PERIOD = 1000/115.2;
parameter OP_WIDTH_TB = 8;

//**********signals**********
reg [OP_WIDTH_TB-1:0]   P_DATA_TB;
reg                     CLK_TB;
reg                     RST_TB;
reg                     PAR_EN_TB;
reg                     Data_Valid_TB;
reg                     PAR_TYP_TB;
wire                    TX_OUT_TB;
wire                    busy_TB;


//*********DUT instantiation***********
UART_TOP DUT
(
    .P_DATA(P_DATA_TB),
    .CLK(CLK_TB),
    .RST(RST_TB),
    .PAR_EN(PAR_EN_TB),
    .PAR_TYP(PAR_TYP_TB),
    .Data_Valid(Data_Valid_TB),
    .TX_OUT(TX_OUT_TB),
    .busy(busy_TB)
);


//********Clock generation*************
always  #(CLOCK_PERIOD/2) CLK_TB = ~CLK_TB;



//********initial block************
initial
begin

$dumpfile("UART_TX_TB.vcd");
$dumpvars;

initialize();
reset();
#(CLOCK_PERIOD)
read('h8F,1,0); //Parity enable (Even parity)
test('b11100011110);

read('b10101000,0,0); //No parity
test('b1101010000);

read('h8F,1,1); //Parity enable (Odd parity)
test('b10100011110);

Data_Valid_TB = 'b0;
#(3*CLOCK_PERIOD)
$finish;
end

//**********Tasks**************

//initialize
task initialize ;
begin
    Data_Valid_TB = 'b0;
    P_DATA_TB = 0;
    CLK_TB = 'b0;
    PAR_EN_TB = 'b0;
    PAR_TYP_TB = 'b0;
    RST_TB = 'b1;
end
endtask

//reset
task reset ;
begin
    RST_TB = 'b1;
    #(CLOCK_PERIOD)
    RST_TB = 'b0;
    #(CLOCK_PERIOD)
    RST_TB = 'b1;
end
endtask

//task begin reading
task read ;
input reg   [OP_WIDTH_TB-1:0]   data;
input reg                       par_en;
input reg                       par_typ;

begin
    Data_Valid_TB = 0;
    P_DATA_TB = data;
    PAR_EN_TB = par_en;
    PAR_TYP_TB = par_typ;
    reset();
    Data_Valid_TB = 'b1;
end
endtask

//task testing
task test ;
input      [10:0]   expec_out;
integer i;
integer j;
reg     [10:0]   gener_out1 ;
reg     [9:0]   gener_out2 ;
//reg     [10:0]   expec_out1 ;
//reg     [9:0]   expec_out2 ;
parameter       ZERO = 'b0;
parameter       ONE = 'b1;
begin
    if(Data_Valid_TB)
    begin
        //#(CLOCK_PERIOD)
        if(PAR_EN_TB)
        begin
            for (i = 0;i < 11;i = i + 1)
            begin
                #(CLOCK_PERIOD)
                gener_out1[i] = TX_OUT_TB;
            end
            //expec_out1 = {ZERO,P_DATA_TB,DUT.U_PARITY_CALC.par_bit,ONE};
            if(gener_out1 == expec_out )
            begin
                $display("Test case has succeeded");
            end
            else
            begin
                $display("Test case has failed");
            end
        end
        else
        begin
            for(j = 0;j < 10;j = j + 1)
            begin
                #(CLOCK_PERIOD) 
                gener_out2[j] = TX_OUT_TB;
            end
            if(gener_out2 == expec_out )
            begin
                $display("Test case has succeeded");
            end
            else
            begin
                $display("Test case has failed");
            end
        end
    end
    else
    begin
        for (i = 0;i < 11;i = i + 1)
        begin
            #(CLOCK_PERIOD) gener_out1[i] = TX_OUT_TB;
        end
        if(gener_out1 == 'b11111111111)
        begin
            $display("Test case has succeeded");
        end
        else
        begin
            $display("Test case has failed");
        end
    end
end
endtask

endmodule