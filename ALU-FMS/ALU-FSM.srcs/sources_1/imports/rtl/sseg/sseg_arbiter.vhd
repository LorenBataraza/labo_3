
----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: SSEG arbiter
--
-- Dependencies: None.
--
-- Revision: 2023-09-04
-- Additional Comments:
-- This module selects between two inputs, data0 or data1, selecting which one
-- will control the SSEG displays. It also saturates its size to SIGMAG
-- representation. If the value cannot be represented, outputs will be replaced
-- with EEEE.
-- In case of collision, data0 input takes priority, and data1 is discarded.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity sseg_arbiter is
  generic (
    N : integer := 4
  );
  port (
    sys_clk_in     : in std_logic;
    sys_rst_in     : in std_logic;

    data0_in       : in std_logic_vector(N - 1 downto 0);
    data0_valid_in : in std_logic;

    data1_in       : in std_logic_vector(N - 1 downto 0);
    data1_valid_in : in std_logic;

    sseg0_out      : out std_logic_vector(4 downto 0);
    sseg1_out      : out std_logic_vector(4 downto 0);
    sseg2_out      : out std_logic_vector(4 downto 0);
    sseg3_out      : out std_logic_vector(4 downto 0);
    sseg_en_out    : out std_logic_vector(3 downto 0)
  );
end entity sseg_arbiter;

architecture rtl of sseg_arbiter is
  signal value_sel_reg : std_logic_vector(N - 1 downto 0);
  signal sseg0 : std_logic_vector(4 downto 0);
  signal sseg1 : std_logic_vector(4 downto 0);
  signal sseg2 : std_logic_vector(4 downto 0);
  signal sseg3 : std_logic_vector(4 downto 0);
  signal sseg_en : std_logic_vector(3 downto 0);
begin

  process (sys_clk_in)
  begin
    if rising_edge(sys_clk_in) then
      if data0_valid_in = '1' then
        value_sel_reg <= data0_in;
      elsif data1_valid_in = '1' then
        value_sel_reg <= data1_in;
      end if;
      if (sys_rst_in = '1') then
        value_sel_reg <= (others => '0');
      end if;
    end if;
  end process;

  process (value_sel_reg)
  begin
    sseg_en <= (others => '0');
    sseg0(4 downto N - 1) <= (others => '0');
    sseg0(N - 2 downto 0) <= value_sel_reg(N - 2 downto 0);
    sseg_en(0) <= '1';
    sseg1 <= (others => '0');
    sseg2 <= (others => '0');
    sseg3 <= (others => '0');
    if (value_sel_reg(N - 1) = '1') then
      sseg1 <= '1' & x"0";
      sseg_en(1) <= '1';
    end if;
    if (unsigned(value_sel_reg(N - 2 downto 0)) > 15) then
      sseg0 <= '0' & x"E";
      sseg1 <= '0' & x"E";
      sseg2 <= '0' & x"E";
      sseg3 <= '0' & x"E";
      sseg_en <= (others => '1');
    end if;
  end process;

  process (sys_clk_in)
  begin
    if rising_edge(sys_clk_in) then
      sseg0_out <= sseg0;
      sseg1_out <= sseg1;
      sseg2_out <= sseg2;
      sseg3_out <= sseg3;
      sseg_en_out <= sseg_en;
    end if;
  end process;

end architecture rtl;
