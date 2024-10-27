rm -rf ./obj_dir/
verilator   -Wall --trace \
            -cc ./*.sv \
            --exe f1_trigger_light_tb.cpp \
            --prefix "Vf1_trigger_light" \
            -o Vf1_trigger_light \

make -j -C obj_dir/ -f Vf1_trigger_light.mk

./obj_dir/Vf1_trigger_light
    