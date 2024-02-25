module Logic_block #(parameter IN_DATA_WIDTH = 16 ) //parameter decleration
(
  input wire [IN_DATA_WIDTH-1:0] A,
  input wire [IN_DATA_WIDTH-1:0] B,
  input wire [1:0] ALU_FUN,
  input wire Logic_EN,
  input wire clk,rst,
  output reg [IN_DATA_WIDTH-1:0] Logic_OUT,
  output reg Logic_Flag
);
//variable decleration
reg [IN_DATA_WIDTH-1:0] logic_out_comb;
reg Logic_Flag_comb;


//sequential block
always@(posedge clk or negedge rst)
begin
  if(!rst)
    begin
      Logic_OUT <= 0;
      Logic_Flag <= 0;
    end
  else
    begin
      Logic_OUT <= logic_out_comb;
      Logic_Flag <= Logic_Flag_comb;
    end
end


//combintional block

always @(*)
begin
  Logic_Flag_comb  = 0;
  if(Logic_EN)
    begin
      Logic_Flag_comb = 'b1;
      case(ALU_FUN)
        2'b00 : logic_out_comb = A & B;
        2'b01 : logic_out_comb = A | B;
        2'b10 : logic_out_comb = ~(A&B);
        2'b11 : logic_out_comb = ~(A|B);
        default : logic_out_comb = 0;
      endcase
    end
  else
    begin
     logic_out_comb = 0; 
    end
end
endmodule