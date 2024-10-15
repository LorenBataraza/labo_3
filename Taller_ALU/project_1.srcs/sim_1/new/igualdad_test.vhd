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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity igualdad_test is
--  Port ( );
end igualdad_test;

architecture Behavioral of igualdad_test is
    constant N: integer:=4;
   --Inputs
   signal n1 : std_logic_vector(N-1 downto 0) := "0000";
   signal n2 : std_logic_vector(N-1 downto 0) := "0000" ;
   
    --output
    signal salida: std_logic_vector(N downto 0);
    signal enable : std_logic:= '1';
begin

igualdad_4_bits_inst: entity work.igualdad_4bits
    generic map(N=>N)
    port map(n1=>n1, n2=>n2, 
             salida=>salida, enable=>enable);
     
    stim_proc: process
    begin
    -- Chequeo si son iguales - (Chequeo todas las igualdades)
    n1<="0000"; n2<="0000"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;
    
    n1<="0001"; n2<="0001"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;

    n1<="0010"; n2<="0010"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;

    n1<="0011"; n2<="0011"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;

    n1<="0100"; n2<="0100"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;

    n1<="0101"; n2<="0101"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;

    n1<="0110"; n2<="0110"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;

    n1<="1110"; n2<="1110"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;

    n1<="1111"; n2<="1111"; wait for 1 ns; 
    assert salida <= "11111" report "Salida Mala" severity failure;

    -- Chequeo si son distintos (Cambio todos los n2)
    n1<="0000"; n2<="0001"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="0010"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="0010"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="0011"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="0100"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="0101"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="0110"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="0111"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="1000"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="1001"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="1010"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="1011"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="1100"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="1110"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;

    n1<="0000"; n2<="1111"; wait for 1 ns; 
    assert salida <= "00000" report "Salida Mala" severity failure;
    
    -- Enable
    enable <='0' ; n1<="0000"; n2<="1111"; wait for 1 ns; 
    assert salida <= "ZZZZZ" report "Salida Mala" severity failure;

    assert false report "Simulación terminó OK";
    wait;
    end process;
end Behavioral;
