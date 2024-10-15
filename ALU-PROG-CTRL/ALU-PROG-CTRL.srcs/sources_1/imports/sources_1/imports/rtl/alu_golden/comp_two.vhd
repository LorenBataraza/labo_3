----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: Sig/Mag <-> Two's comp converter
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

entity comp_two is
  generic (
    N : natural := 4
  );
  port (
    data_in  : in std_logic_vector(N - 1 downto 0);
    data_out : out std_logic_vector(N - 1 downto 0)
  );
end entity comp_two;

architecture rtl of comp_two is
  signal mag : unsigned(N - 1 downto 0);
  signal conv : unsigned(N - 1 downto 0);

begin

  mag <= '0' & unsigned(data_in(N - 2 downto 0));

  conv <= mag when data_in(N - 1) = '0' else (not(mag) + 1);
  data_out <= std_logic_vector(conv);

end architecture rtl;
