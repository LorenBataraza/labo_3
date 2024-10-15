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

entity multiplicacion_test is
--  Port ( );
end multiplicacion_test;

architecture Behavioral of multiplicacion_test is
    constant N: integer:=4;
   --Inputs
   signal a : std_logic_vector(N-1 downto 0) := "0000";
   signal b : std_logic_vector(N-1 downto 0) := "0000" ;
   
    --output
    signal sum: std_logic_vector(N downto 0);
    signal enable : std_logic:= '1';
    
    signal sum_signo : signed(N downto 0);
begin
    
multiplicacion_test: entity work.multiplicador_sin_signo
    generic map(N=>N)
    port map(a=>a, b=>b, 
             sum=>sum, enable=>enable);
     
    -- Transformadas de signos
    sum_signo <= signed(sum);
    
    stim_proc: process
    begin
    
    -- Compruebo multiplicaciones positivas 
    -- 1+1 = 2
    a <="0001"; b <="0001"; wait for 1 ns; 
    assert producto_signo <= 2 report "Salida Mala" severity failure;
    
    -- 1 + -3 = -2 ()
    a <="0001"; b <="1101"; wait for 1 ns; 
    assert producto_signo <= -2 report "Salida Mala" severity failure;
    
    -- 7 +1
    a <="1111"; b <="0001"; wait for 1 ns; 
    assert producto_signo <= 8 report "Salida Mala" severity failure;
    
    -- -4 + -1 = -5
    a <="1011"; b <="1111"; wait for 1 ns; 
    assert producto_signo <= -5  report "Salida Mala" severity failure;
    
    -- 3 + 0 = 3 
    a <="0011"; b <="0000"; wait for 1 ns; 
    assert producto_signo <= 3 report "Salida Mala" severity failure;
    
    -- 0 + 5 = 5
    a <="0000"; b <="0101"; wait for 1 ns; 
    assert producto_signo <= 5 report "Salida Mala" severity failure;
    
    assert false report "Simulación terminó OK";
    wait;
    end process;
end Behavioral;
