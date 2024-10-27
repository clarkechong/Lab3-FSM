#include "./obj_dir/Vf1_fsm.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "../vbuddy.cpp"

int main(int argc, char** argv, char** env) {

    Verilated::commandArgs(argc, argv);

    Vf1_fsm* top = new Vf1_fsm;
    VerilatedVcdC* tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    top->trace(tfp, 99);
    tfp->open("Vf1_fsm.vcd");

    if(vbdOpen() != 1) return (-1);
    vbdHeader("waddup mf");
    vbdSetMode(1);

    for (int i=0; i<100000; i++) {
        for (int clk=0; clk<2; clk++){
            tfp->dump (2*i+clk);
            top->clk = !top->clk;
            top->eval ();
        }
        top->en = vbdFlag();
        vbdBar(top->data_out & 0xFF);
        vbdCycle(i);

        if(Verilated::gotFinish()) exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}