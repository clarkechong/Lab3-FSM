module f1_trigger_light (
    input logic rst,
    input logic trigger,
    input logic clk,
    input logic [4:0] ntimer, // 1 second~ timer N

    output logic [7:0] data_out
);

    wire en_fsm;
    wire muxin1;
    wire muxin2;
    wire cmd_seq;
    wire cmd_delay;
    wire [6:0] delay_K; // wire from lfsr to delay.sv

    f1_fsm myf1fsm (
        .rst (rst),
        .trigger (trigger),
        .en (en_fsm),
        .clk (clk),
        .data_out (data_out),
        .cmd_seq (cmd_seq),
        .cmd_delay (cmd_delay)
    );

    mux1 mymux (
        .in1 (muxin1),
        .in2 (muxin2),
        .sel (cmd_seq),
        .dout (en_fsm)
    );

    clktick myclktick (
        .clk (clk),
        .rst (rst),
        .en (cmd_seq),
        .N (ntimer),
        .tick (muxin2)
    );

    delay mydelay (
        .clk (clk),
        .rst (rst),
        .trigger (cmd_delay),
        .n (delay_K),
        .time_out (muxin1)
    );

    lfsr_7 mylfsr7 (
        .clk (clk),
        .rst (rst),
        .en (clk),
        .data_out (delay_K)
    );

endmodule
