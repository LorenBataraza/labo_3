----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: ALU top
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
use work.alu_pkg.all;

entity alu_top is
  port (
    op0_in     : in std_logic_vector(N_IN - 1 downto 0);
    op1_in     : in std_logic_vector(N_IN - 1 downto 0);
    op_sel_in  : in std_logic_vector(1 downto 0);
    result_out : out std_logic_vector(N_OUT - 1 downto 0);
    error_out  : out std_logic
  );
end entity alu_top;

architecture rtl of alu_top is
  signal op0_slv : std_logic_vector(N_IN - 1 downto 0);
  signal op0 : signed_op_t;
  signal op1_slv : std_logic_vector(N_IN - 1 downto 0);
  signal op1 : signed_op_t;
  signal result_arr : result_array_t;
  signal result : signed_output_t;
begin

  input_comp_two_op0_inst : entity work.comp_two
    generic map(
      N => N_IN
    )
    port map(
      data_in  => op0_in,
      data_out => op0_slv
    );
  op0 <= signed(op0_slv);

  input_comp_two_op1_inst : entity work.comp_two
    generic map(
      N => N_IN
    )
    port map(
      data_in  => op1_in,
      data_out => op1_slv
    );
  op1 <= signed(op1_slv);

  alu_inst : entity work.alu
    port map(
      op0_in     => op0,
      op1_in     => op1,
      result_out => result_arr
    );

  output_control_inst : entity work.output_control
    port map(
      data_in   => result_arr,
      op_sel_in => op_sel_in,
      data_out  => result,
      error_out => error_out
    );

  output_comp_two_inst : entity work.comp_two
    generic map(
      N => N_OUT
    )
    port map(
      data_in  => std_logic_vector(result),
      data_out => result_out
    );

end architecture rtl;
