#!/usr/bin/env bash

docker run --rm -it \
    -v $(pwd)/3rdparty/pico-sdk:/pico-sdk \
    -v $(pwd):/project \
    xingrz/rpi-pico-builder:latest \
    bash -c 'mkdir -p build && cd build && cmake -DPICO_BOARD=bbq20kbd_breakout -DCMAKE_BUILD_TYPE=Debug .. && make clean && make && cp app/i2c_puppet.uf2 .'