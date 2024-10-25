#!/bin/bash

# execute within task/ directory

g++ -o main main.cpp -lgtest -lgtest_main -pthread
./main