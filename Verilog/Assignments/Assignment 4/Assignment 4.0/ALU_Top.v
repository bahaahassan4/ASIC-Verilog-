module ALU_Top #(parameter IN_DATA_WIDTH = 16 , OP_DATA_WIDTH = 32) //parameter decleration
(
input wire [IN_DATA_WIDTH-1:0] A,
input wire [IN_DATA_WIDTH-1:0] B,
input wire [3:0] ALU_FUN,
input wire clk,rst,
output wire [OP_DATA_WIDTH-1:0] Arith_OUT,
output wire Carry_OUT,
output wire Arith_Flag,
output wire [IN_DATA_WIDTH-1:0] Logic_OUT,
output wire Logic_Flag,
output wire [IN_DATA_WIDTH-1:0] CMP_OUT,
output wire CMP_Flag,
output wire [IN_DATA_WIDTH-1:0] SHIFT_OUT,
output wire SHIFT_Flag
);

//Define internal connections
wire ARITH_EN,LOGIC_EN,CMP_EN,SHIFT_EN;

//decoder block
Decoder_block U_Decoder_block(
.ALU_FUN(ALU_FUN[3:2]),
.Arith_EN(ARITH_EN),
.Logic_EN(LOGIC_EN),
.CMP_EN(CMP_EN),
.Shift_EN(SHIFT_EN)
);

//Arithmetic block
Arithmetic_block U_Arithmetic_block(
.A(A),
.B(B),
.ALU_FUN(ALU_FUN[1:0]),
.Arith_EN(ARITH_EN),
.clk(clk),
.rst(rst),
.Arith_out(Arith_OUT),
.Carry_Out(Carry_OUT),
.Arith_Flag(Arith_Flag)
);

//Logic block
Logic_block U_Logic_block(
.A(A),
.B(B),
.ALU_FUN(ALU_FUN[1:0]),
.Logic_EN(LOGIC_EN),
.clk(clk),
.rst(rst),
.Logic_OUT(Logic_OUT),
.Logic_Flag(Logic_Flag)
);

//CMP block
Cmp_block U_Cmp_block(
.A(A),
.B(B),
.ALU_FUN(ALU_FUN[1:0]),
.Cmp_EN(CMP_EN),
.clk(clk),
.rst(rst),
.Cmp_OUT(CMP_OUT),
.Cmp_Flag(CMP_Flag)
);

//Shift block
Shift_block U_Shift_block(
.A(A),
.B(B),
.ALU_FUN(ALU_FUN[1:0]),
.Shift_EN(SHIFT_EN),
.clk(clk),
.rst(rst),
.Shift_OUT(SHIFT_OUT),
.Shift_Flag(SHIFT_Flag)
);

endmodule