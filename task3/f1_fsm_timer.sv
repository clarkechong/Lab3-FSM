module f1_fsm_timer #(
    parameter WIDTH = 16
) (
    input  logic            clk,
    input  logic            rst,
    input  logic            en, 
    input  logic [WIDTH-1:0] N, 
    output  logic [7:0] data_out
);

    wire driveFSM;

clktick myclktick (
    .clk (clk),
    .rst (rst),
    .en (en),
    .N (N),
    .tick (driveFSM)
);

f1_fsm myf1_fsm (
    .clk (clk),
    .rst (rst),
    .en (driveFSM),
    .data_out (data_out)
);

endmodule
