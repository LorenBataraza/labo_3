----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2024 04:52:15 PM
-- Design Name: 
-- Module Name: sum_completo_bit_test - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sum_completo_bit_test is
--  Port ( );
end sum_completo_bit_test;

architecture Behavioral of sum_completo_bit_test is
   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal c_in : std_logic := '0';

 	--Outputs
   signal sum : std_logic := '0';
   signal c_out : std_logic;
 
begin

sumador_bit: entity work.sum_completo_bit
		port map(
		a => a, b => b, c_in => c_in, 
		sum => sum, c_out => c_out);

    stim_proc: process
    begin
    
    -- a=0, b=0, c_in=0 :: c_out=0, sum=0
    a <= '0'; b <= '0'; c_in <= '0'; 
	wait for 1 ns; -- 2) espero el tiempo de propagación 
    assert c_out <= '0' report "Falló carry" severity failure;
	assert sum <= '0' report "Falló suma " severity failure;
    
    -- a=0, b=0, c_in=1 :: c_out=0, sum=1
    a <= '0'; b <= '0'; c_in <= '1';
	wait for 1 ns; -- 2) espero el tiempo de propagación 
    assert c_out <= '0' report "Falló carry" severity failure;
	assert sum <= '1' report "Falló suma " severity failure;
    
    -- a=0, b=1, c_in=0 :: c_out=0, sum=1
    a <= '0'; b <= '1'; c_in <= '0';
	wait for 1 ns; -- 2) espero el tiempo de propagación 
    assert c_out <= '0' report "Falló carry" severity failure;
	assert sum <= '1' report "Falló suma " severity failure;
    
    
    -- a=0, b=1, c_in=1 :: c_out=1, sum=0
    a <= '0'; b <= '1'; c_in <= '1';
	wait for 1 ns; -- 2) espero el tiempo de propagación 
    assert c_out <= '1' report "Falló carry" severity failure;
	assert sum <= '0' report "Falló suma " severity failure;
    
    -- a=1, b=0, c_in=0 :: c_out=0, sum=1
    a <= '1'; b <= '0'; c_in <= '0';
	wait for 1 ns; -- 2) espero el tiempo de propagación 
    assert c_out <= '0' report "Falló carry" severity failure;
	assert sum <= '1' report "Falló suma " severity failure;
    
    
    -- a=1, b=0, c_in=1 :: c_out=1, sum=0
    a <= '1'; b <= '0'; c_in <= '1';
	wait for 1 ns; -- 2) espero el tiempo de propagación 
    assert c_out <= '1' report "Falló carry" severity failure;
	assert sum <= '0' report "Falló suma " severity failure;
    
    
    -- a=1, b=1, c_in=0 :: c_out=1, sum=0
    a <= '1'; b <= '1'; c_in <= '0';
    
	wait for 1 ns; -- 2) espero el tiempo de propagación 
    assert c_out <= '1' report "Falló carry" severity failure;
	assert sum <= '0' report "Falló suma " severity failure;
    
    
    -- a=1, b=1, c_in=1 :: c_out=1, sum=0
    a <= '1'; b <= '1'; c_in <= '1';
    
	wait for 1 ns; -- 2) espero el tiempo de propagación 
    assert c_out <= '1' report "Falló carry" severity failure;
	assert sum <= '1' report "Falló suma " severity failure;
    
    assert false report "Simulación terminó OK";
    wait;
    end process;
end;

