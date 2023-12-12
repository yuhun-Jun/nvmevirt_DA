#!/bin/bash

make clean
make APPROACH=off
cp nvmev.ko ../evaluation/nvmev_off.ko
 
make clean
make APPROACH=on
cp nvmev.ko ../evaluation/nvmev_on.ko
