rm -rf ./obj_dir/

# run Verilator to translate Verilog into C++, including C++ testbench
verilator -Wall --cc --trace f1_fsm_timer.sv f1_fsm.sv clktick.sv --exe f1_fsm_timer_tb.cpp

# build C++ project via make automatically generated by Verilator
make -j -C ./obj_dir/ -f Vf1_fsm_timer.mk Vf1_fsm_timer

# run executable simulation file
echo "\nRunning simulation"
obj_dir/Vf1_fsm_timer
echo "\nSimulation completed"
