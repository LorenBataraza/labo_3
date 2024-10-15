----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: Debouncer
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

entity debouncer is
  generic (
    COUNT_MAX : natural := 128
  );
  port (
    sys_clk_in : in std_logic;
    sys_rst_in : in std_logic;
    data_in    : in std_logic;
    data_out   : out std_logic
  );
end entity debouncer;

architecture rtl of debouncer is
  signal current_output_reg : std_logic;
  signal counter_reg : natural;

begin

  proc_ext_trig_cond : process (sys_clk_in)
  begin
    if (rising_edge(sys_clk_in)) then
      if current_output_reg = '0' then
        if counter_reg >= COUNT_MAX then
          current_output_reg <= '1';
          counter_reg <= 0;
        elsif data_in = '1' then
          counter_reg <= counter_reg + 1;
        else
          counter_reg <= 0;
        end if;
      else
        if counter_reg >= COUNT_MAX then
          current_output_reg <= '0';
          counter_reg <= 0;
        elsif data_in = '0' then
          counter_reg <= counter_reg + 1;
        else
          counter_reg <= 0;
        end if;
      end if;

      if (sys_rst_in = '1') then
        current_output_reg <= '0';
        counter_reg <= 0;
      end if;
    end if;
  end process;

  data_out <= current_output_reg;

end architecture rtl;
