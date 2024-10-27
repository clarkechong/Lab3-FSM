#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vf1_trigger_light.h"

#include "../vbuddy.cpp" // include vbuddy code
#define MAX_SIM_CYC 100000

int bin2bcd(int binaryInput){
   int bcdResult = 0;
   int shift = 0;
   while (binaryInput > 0) {
      bcdResult |= (binaryInput % 10) << (shift++ << 2);
      binaryInput /= 10;
   }
    return bcdResult;
}

int main(int argc, char **argv, char **env)
{
    int simcyc;     // simulation clock count
    int tick;       // each clk cycle has two ticks for two edges
    bool seqEnded = 1;
    // int lights = 0; // state to toggle LED lights

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vf1_trigger_light *top = new Vf1_trigger_light;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("waveform.vcd");

    // init Vbuddy
    if (vbdOpen() != 1)
        return (-1);
    vbdHeader("RAWWWWWRR");
    vbdSetMode(1); // Flag mode set to one-shot

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 0;

    // run simulation for MAX_SIM_CYC clock cycles
    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++)
    {
        // dump variables into VCD file and toggle clock
        for (tick = 0; tick < 2; tick++)
        {
            tfp->dump(2 * simcyc + tick);
            top->clk = !top->clk;
            top->eval();
        }

        top->trigger = vbdFlag();
        top->rst = (simcyc < 2);
        top->ntimer = vbdValue(); // N = 29 gives approx 1 second

        vbdBar(top->data_out & 0xFF);
        vbdCycle(simcyc);

        if((top->data_out == 0x00) != seqEnded){ // if seq ended transitioned but not yet detected, and not upon startup
            if (!seqEnded) { // if seq ended but seqEnded still 0
                vbdInitWatch();
                while (!seqEnded) {
                    if (vbdFlag()){
                        seqEnded = true;
                        cout << "time elapsed: " << vbdElapsed() << " ms" << std::endl;
                        int elapsedBCD = bin2bcd(int(vbdElapsed()));
                        vbdHex(4, (int(elapsedBCD) >> 16) & 0xF);
                        vbdHex(3, (int(elapsedBCD) >> 8) & 0xF);
                        vbdHex(2, (int(elapsedBCD) >> 4) & 0xF);
                        vbdHex(1, int(elapsedBCD) & 0xF);
                    }
                }
            }
            else if (seqEnded) seqEnded = false;
        }

        if (Verilated::gotFinish())
            exit(0);
    }

    vbdClose(); // ++++
    tfp->close();
    exit(0);
}
