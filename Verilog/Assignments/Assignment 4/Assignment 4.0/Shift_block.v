module Shift_block #(parameter IN_DATA_WIDTH = 16 ) //parameter decleration
(
  input wire [IN_DATA_WIDTH-1:0] A,
  input wire [IN_DATA_WIDTH-1:0] B,
  input wire [1:0] ALU_FUN,
  input wire Shift_EN,
  input wire clk,rst,
  output reg [IN_DATA_WIDTH-1:0] Shift_OUT,
  output reg Shift_Flag
);
//variable decleration
reg [IN_DATA_WIDTH-1:0] shift_out_comb;
reg Shift_Flag_comb;


//sequential block
always@(posedge clk or negedge rst)
begin
  if(!rst)
    begin
      Shift_OUT <= 0;
      Shift_Flag <= 0;
    end
  else
    begin
      Shift_OUT <= shift_out_comb;
      Shift_Flag <= Shift_Flag_comb;
    end
end


//combintional block

always @(*)
begin
  Shift_Flag_comb  = 0;
  if(Shift_EN)
    begin
      Shift_Flag_comb = 'b1;
      case(ALU_FUN)
        2'b00 : shift_out_comb = A>>1;
        2'b01 : shift_out_comb = A<<1;
        2'b10 : shift_out_comb = B>>1;
        2'b11 : shift_out_comb = B<<1;
        default : shift_out_comb = 0;
      endcase
    end
  else
    begin
     shift_out_comb = 0; 
    end
end
endmodule


