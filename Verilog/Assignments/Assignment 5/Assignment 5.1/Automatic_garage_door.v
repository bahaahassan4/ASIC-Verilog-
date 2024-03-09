module Automatic_garage_door (
    input   wire    UP_Max,
    input   wire    DN_Max,
    input   wire    Activate,
    input   wire    CLK,
    input   wire    RST,
    output  reg    UP_M,
    output  reg    DN_M
);

//state encoding
localparam  IDLE = 2'b00,
            Mv_Dn = 2'b01,
            Mv_Up = 2'b11;

//state variables
reg [1:0]   current_state,next_state;

//sequential always
always @(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        current_state <= IDLE;
    end
    else
    begin
        current_state <= next_state;
    end
end

//states combintional block
always @(*)
begin
    case(current_state)
    IDLE:begin
            if(Activate && UP_Max && !DN_Max)
            begin
                next_state = Mv_Dn;
            end
            else if(Activate && DN_Max && !UP_Max)
            begin
                next_state = Mv_Up;
            end
            else
            begin
                next_state = IDLE;
            end
        end
    Mv_Dn:begin
            if(DN_Max)
            begin
                next_state = IDLE;
            end
            else
            begin
                next_state = Mv_Dn;
            end
        end
    Mv_Up:begin
            if(UP_Max)
            begin
                next_state = IDLE;
            end
            else
            begin
                next_state = Mv_Up;
            end
        end
    default:begin
            next_state = IDLE;
            end
    endcase
end

//OUTPUT combintional block
always @(*)
begin
    UP_M = 'b0;
    DN_M = 'b0;
    case(current_state)
    IDLE:begin
            UP_M = 'b0;
            DN_M = 'b0;
        end
    Mv_Dn:begin
            UP_M = 'b0;
            DN_M = 'b1;
        end
    Mv_Up:begin
            UP_M = 'b1;
            DN_M = 'b0;
        end
    default:begin
            UP_M = 'b0;
            DN_M = 'b0;
        end
    endcase
end
endmodule
