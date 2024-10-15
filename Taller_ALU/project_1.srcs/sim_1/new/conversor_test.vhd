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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conversor_test is
    generic(N: integer:=4);
--  Port ( );
end conversor_test;

architecture Behavioral of conversor_test is
     --Inputs
   signal mag_signo : signed(N-1 downto 0);
    --output
    signal complemento_2: signed(N-1 downto 0);

begin
    conversor_instancia_1: entity work.MyS_2_C2 (Behavioral)
        generic map(N=>N)
        port map(mag_y_signo => mag_signo, c2 => complemento_2);
    
    stim_proc: process
    begin
    
    mag_signo <="0000"; wait for 1 ns; 
    assert complemento_2 <= "0000" report "Salida Mala" severity failure;
    
    mag_signo <="0001"; wait for 1 ns; 
    assert complemento_2 <= "0001" report "Salida Mala" severity failure;
    
    mag_signo <="0010"; wait for 1 ns; 
    assert complemento_2 <= "0010" report "Salida Mala" severity failure;
    
    mag_signo <="0011"; wait for 1 ns; 
    assert complemento_2 <= "0011" report "Salida Mala" severity failure;
    
    mag_signo <="0100"; wait for 1 ns; 
    assert complemento_2 <= "0100" report "Salida Mala" severity failure;
    
    mag_signo <="0101"; wait for 1 ns; 
    assert complemento_2 <= "0101" report "Salida Mala" severity failure;
    
    mag_signo <="0110"; wait for 1 ns; 
    assert complemento_2 <= "0110" report "Salida Mala" severity failure;
    
    mag_signo <="0111"; wait for 1 ns; 
    assert complemento_2 <= "0111" report "Salida Mala" severity failure;
    
    -- Segundo Cero
    mag_signo <="1000"; wait for 1 ns; 
    assert complemento_2 <= "0000" report "Salida Mala" severity failure;
    
    -- Números Negativos
    mag_signo <="1001"; wait for 1 ns; 
    assert complemento_2 <= "1111" report "Salida Mala" severity failure;

    mag_signo <="1010"; wait for 1 ns; 
    assert complemento_2 <= "1110" report "Salida Mala" severity failure;

    mag_signo <="1011"; wait for 1 ns; 
    assert complemento_2 <= "1101" report "Salida Mala" severity failure;

    mag_signo <="1100"; wait for 1 ns; 
    assert complemento_2 <= "1100" report "Salida Mala" severity failure;

    mag_signo <="1101"; wait for 1 ns; 
    assert complemento_2 <= "1011" report "Salida Mala" severity failure;

    mag_signo <="1110"; wait for 1 ns; 
    assert complemento_2 <= "1010" report "Salida Mala" severity failure;
    
    mag_signo <="1111"; wait for 1 ns; 
    assert complemento_2 <= "1001" report "Salida Mala" severity failure;

    
    assert false report "Simulación terminó OK";
    wait;
    end process;
    
end Behavioral;
