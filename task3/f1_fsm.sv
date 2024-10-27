module f1_fsm (
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [7:0] data_out
);

    reg [7:0] state;
    reg [7:0] nextstate;

    localparam s0 = 8'b0;
    localparam s1 = 8'b1;
    localparam s2 = 8'b11;
    localparam s3 = 8'b111;
    localparam s4 = 8'b1111;
    localparam s5 = 8'b11111;
    localparam s6 = 8'b111111;
    localparam s7 = 8'b1111111;
    localparam s8 = 8'b11111111;

    always @ (posedge clk) begin
        if (rst) begin
            state <= s0;
            nextstate <= s1;
        end
        else if (en) begin
            // $display("state: ", state, " next state: ", nextstate);
            state <= nextstate;
            case (nextstate)
                s0: nextstate <= s1;
                s1: nextstate <= s2;
                s2: nextstate <= s3;
                s3: nextstate <= s4;
                s4: nextstate <= s5;
                s5: nextstate <= s6;
                s6: nextstate <= s7;
                s7: nextstate <= s8;
                s8: nextstate <= s0;
                default: nextstate <= 0;
            endcase
        end
    end
    assign data_out = state;

endmodule
