----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/27/2024 04:01:35 PM
-- Design Name: 
-- Module Name: universal_bin_counter_test - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity universal_bin_counter_test is
--  Port ( );
end universal_bin_counter_test;

architecture Behavioral of universal_bin_counter_test is
       constant N: integer:= 4;
       signal clk, reset : STD_LOGIC;
       signal syn_clr, load, en, up:  STD_LOGIC;
       signal d: STD_LOGIC_VECTOR(N-1 downto 0);
       signal max_tick, min_tick: std_logic;
       signal q:  STD_LOGIC_VECTOR(N-1 downto 0);
       
       constant T_CLK: time:= 10ns;
begin
    universal_bin_counter_inst: entity work.universal_bin_counter
    generic map(N=>N)
    port map(
        clk=>clk, 
        reset=>reset, 
        syn_clr=>syn_clr, 
        load=>load , 
        en=>en,
        up => up, 
        d => d,
        q => q,
        max_tick=> max_tick,
        min_tick => min_tick
    );
         
    -- Genneración de clock
    process
    begin
        clk <='0';
        wait for T_CLK/2;
        clk <= '1';
        wait for T_CLK/2;
    end process;
    
    
    
    stim_proc: process
    begin
    -- Valores iniciales
    reset <= '0'; syn_clr <= '0'; 
    load <= '0'; en <= '1'; up<= '1';
    d<= "1111";
    
    -- Compruebo Sync Clear 
    wait until rising_edge(clk);
    wait for T_CLK/2;
    syn_clr <='1';
    wait for 2*T_CLK;
    syn_clr <='0';
    assert q = "0000" report "salida no cero con synclear" severity failure;
    
    -- Compruebo para carga de valores
    d<= "0101"; load <= '1';
    wait for T_CLK; 
    load <= '0';
    assert q = d report "load no funcionó" severity failure;
 
    -- Compruebo cuenta para arriba 
    wait for 2*T_CLK; 
    assert q = "0111" report "No aumentó" severity failure;
    
    -- Compruebo cuenta para abajo 
    up<= '0';
    wait for 2*T_CLK; 
    assert q = "0101" report "No disminuyó" severity failure;
    
    -- Compruebo enable 
    en <= '0';
    wait for 2*T_CLK; 
    assert q = d report "Contó aún con en=0" severity failure;
    
    -- Compruebo min-tick
    d<= "0000"; load <= '1';
    wait for 2*T_CLK; 
    load <= '0';
    assert min_tick  = '1' report "min_tick da cero cuando no debe" severity failure;

    -- Compruebo max-tick
    d<= "1111"; load <= '1';
    wait for 2*T_CLK; 
    load <= '0';
    assert max_tick  = '1' report "max_tick da cero cuando no  " severity failure;
    
    -- Aumento 16 valores 
    en <= '1';
    wait for 16*T_CLK; 
    assert false report "Simulación terminó OK" severity failure;
    wait;
    end process;

end Behavioral;
