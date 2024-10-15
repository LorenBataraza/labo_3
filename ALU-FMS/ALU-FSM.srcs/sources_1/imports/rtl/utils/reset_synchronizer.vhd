----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: Reset synchronizer
--
-- Dependencies: None.
--
-- Revision: 2023-09-04
-- Additional Comments:
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity reset_synchronizer is
  generic (
    PIPELINE_STAGES    : integer   := 2;
    RESET_ACTIVE_LEVEL : std_logic := '1'
  );
  port (
    sys_clk_in : in std_logic;
    ext_rst_in : in std_logic;
    rst_out    : out std_logic
  );
end reset_synchronizer;

architecture rtl of reset_synchronizer is
  signal level_synchronizer_data_reg : std_logic_vector(PIPELINE_STAGES - 1 downto 0);

  attribute ASYNC_REG : string;
  attribute ASYNC_REG of level_synchronizer_data_reg : signal is "TRUE";

begin

  aproc_sync : process (sys_clk_in)
  begin
    if rising_edge(sys_clk_in) then
      level_synchronizer_data_reg <= level_synchronizer_data_reg(PIPELINE_STAGES - 2 downto 0) & not(RESET_ACTIVE_LEVEL);
      if (ext_rst_in = RESET_ACTIVE_LEVEL) then
        level_synchronizer_data_reg <= (others => RESET_ACTIVE_LEVEL);
      end if;
    end if;
  end process aproc_sync;

  rst_out <= level_synchronizer_data_reg(PIPELINE_STAGES - 1);

end architecture rtl;
