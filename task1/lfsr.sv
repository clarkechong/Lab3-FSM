module lfsr(
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [3:0] data_out
);

    logic [3:0] sreg;

    always_ff @ (posedge clk) begin

        if (rst) begin
            sreg <= {3'b0, 1'b1};
            // $display("reset block executed");
        end

        else if (en) begin
            // if sreg = 4'b0 then initiate shifting sequence with sreg[0] = 1
            // else if sreg != 4'b0 then shift as per normal operation with XOR
            if (sreg == 4'b0) sreg[0] <= en;

            else begin
                sreg[3] <= sreg[2];
                sreg[2] <= sreg[1];
                sreg[1] <= sreg[0];
                sreg[0] <= {sreg[3] ^ sreg[2]}; 
            end
        end
        assign data_out = sreg;
        // $display("rst = ", rst, ,"and sreg: ", sreg[3],sreg[2],sreg[1],sreg[0], " and dout: ", data_out[3],data_out[2],data_out[1],data_out[0]);
    end

endmodule
