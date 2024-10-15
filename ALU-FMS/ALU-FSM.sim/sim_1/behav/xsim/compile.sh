#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2024.1 (64-bit)
#
# Filename    : compile.sh
# Simulator   : AMD Vivado Simulator
# Description : Script for compiling the simulation design source files
#
# Generated by Vivado on Thu Sep 12 18:02:13 -03 2024
# SW Build 5076996 on Wed May 22 18:36:09 MDT 2024
#
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
#
# usage: compile.sh
#
# ****************************************************************************
set -Eeuo pipefail
# compile VHDL design sources
echo "xvhdl --incr --relax -prj alu_fsm_top_test_vhdl.prj"
xvhdl --incr --relax -prj alu_fsm_top_test_vhdl.prj 2>&1 | tee compile.log

echo "Waiting for jobs to finish..."
echo "No pending jobs, compilation finished."
