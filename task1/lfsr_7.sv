module lfsr_7 (
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [6:0] data_out
);

    logic [6:0] sreg;

    always_ff @ (posedge clk) begin

        if (rst) begin
            sreg <= {6'b0, 1'b1};
        end

        else if (en) begin
            if (sreg == 7'b0) sreg[0] <= en;

            else begin
                for(int i = 6; i > 0; i--) begin
                    sreg[i] <= sreg[i-1];
                end
                sreg[0] <= {sreg[6] ^ sreg[2]};
            end
        end
        assign data_out = sreg;
        $display("rst = ", rst, ,"and sreg: ", sreg[6], sreg[5], sreg[4], sreg[3], sreg[2], sreg[1], sreg[0]);
    end

endmodule
