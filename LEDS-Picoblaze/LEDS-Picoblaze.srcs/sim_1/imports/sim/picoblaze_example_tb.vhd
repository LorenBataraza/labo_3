----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: PicoBlaze Example Testbench
--
-- Dependencies: None.
--
-- Revision: 2023-08-11
-- Additional Comments:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity picoblaze_example_tb is
end entity picoblaze_example_tb;

architecture sim of picoblaze_example_tb is
  signal clk : std_logic;
  signal rst : std_logic;
  signal in_switch : std_logic_vector(7 downto 0);
  signal out_led : std_logic_vector(7 downto 0);

  constant CLK_PERIOD : time := 10 ns;

begin

  clk_gen_proc : process
  begin
    clk <= '1';
    wait for CLK_PERIOD/2;
    clk <= '0';
    wait for CLK_PERIOD/2;
  end process;

  uut_inst : entity work.picoblaze_example_top
    port map(
      clk       => clk,
      rst       => rst,
      in_switch => in_switch,
      out_led   => out_led
    );

  main_sim_proc : process
  begin
    rst <= '1';
    wait for 50 ns;
    rst <= '0';
    for i in 0 to 20 loop
      wait until rising_edge(clk);
    end loop;
    -- Primer Prueba
    in_switch <= x"a0";
    wait for 100 ns;
    
    -- Pruebo otro
    in_switch <= x"aa";
    wait for 100 ns;
    
    assert false report "sim ended" severity failure;

  end process main_sim_proc;
end architecture sim;
