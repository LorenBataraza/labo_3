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
  signal in_control : std_logic_vector(3 downto 0);
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
      in_control => in_control,
      out_led   => out_led
    );

  main_sim_proc : process
  begin
    -- Values por defecto
    rst <= '0';
    in_switch <= "00000000";
    in_control <= "0000"; 
    
    -- EN=1 , UP=1
    in_control <= "0011";
    wait for 300 ns;
    
    -- Pruebo otro -- LOAD =1 
    in_control <= "0100";
    in_switch <= x"aa";
    wait for 300 ns;
    
    assert false report "sim ended" severity failure;

  end process main_sim_proc;
end architecture sim;
