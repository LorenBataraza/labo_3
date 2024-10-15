----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2024 04:28:16 PM
-- Design Name: 
-- Module Name: fibonacci_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fibonacci_test is
--  Port ( );
end fibonacci_test;

architecture Behavioral of fibonacci_test is
    constant N: integer:= 8;
    constant T_CLK: time:= 10ns;
  
  -- Señales de fibonacci    
    signal clk_in, start_in, reset_in: STD_LOGIC;
    signal done_tick_out, ready_out: STD_LOGIC;
    signal fib_out: unsigned(N-1 downto 0);
    signal i_in: unsigned(N-1 DOWNTO 0);
begin

    fibonacci_inst: entity work.datapath
    generic map(N=>N)
    port map(
        clk=>clk_in, 
        reset=>reset_in, 
        start => start_in, 
        i => i_in,
        fib => fib_out,
        done_tick => done_tick_out,
        ready=> ready_out
    );

    -- Generación de clock
    process
    begin
        clk_in <='0';
        wait for T_CLK/2;
        clk_in <= '1';
        wait for T_CLK/2;
    end process;

    stim_proc: process
    begin
    -- Valores iniciales
    reset_in <= '0'; 
    start_in <= '0';
    wait for T_CLK;
    
    
    -- Valores iniciales
    reset_in <= '1'; 
    wait for T_CLK;
    
    -- Calculo F(3)
    reset_in <= '0'; start_in <= '1';
    i_in<= TO_UNSIGNED(3,N);
    wait for T_CLK;
    start_in <= '0';
 
    wait until (done_tick_out'event);
    assert fib_out=1  report "F(2) != 2" severity failure;
    
    
    wait for T_CLK;
    wait until (ready_out'event);
    i_in<= TO_UNSIGNED(5,N);
    start_in <= '1';
    wait for T_CLK;
    start_in <= '0';
  
    wait until (done_tick_out'event);
    assert fib_out=5  report "F(5) != 5" severity failure;
    
    
    assert false report "Simulación terminó OK" severity failure;
    wait;
    end process;
    
end Behavioral;
