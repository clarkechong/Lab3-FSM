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
