module sreg4 # (
    input logic clk,
    input logic rst,
    input logic data_in,
    output logic data_out
);
    logic [3:0] sreg;

    always_ff @ (posedge clk) begin
        if (rst) sreg <= 4'b0

        else begin
            sreg[3] <= sreg[2];
            sreg[2] <= sreg[1];
            sreg[1] <= sreg[0];
            sreg[0] <= data_in;
        end
        assign data_out sreg[3];
    end

endmodule
