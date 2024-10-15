----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: SDP RAM package
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

package sdp_ram_pkg is
  -- Number of registers in the RAM
  constant MEM_DEPTH : natural := 4;
  -- Number of bits of each register
  constant MEM_WIDTH : natural := 5;

  -- Definitions of addr and data subtypes
  -- natural is a type containing all non-negative numbers
  subtype ram_addr_t is natural range 0 to MEM_DEPTH - 1;
  -- ram_data_t is an "alias" for std_logic_vector(MEM_WIDTH - 1 downto 0)
  subtype ram_data_t is std_logic_vector(MEM_WIDTH - 1 downto 0);

end package;
