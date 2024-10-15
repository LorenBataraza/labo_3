----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: ROM package
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

package rom_pkg is
  -- Number of registers in the ROM
  constant MEM_DEPTH : natural := 16;
  -- Number of bits of each register
  constant MEM_WIDTH : natural := 8;

  -- Definitions of addr and data subtypes
  subtype rom_addr_t is natural range 0 to MEM_DEPTH - 1;
  subtype rom_data_t is std_logic_vector(MEM_WIDTH - 1 downto 0);

end package;
