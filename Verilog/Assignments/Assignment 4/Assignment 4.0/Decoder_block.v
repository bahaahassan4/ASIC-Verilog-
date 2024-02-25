module Decoder_block
  (
  input wire [1:0] ALU_FUN,
  output reg Arith_EN, Logic_EN, CMP_EN, Shift_EN
  );

//variable decleration


always@(*)
begin
  case(ALU_FUN)
    2'b00 : {Shift_EN,CMP_EN,Logic_EN,Arith_EN} = 4'b0001;
    2'b01 : {Shift_EN,CMP_EN,Logic_EN,Arith_EN} = 4'b0010;
    2'b10 : {Shift_EN,CMP_EN,Logic_EN,Arith_EN} = 4'b0100;
    2'b11 : {Shift_EN,CMP_EN,Logic_EN,Arith_EN} = 4'b1000;
    default : {Shift_EN,CMP_EN,Logic_EN,Arith_EN} = 4'b0000;
  endcase
end
endmodule