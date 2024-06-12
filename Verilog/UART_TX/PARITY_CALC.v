module PARITY_CALC #(parameter OP_WIDTH = 8)
(
    input   wire   [OP_WIDTH-1:0]   P_DATA,
    input   wire                    Data_Valid,
    input   wire                    PAR_TYP,
    output  reg                     par_bit 
);
always @ (*)
begin
    if(Data_Valid && !PAR_TYP)     //even parity
    begin
        par_bit = ^P_DATA;
    end
    else if(Data_Valid && PAR_TYP)  //odd parity
    begin
        par_bit = ~^P_DATA;
    end
    else
    begin
        par_bit = 'b0;
    end
end
endmodule