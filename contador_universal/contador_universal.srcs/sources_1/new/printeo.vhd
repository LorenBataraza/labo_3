----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/29/2024 02:59:33 PM
-- Design Name: 
-- Module Name: printeo - Behavioral
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

entity printeo is
    port(
        an: out std_logic_vector (3 downto 0):= "1110";
        display: out std_logic_vector(6 downto 0);
        leds_load: out std_logic_vector(3 downto 0);
        
        clk: in std_logic;
       
        hab_cont_boton: in std_logic;
        hab_cont_llave: in std_logic;
        
        
        suma_o_baja: in std_logic;
        syn_clr_2: in std_logic;
        load_2: in std_logic;
        d_2: std_logic_vector(3 downto 0)
    );
end printeo;

architecture Behavioral of printeo is
    constant factor_delay : integer := 25;
    constant limite_contador: integer:= 4;
    
    -- Señales Contador 1
    signal reset_1: std_logic := '0';
    signal syn_clr_1: std_logic := '0';
    signal en_1: std_logic := '1';
    signal load_1: std_logic := '0';
    signal up_1: std_logic := '1';
    signal max_tick_1: std_logic;
    signal min_tick_1: std_logic;
    
    signal d_1: std_logic_vector(factor_delay-1 downto 0);
    signal q_1: std_logic_vector(factor_delay-1 downto 0);
    
        -- Señales Contador 2
    signal reset_2: std_logic := '0';
    signal max_tick_2: std_logic;
    signal min_tick_2: std_logic;
    signal q_2: std_logic_vector(limite_contador-1 downto 0);
    
    signal hab_cont_2 : std_logic;
    
begin
    univ_cont_1: entity work.universal_bin_counter
    generic map(N=>factor_delay)
    port map(
        clk=>clk, 
        reset=>reset_1, 
        syn_clr=>syn_clr_1, 
        load=>load_1, 
        en=>en_1,
        up => up_1, 
        d => d_1,
        q => q_1,
        max_tick=> max_tick_1,
        min_tick => min_tick_1
    );
    
    -- logica del hab del segundo contador
    hab_cont_2 <= (((hab_cont_boton or hab_cont_llave)) and max_tick_1);
    
    univ_cont_2: entity work.universal_bin_counter
    generic map(N=>limite_contador)
    port map(
        clk=>clk, 
        reset=>reset_2, 
        syn_clr=>syn_clr_2, 
        load=>load_2, 
        en=>hab_cont_2,
        up => suma_o_baja, 
        d => d_2,
        q => q_2,
        max_tick=> max_tick_2,
        min_tick => min_tick_2
    );
    
    leds_load <= d_2;
   
   -- Salida Segmento 
   with q_2 SELect
   display<= 
         "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0

end Behavioral;
