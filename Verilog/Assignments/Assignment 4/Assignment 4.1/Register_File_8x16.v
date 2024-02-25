module Register_File_8x16(
  input wire WrEn,RdEn,
  input wire CLK,RST,
  input wire [15:0] WrData,
  input wire [2:0] Address,
  output reg [15:0] RdData
  );

//variable decleration
reg [15:0] memory [7:0];

always @(posedge CLK or negedge RST)
begin
  if(!RST)
    begin
      memory[0] <= 16'b0;
      memory[1] <= 16'b0;
      memory[2] <= 16'b0;
      memory[3] <= 16'b0;
      memory[4] <= 16'b0;
      memory[5] <= 16'b0;
      memory[6] <= 16'b0;
      memory[7] <= 16'b0;
      RdData <= 0;
    end
  else
    begin
      if(WrEn)
        begin
          memory[Address] <= WrData;
        end
      else if(RdEn && !WrEn)
        begin
          RdData <= memory[Address];
        end
      else
        begin
          RdData <= 0;
        end
      
    end
  
end
endmodule