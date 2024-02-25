module Arithmetic_block #(parameter IN_DATA_WIDTH = 16 , OP_DATA_WIDTH = 32) //parameter decleration
  (
  input wire signed [IN_DATA_WIDTH-1:0] A,
  input wire signed [IN_DATA_WIDTH-1:0] B,
  input wire [1:0] ALU_FUN,
  input wire Arith_EN,
  input wire clk,rst,
  output reg signed [OP_DATA_WIDTH-1:0] Arith_out,
  output reg Carry_Out,
  output reg Arith_Flag
  );     //(input/output) decleration as you can see the width of output is 2*width as we made an multplication process of A,B that have the same width

//variable deceleration
reg [2*IN_DATA_WIDTH:0] alu_out_comb;
reg Carry_Out_comb;
reg Arith_Flag_comb;

//sequential block
always @(posedge clk or negedge rst)
begin
  if(!rst)
    begin
      Arith_out <= 0;
      Carry_Out <= 0;
      Arith_Flag <= 0;
      
    end
  else
    begin
      Arith_out <= alu_out_comb;
      Carry_Out <= Carry_Out_comb;
      Arith_Flag <= Arith_Flag_comb;
    end
end

//combintional block 
always @(*)
begin
  Arith_Flag_comb = 0;
  if(Arith_EN)
    begin
      Arith_Flag_comb = 1'b1;
      case(ALU_FUN)
        2'b00 : begin
                  alu_out_comb = A+B;
                  Carry_Out_comb = alu_out_comb[IN_DATA_WIDTH];  
                end
        2'b01 : begin
                  alu_out_comb = A-B;
                  Carry_Out_comb = alu_out_comb[IN_DATA_WIDTH];  
                end
        2'b10 : begin
                  alu_out_comb = A*B;
                  Carry_Out_comb = alu_out_comb[IN_DATA_WIDTH];  
                end
        2'b11 : begin
                  alu_out_comb = A/B;
                  Carry_Out_comb = alu_out_comb[IN_DATA_WIDTH];  
                end
        default: {Carry_Out_comb , alu_out_comb} = 0;
      endcase
    end
  else 
    begin
      Carry_Out = 0;
      Arith_out = 0;
    end
end
endmodule
