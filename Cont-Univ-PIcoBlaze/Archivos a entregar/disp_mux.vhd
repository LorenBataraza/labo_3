----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/21/2024 08:25:05 PM
-- Design Name: 
-- Module Name: disp_mux - Behavioral
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

entity disp_mux is
    port(
    clk, reset: in std_logic;
    in3, in2, in1, in0: in std_logic_vector(7 downto 0);
    an: out std_logic_vector(3 downto 0);
    sseg: out std_logic_vector(7 downto 0)
    );
end disp_mux;

architecture Behavioral of disp_mux is
    -- Variables Contador
    signal enable_counter : std_logic := '1';
    signal min_tick : std_logic;
    signal max_tick : std_logic;
    signal contador_filtrado: std_logic_vector(1 downto 0) ;
    signal contador: std_logic_vector(12 downto 0) ;
    
begin
-- Tengo que dar 4ms a cada an
-- Cada vez que cambio de an tengo que 
-- tambien de sseg a otra in

    counter_inst: entity work.universal_bin_counter
        generic map(N => 13) 
		port map(
		q => contador, up => '1', clk => clk, reset => reset,
		en => '1', load => '0', d=> "0000000000000", syn_clr=>'0',
		max_tick => max_tick, min_tick => min_tick);
    
   contador_filtrado <= contador(12 downto 11);
   with contador_filtrado select
        sseg <= in0 when "00",
                in1 when "01",
                in2 when "10",
                in3 when "11";
                
    with contador_filtrado select
        an <= "1110" when "00",
              "1101" when "01",
              "1011" when "10",
              "0111" when "11";
        
end Behavioral;
