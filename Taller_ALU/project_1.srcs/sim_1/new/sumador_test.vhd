----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/20/2024 02:36:03 PM
-- Design Name: 
-- Module Name: igualdad_test - Behavioral
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

entity sumador_test is
--  Port ( );
end sumador_test;

architecture Behavioral of sumador_test is
    constant N: integer:=4;
   --Inputs
   signal a : std_logic_vector(N-1 downto 0) := "0000";
   signal b : std_logic_vector(N-1 downto 0) := "0000" ;
   
    --output
    signal sum: std_logic_vector(N downto 0);
    signal enable : std_logic:= '1';
    
    signal sum_signo : signed(N downto 0);
    signal a_signo : signed(N downto 0);
    signal b_bigno : signed(N downto 0);
begin
    
multiplicacion_test: entity work.gen_add_w_carry
    generic map(N=>N)
    port map(a=>std_vector(a_signo), b=>std_vector(b), 
             sum=>sum, enable=>enable);
     
    -- Transformadas de signos
    sum_signo <= signed(sum);
    a_signo <= signed(a);
    b_bigno <= signed(b);
    
    stim_proc: process
    begin
    
    a_signo <= 1; b <="0001"; wait for 1 ns; 
    assert sum_signo <= 2 report "Salida Mala" severity failure;
    
    -- 1 + -3 = -2 ()
    a_signo <= 1; b <="1101"; wait for 1 ns; 
    assert sum_signo <= "11110" report "Salida Mala" severity failure;
    
    -- 7 +1
    a_signo <= 7; b <="0001"; wait for 1 ns; 
    assert sum_signo <= 8 report "Salida Mala" severity failure;
    
    -- -4 + -1 = -5
    a_signo <= (-4); b <="1111"; wait for 1 ns; 
    assert sum_signo <= -5  report "Salida Mala" severity failure;
    
    -- 3 + 0 = 3 
    a_signo <= 3 ; b <="0000"; wait for 1 ns; 
    assert sum_signo <= 3 report "Salida Mala" severity failure;
    
    -- 0 + 5 = 5
    a_signo <= 0 ; b <="0101"; wait for 1 ns; 
    assert sum_signo <= 5 report "Salida Mala" severity failure;
    
    assert false report "Simulación terminó OK";
    wait;
    end process;
end Behavioral;
