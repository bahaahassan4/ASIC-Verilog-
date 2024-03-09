module LFSR #(parameter OP_WIDTH = 8) (
input 	wire					ACTIVE,CLK,RST,
input 	wire 	[OP_WIDTH-1:0]	DATA,  
output 	reg						CRC,Valid
);


reg	[OP_WIDTH-1:0] 	LFSR;    //declare 8 bits register
reg 			 	data;
reg [OP_WIDTH-1:0] DATA_SHIFTED;  //used to shift data bits

always @ (posedge CLK or negedge RST)
begin
	if (!RST)
	begin
		LFSR <= 8'hD8 ;  //seed value
		Valid <= 1'b0;
		CRC <= 1'b0;
		data <= DATA[0];
		DATA_SHIFTED[0] <= DATA[1];
		DATA_SHIFTED[1] <= DATA[2];
		DATA_SHIFTED[2] <= DATA[3];
		DATA_SHIFTED[3] <= DATA[4];
		DATA_SHIFTED[4] <= DATA[5];
		DATA_SHIFTED[5] <= DATA[6];
		DATA_SHIFTED[6] <= DATA[7];
		DATA_SHIFTED[7] <= 'b0;
	end
	else if (ACTIVE)
	begin
		LFSR[7] <= LFSR[0] ^ data;
		LFSR[6] <= (LFSR[0] ^ data) ^ LFSR[7];
		LFSR[5] <= LFSR[6];
		LFSR[4] <= LFSR[5];
		LFSR[3] <= LFSR[4];
		LFSR[2] <= (LFSR[0] ^ data) ^ LFSR[3];
		LFSR[1] <= LFSR[2];
		LFSR[0] <= LFSR[1];
		data <= DATA_SHIFTED[0];
		DATA_SHIFTED[0] <= DATA_SHIFTED[1];
		DATA_SHIFTED[1] <= DATA_SHIFTED[2];
		DATA_SHIFTED[2] <= DATA_SHIFTED[3];
		DATA_SHIFTED[3] <= DATA_SHIFTED[4];
		DATA_SHIFTED[4] <= DATA_SHIFTED[5];
		DATA_SHIFTED[5] <= DATA_SHIFTED[6];
		DATA_SHIFTED[6] <= DATA_SHIFTED[7];
		DATA_SHIFTED[7] <= 'b0;
	end
	else
	begin    //shift the LFSR and output CRC
		Valid <= 1'b1;
		//{LFSR[6:0],CRC} = LFSR;
		CRC <= LFSR[0];
		LFSR[0] <= LFSR[1];
		LFSR[1] <= LFSR[2];
		LFSR[2] <= LFSR[3];
		LFSR[3] <= LFSR[4];
		LFSR[4] <= LFSR[5];
		LFSR[5] <= LFSR[6];
		LFSR[6] <= LFSR[7];
		LFSR[7] <= 1'b0;
	end
end

endmodule

	

