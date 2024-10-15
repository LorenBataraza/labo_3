----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: ROM
--
-- Dependencies: None.
--
-- Revision: 2024-09-19
-- Additional Comments:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.rom_pkg.all;

entity rom is
  port (
    sys_clk_in  : in std_logic;

    -- Read port
    rd_en_in    : in std_logic;
    rd_addr_in  : in rom_addr_t;
    rd_data_out : out rom_data_t
  );
end entity rom;

architecture rtl of rom is
  type mem_t is array (0 to MEM_DEPTH - 1) of rom_data_t;
  constant mem : mem_t := (
    -- PROGRAM 1 : A*B+ C-D
    0 => "10010000", -- Addr0 <= A*B (Addr0 * Addr1)
    1 => "01111001", -- Addr1 <= C-D (Addr2 - Addr3)
    2 => "00000110", -- Addr2 <= Addr0 + Addr1 
    -- PROGRAM 2 : A*B + C*D
    3 => "10010000", -- Addr0 <= A*B (Addr0 * Addr1)
    4 => "10111001", -- Addr1 <= C*D (Addr2 * Addr3)
    5 => "00000110", -- Addr2 <= Addr0 + Addr1 
    -- PROGRAM 3:  (A-B) * (C-D)
    6 => "01010000", -- Addr0 <= A-B (Addr0 - Addr1)
    7 => "01111001", -- Addr1 <= C-D (Addr2 - Addr3)
    8 => "10000110", -- Addr2 <= Addr0 * Addr1 
    
    others => (others => '0')
  );

begin
  process (sys_clk_in)
  begin
    if rising_edge(sys_clk_in) then
      if rd_en_in = '1' then
        rd_data_out <= mem(rd_addr_in);
      end if;
    end if;
  end process;

end architecture rtl;
