module Cmp_block #(parameter IN_DATA_WIDTH = 16 ) //parameter decleration
(
  input wire [IN_DATA_WIDTH-1:0] A,
  input wire [IN_DATA_WIDTH-1:0] B,
  input wire [1:0] ALU_FUN,
  input wire Cmp_EN,
  input wire clk,rst,
  output reg [IN_DATA_WIDTH-1:0] Cmp_OUT,
  output reg Cmp_Flag
);

//variable decleration
reg [IN_DATA_WIDTH-1:0] cmp_out_comb;
reg Cmp_Flag_comb;


//sequential block
always@(posedge clk or negedge rst)
begin
  if(!rst)
    begin
      Cmp_OUT <= 0;
      Cmp_Flag <= 0;
    end
  else
    begin
      Cmp_OUT <= cmp_out_comb;
      Cmp_Flag <= Cmp_Flag_comb;  
    end
end

//combintional block
always@(*)
begin
  Cmp_Flag_comb = 0;
  if(Cmp_EN)
    begin
      Cmp_Flag_comb = 1'b1;
      case(ALU_FUN)
        2'b00: cmp_out_comb = 0;
        2'b01: cmp_out_comb = (A == B)?1:0;
        2'b10: cmp_out_comb = (A > B)?2:0;
        2'b11: cmp_out_comb = (A < B)?3:0;
        default: cmp_out_comb = 0;
      endcase
    end
  else
    begin
      cmp_out_comb = 0;
    end
end
endmodule