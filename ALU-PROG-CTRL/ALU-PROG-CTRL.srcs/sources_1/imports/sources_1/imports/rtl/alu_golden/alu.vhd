----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: ALU
--
-- Dependencies: None.
--
-- Revision: 2024-09-09
-- Additional Comments:
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_pkg.all;

entity alu is
  port (
    op0_in     : in signed_op_t;
    op1_in     : in signed_op_t;
    result_out : out result_array_t
  );
end entity alu;

architecture rtl of alu is
  signal op0_ext : signed_result_t;
  signal op1_ext : signed_result_t;
  signal op0_eq_op1 : std_logic;

begin
  op0_ext(2 * N_IN - 1 downto N_IN) <= (others => op0_in(N_IN - 1));
  op0_ext(N_IN - 1 downto 0) <= op0_in;
  op1_ext(2 * N_IN - 1 downto N_IN) <= (others => op1_in(N_IN - 1));
  op1_ext(N_IN - 1 downto 0) <= op1_in;

  op0_eq_op1 <= '1' when op0_ext = op1_ext else '0';

  result_out(POS_ADD) <= op0_ext + op1_ext;
  result_out(POS_EQ) <= (0 => op0_eq_op1, others => '0');
  result_out(POS_SUB) <= op0_ext - op1_ext;
  result_out(POS_MUL) <= op0_in * op1_in;

end architecture rtl;
