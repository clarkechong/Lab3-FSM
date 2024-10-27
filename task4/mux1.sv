module mux1 #(
    parameter   DATA_WIDTH = 1
) (
    input logic [DATA_WIDTH-1:0] in1,
    input logic [DATA_WIDTH-1:0] in2,
    input logic sel,
    output logic dout
);

    assign dout = sel ? in2 : in1;
    
    // always @ (edge sel)
    //     $display(sel);

endmodule
