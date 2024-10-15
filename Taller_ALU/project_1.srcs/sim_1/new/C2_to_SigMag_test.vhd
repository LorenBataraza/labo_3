----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/20/2024 02:35:27 PM
-- Design Name: 
-- Module Name: conversor_test - Behavioral
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

entity C2_to_SigMag_test is

--  Port ( );
end C2_to_SigMag_test;

architecture Behavioral of C2_to_SigMag_test is
   constant N: integer:= 4;
     --Inputs
   signal mag_signo : std_logic_vector(N-1 downto 0);

    --Inputs
    signal complemento_2: std_logic_vector(N-1 downto 0);

begin
    conversor_instancia_1: entity work.C2_to_SignMag 
        generic map(N=>N)
        port map(c2 => complemento_2, mag_y_signo => mag_signo);
    
    stim_proc: process
    begin
    
    complemento_2 <="0000"; wait for 1 ns; 
    assert mag_signo <= "0000" report "Salida Mala" severity failure;
    
    complemento_2 <="0001"; wait for 1 ns; 
    assert mag_signo <= "0001" report "Salida Mala" severity failure;
    
    complemento_2 <="0010"; wait for 1 ns; 
    assert mag_signo <= "0010" report "Salida Mala" severity failure;
    
    complemento_2 <="0011"; wait for 1 ns; 
    assert mag_signo <= "0011" report "Salida Mala" severity failure;
    
    complemento_2 <="0100"; wait for 1 ns; 
    assert mag_signo <= "0100" report "Salida Mala" severity failure;
    
    complemento_2 <="0101"; wait for 1 ns; 
    assert mag_signo <= "0101" report "Salida Mala" severity failure;
    
    complemento_2 <="0110"; wait for 1 ns; 
    assert mag_signo <= "0110" report "Salida Mala" severity failure;
    
    complemento_2 <="0111"; wait for 1 ns; 
    assert mag_signo <= "0111" report "Salida Mala" severity failure;
    
    -- No hay -8 en signo y magnitud
    -- complemento_2 <="1000"; wait for 1 ns; 
    -- assert mag_signo <= "0000" report "Salida Mala" severity failure;
    
    complemento_2 <="0000"; wait for 1 ns; 
    assert mag_signo <= "0000" report "Salida Mala" severity failure;
    
    complemento_2 <="0001"; wait for 1 ns; 
    assert mag_signo <= "0001" report "Salida Mala" severity failure;
    
    complemento_2 <="0010"; wait for 1 ns; 
    assert mag_signo <= "0010" report "Salida Mala" severity failure;
    
    complemento_2 <="0011"; wait for 1 ns; 
    assert mag_signo <= "0011" report "Salida Mala" severity failure;
    
    complemento_2 <="0100"; wait for 1 ns; 
    assert mag_signo <= "0100" report "Salida Mala" severity failure;
    
    complemento_2 <="0101"; wait for 1 ns; 
    assert mag_signo <= "0101" report "Salida Mala" severity failure;
    
    complemento_2 <="0110"; wait for 1 ns; 
    assert mag_signo <= "0110" report "Salida Mala" severity failure;
    
    complemento_2 <="0111"; wait for 1 ns; 
    assert mag_signo <= "0111" report "Salida Mala" severity failure;
    
    
    
    assert false report "Simulación terminó OK";
    wait;
    end process;
    
end Behavioral;
