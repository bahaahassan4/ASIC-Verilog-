//module decleration
module ALU_block(
  input wire [7:0] A,
  input wire [7:0] B,
  input wire [3:0] ALU_FUN,
  input wire clk,
  output reg [15:0] ALU_OUT,
  output reg arith_flag,logic_flag,cmp_flag,shift_flag
  );
  
  //variables
  reg [15:0] alu_out_comb;
  
  //always block for flipflop
  always @(posedge clk)
  begin
    ALU_OUT <= alu_out_comb;
  end
  
  //always block for combintional circuit
  always @(*)
  begin
    arith_flag = 0; 
    logic_flag = 0;
    cmp_flag = 0;
    shift_flag = 0;
    case(ALU_FUN)
      4'b0000: begin
        alu_out_comb = A + B;
        arith_flag = 1'b1;
      end
      4'b0001: begin
        alu_out_comb = A - B;
        arith_flag = 1'b1;
      end
      4'b0010: begin
        alu_out_comb = A*B;
        arith_flag = 1'b1;
      end
      4'b0011: begin
        alu_out_comb = A/B;
        arith_flag = 1'b1;
      end
      4'b0100:begin
        alu_out_comb = A&B;
        logic_flag = 1'b1;
      end
      4'b0101:begin
        alu_out_comb = A|B;
        logic_flag = 1'b1;
      end
      4'b0110:begin
        alu_out_comb = ~(A&B);
        logic_flag = 1'b1;
      end
      4'b0111:begin
        alu_out_comb = ~(A|B);
        logic_flag = 1'b1;
      end
      4'b1000:begin
        alu_out_comb = A^B;
        logic_flag = 1'b1;
      end
      4'b1001:begin
        alu_out_comb = A~^B;
        logic_flag = 1'b1;
      end
      4'b1010:begin
        alu_out_comb = (A == B)?1:0;
        cmp_flag = 1'b1;
      end
      4'b1011:begin
        alu_out_comb = (A>B)?2:0;
        cmp_flag = 1'b1;
      end
      4'b1100:begin
        alu_out_comb = (A<B)?3:0;
        cmp_flag = 1'b1;
      end
      4'b1101:begin
        alu_out_comb = A>>1;
        shift_flag = 1'b1;
      end
      4'b1110:begin
        alu_out_comb = A<<1;
        shift_flag = 1'b1;
      end
      default:alu_out_comb = 16'b0;
    endcase
  end
  
endmodule