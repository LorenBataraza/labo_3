----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: SDP RAM
--
-- Dependencies: None.
--
-- Revision: 2024-09-08
-- Additional Comments:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.sdp_ram_pkg.all;

entity sdp_ram is
  port (
    sys_clk_in  : in std_logic;

    -- Write port
    wr_en_in    : in std_logic;
    wr_addr_in  : in ram_addr_t;
    wr_data_in  : in ram_data_t;

    -- Read port
    rd_en_in    : in std_logic;
    rd_addr_in  : in ram_addr_t;
    rd_data_out : out ram_data_t
  );
end entity sdp_ram;

architecture rtl of sdp_ram is
  type mem_t is array (0 to MEM_DEPTH - 1) of ram_data_t;
  signal mem : mem_t := (others => (others => '0'));

begin
  process (sys_clk_in)
  begin
    if rising_edge(sys_clk_in) then
      if wr_en_in = '1' then
        mem(wr_addr_in) <= wr_data_in;
      end if;
      if rd_en_in = '1' then
        rd_data_out <= mem(rd_addr_in);
      end if;
    end if;
  end process;

end architecture rtl;
