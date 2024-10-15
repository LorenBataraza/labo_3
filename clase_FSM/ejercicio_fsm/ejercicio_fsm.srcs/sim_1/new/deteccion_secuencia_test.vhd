----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/03/2024 04:28:01 PM
-- Design Name: 
-- Module Name: deteccion_secuencia_test - Behavioral
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

entity deteccion_secuencia_test is
--  Port ( );
end deteccion_secuencia_test;

architecture Behavioral of deteccion_secuencia_test is
    constant T_CLK: time:= 10ns;
    signal clk, reset : STD_LOGIC;
    signal secuencia, salida: std_logic; 
begin

        -- Generación de clock
    process
    begin
        clk <='0';
        wait for T_CLK/2;
        clk <= '1';
        wait for T_CLK/2;
    end process;
    
    detector_inst: entity work.det_secuencia
    port map(
        clk=>clk, 
        reset=>reset,
        entrada => secuencia,
        salida => salida
    );
    
    stim_proc: process
    begin
    -- Default de arranque 
    reset <= '0';
    secuencia <= '0';
    wait for T_CLK;
    
    
    -- Pongo secuencia "01010010101"
    secuencia <= '0';
    wait for T_CLK; 
    assert salida = '0' report "en t=0 debe ser 0" severity failure;
 
    secuencia <= '1';
    wait for T_CLK; 
    assert salida = '0' report "en t=0 debe ser 0" severity failure;
 
     secuencia <= '0';
    wait for T_CLK; 
    assert salida = '0' report "en t=0 debe ser 0" severity failure;
 
    secuencia <= '1';
    wait for T_CLK; 
    assert salida = '1' report "en t=0 debe ser 0" severity failure;
 
     secuencia <= '0';
    wait for T_CLK; 
    assert salida = '0' report "en t=0 debe ser 0" severity failure;

     secuencia <= '0';
    wait for T_CLK; 
    assert salida = '0' report "en t=0 debe ser 0" severity failure;
 
    secuencia <= '1';
    wait for T_CLK; 
    assert salida = '0' report "en t=0 debe ser 0" severity failure;
 
     secuencia <= '0';
    wait for T_CLK; 
    assert salida = '0' report "en t=0 debe ser 0" severity failure;
 
     secuencia <= '1';
    wait for T_CLK; 
    assert salida = '1' report "en t=0 debe ser 0" severity failure;
 
    secuencia <= '0';
    wait for T_CLK; 
    assert salida = '0' report "en t=0 debe ser 0" severity failure;

    secuencia <= '1';
    wait for T_CLK; 
    assert salida = '1' report "en t=0 debe ser 0" severity failure;
 
    assert false report "Simulación terminó OK" severity failure;
    wait;
    end process;
    
end Behavioral;
