rm -rf ./obj_dir/
verilator   -Wall --trace \
            -cc f1_fsm.sv \
            --exe f1_fsm_tb.cpp \
            --prefix "Vf1_fsm" \
            -o Vf1_fsm \

make -j -C obj_dir/ -f Vf1_fsm.mk

./obj_dir/Vf1_fsm
    