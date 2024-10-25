## `sudo apt-get install libgtest-dev` only installs source files
*still required to compile the code to create the necessary library files using CMake*

`sudo apt-get install cmake # install cmake`<br>
`cd /usr/src/gtest`<br>
`sudo mkdir build`<br>
`cd build`<br>
`sudo cmake ..`<br>
`sudo make`<br>
`sudo make install`<br>

afterwards, run with the parameters:<br>
`-lgtest -lgtest_main -lpthread`

---

- is expected behaviour of rst meant to set sreg to 0b0000 or 0b0001? seems to assume 0b0001
- DUT test assumes perfect synchronous behaviour.
  - it is expecting rst to execute after one simulation cycle
  - however, it needs another eval() to execute the non-blocking assignments
  - though it may seem eval() is executed twice in the clk loop, it does not trigger the lfsr module during the second loop
  - it is in fact only dumping the simulation time, not any other variables (as there has been no change to top->clk)
  - the lfsr module is only triggered when `top->clk = !top->clk` is changing clk from 0 to 1. not when its changing from 1 to 0.
  - this is due to the `@ posedge clk` stimulus in lfsr.sv
<br>
- lfsr_7.sv needs module renaming to the same as the sv file name