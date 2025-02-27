#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2024.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : AMD Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu Oct 10 18:01:14 -03 2024
# SW Build 5076996 on Wed May 22 18:36:09 MDT 2024
#
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim picoblaze_example_tb_behav -key {Behavioral:sim_1:Functional:picoblaze_example_tb} -tclbatch picoblaze_example_tb.tcl -view /home/lorenzo/Cont-Univ-PIcoBlaze/picoblaze_example_tb_behav.wcfg -log simulate.log"
xsim picoblaze_example_tb_behav -key {Behavioral:sim_1:Functional:picoblaze_example_tb} -tclbatch picoblaze_example_tb.tcl -view /home/lorenzo/Cont-Univ-PIcoBlaze/picoblaze_example_tb_behav.wcfg -log simulate.log

