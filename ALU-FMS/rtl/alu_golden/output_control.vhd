----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: Output control for ALU
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

entity output_control is
  port (
    data_in   : in result_array_t;
    op_sel_in : in op_sel_t;
    data_out  : out signed_output_t;
    error_out : out std_logic
  );
end entity output_control;

architecture rtl of output_control is
  signal selected_data : signed_result_t;
begin

  selected_data <= data_in(to_integer(unsigned(op_sel_in)));

  saturate_data_proc : process (selected_data)
  begin
    error_out <= '0';
    data_out <= selected_data(N_OUT - 1 downto 0);
    if abs(selected_data) > (2 ** (N_OUT - 1) - 1) then
      data_out <= (others => '0');
      error_out <= '1';
    end if;
  end process saturate_data_proc;

end architecture rtl;
