#!/bin/bash

gcc -shared -o 11.so 22.s
icx 11.cpp -lstdc++   -o test -std=c++17
