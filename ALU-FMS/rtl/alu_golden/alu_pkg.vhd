----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: ALU package
--
-- Dependencies: None.
--
-- Revision: 2023-09-04
-- Additional Comments:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package alu_pkg is

  constant NUM_OPS : natural := 4;
  subtype op_sel_t is std_logic_vector(1 downto 0);
  constant POS_ADD : natural := 0;
  constant POS_SUB : natural := 1;
  constant POS_MUL : natural := 2;
  constant POS_EQ : natural := 3;

  constant N_IN : natural := 5;
  subtype signed_op_t is signed(N_IN - 1 downto 0);
  subtype signed_result_t is signed(2 * N_IN - 1 downto 0);
  type result_array_t is array (0 to NUM_OPS - 1) of signed_result_t;
  constant N_OUT : natural := 6;
  subtype signed_output_t is signed(N_OUT - 1 downto 0);

end package alu_pkg;
