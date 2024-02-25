//module decleration
module Up_Dn_Counter (
  input wire [4:0] in,
  input wire load,
  input wire up,
  input wire down,
  input wire clk,
  output reg [4:0] counter,
  output wire high,low);
  
  //variables
  reg [4:0] counter_comb;
  
  //Flipflop always block
  always @(posedge clk)
  begin
    counter <= counter_comb;
  end
  
  //Combintional logic always block
  always @(*)
  begin
    if(load)
      begin
        counter_comb = in;
      end
    else if(down && !low)
      begin
        counter_comb = counter - 5'b00001;
      end
    else if(up && !high)
      begin
        counter_comb = counter + 5'b00001;
      end
    else
      begin
        counter_comb = counter;
      end
  end
  
  assign high = (counter == 5'b11111);
  assign low = (counter == 5'b00000);
  
endmodule
