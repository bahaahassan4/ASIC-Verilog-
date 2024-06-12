module Serializer #(parameter OP_WIDTH = 8) //width is parameterized
(
    input  wire  [OP_WIDTH-1:0] P_DATA,
    input  wire                 ser_en,
    input  wire                 CLK,RST,
    output wire                  ser_done,
    output reg                  ser_data
);
//declare signals
integer             i;
reg [3:0]           counter;
wire                Count_max;
reg [OP_WIDTH-1:0]  P_DATA_shifted;
//sequential block
always @ (posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        //ser_done <= 'b0;
        ser_data <= 'b0;
        P_DATA_shifted <= P_DATA;
        counter <= 0;
    end
    else if(ser_en && !Count_max)
    begin
        /*for(i = 0;i < OP_WIDTH;i = i + 1)
        begin
            ser_done <= 'b0;
            @(negedge CLK)
            begin
            ser_data <= P_DATA[i];
            counter <= counter + 1;
            end
        end*/
        //ser_done <= 0;
        ser_data <= P_DATA_shifted[0];
        counter <= counter + 1;
        for(i=0;i<OP_WIDTH-1;i=i+1)
        begin
            P_DATA_shifted[i] <= P_DATA_shifted[i+1];
        end
        P_DATA_shifted[7] <= 'b0;
    end
    else if(ser_en && Count_max)
    begin
        //ser_done <= 'b1;
        counter <= 0;
        ser_data <= 0;
    end
    else
    begin
        ser_data <= 'b0;
        //ser_done <= 'b0;
        counter <= 0;
    end
end

assign Count_max = (counter == 'b1000);
assign ser_done = (counter == 'b1000);

endmodule
