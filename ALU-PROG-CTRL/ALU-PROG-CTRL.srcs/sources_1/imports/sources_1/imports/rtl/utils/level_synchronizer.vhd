----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: Level synchronizer
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

entity level_synchronizer is
  generic (
    PIPELINE_STAGES : integer := 2
  );
  port (
    sys_clk_in : in std_logic;
    sys_rst_in : in std_logic;
    data_in    : in std_logic;
    data_out   : out std_logic
  );
end level_synchronizer;

architecture rtl of level_synchronizer is
  signal level_synchronizer_data_reg : std_logic_vector(PIPELINE_STAGES - 1 downto 0);

  attribute ASYNC_REG : string;
  attribute ASYNC_REG of level_synchronizer_data_reg : signal is "TRUE";

begin

  aproc_sync : process (sys_clk_in)
  begin
    if rising_edge(sys_clk_in) then
      level_synchronizer_data_reg <= level_synchronizer_data_reg(PIPELINE_STAGES - 2 downto 0) & data_in;
      if (sys_rst_in = '1') then
        level_synchronizer_data_reg <= (others => '0');
      end if;
    end if;
  end process aproc_sync;

  data_out <= level_synchronizer_data_reg(PIPELINE_STAGES - 1);

end architecture rtl;
