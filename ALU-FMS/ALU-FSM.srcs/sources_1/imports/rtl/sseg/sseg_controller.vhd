----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: SSeg Controller
--
-- Dependencies: None.
--
-- Revision: 2023-09-04
-- Additional Comments:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity sseg_controller is
  generic (
    SIM_ONLY : std_logic
  );
  port (
    sys_clk_in : in std_logic;
    sys_rst_in : in std_logic;
    sseg0_in   : in std_logic_vector(4 downto 0);
    sseg1_in   : in std_logic_vector(4 downto 0);
    sseg2_in   : in std_logic_vector(4 downto 0);
    sseg3_in   : in std_logic_vector(4 downto 0);
    sseg_en_in : in std_logic_vector(3 downto 0);
    sseg_out   : out std_logic_vector(7 downto 0);
    an_out     : out std_logic_vector(3 downto 0)
  );
end sseg_controller;

architecture arch of sseg_controller is
  function setup1(s : std_logic; i0 : natural; i1 : natural)
    return natural is
  begin
    if s = '1' then
      return i1;
    else
      return i0;
    end if;
  end function;

  constant COUNT_N : natural := setup1(SIM_ONLY, 19, 2);

  subtype sseg_code_t is std_logic_vector(7 downto 0);
  type sseg_rom_t is array (0 to 16) of sseg_code_t;
  constant SSEG_TABLE : sseg_rom_t := (
    "11000000",
    "11111001",
    "10100100",
    "10110000",
    "10011001",
    "10010010",
    "10000010",
    "11111000",
    "10000000",
    "10010000",
    "10001000",
    "10000011",
    "11000110",
    "10100001",
    "10000110",
    "10001110",
    "10111111" --x"10" == '-'
  );

  signal sseg0 : sseg_code_t;
  signal sseg1 : sseg_code_t;
  signal sseg2 : sseg_code_t;
  signal sseg3 : sseg_code_t;
  signal count_reg : unsigned(COUNT_N - 1 downto 0);
  signal sel : unsigned(1 downto 0);

begin

  sseg0 <= SSEG_TABLE(to_integer(unsigned(sseg0_in)));
  sseg1 <= SSEG_TABLE(to_integer(unsigned(sseg1_in)));
  sseg2 <= SSEG_TABLE(to_integer(unsigned(sseg2_in)));
  sseg3 <= SSEG_TABLE(to_integer(unsigned(sseg3_in)));

  --state register: use MSBs of counter to get slow signal
  sel <= count_reg(COUNT_N - 1 downto COUNT_N - 2);
  process (sys_clk_in, sys_rst_in)
    variable an_reg : std_logic_vector(3 downto 0);
  begin
    if (rising_edge(sys_clk_in)) then
      count_reg <= count_reg + 1;
      case sel is
        when "00" =>
          an_reg := "0111";
          sseg_out <= sseg3;
        when "01" =>
          an_reg := "1011";
          sseg_out <= sseg2;
        when "10" =>
          an_reg := "1101";
          sseg_out <= sseg1;
        when others => --11
          an_reg := "1110";
          sseg_out <= sseg0;
      end case;
      an_out <= an_reg or not sseg_en_in;
      if (sys_rst_in = '1') then
        count_reg <= (others => '0');
      end if;
    end if;
  end process;

end arch;
