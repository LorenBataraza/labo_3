----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/21/2024 08:15:02 PM
-- Design Name: 
-- Module Name: universal_bin_counter - Behavioral
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

entity universal_bin_counter is
    generic(N: integer:= 8);
    Port (clk, reset : in STD_LOGIC;
           syn_clr, load, en, up: in STD_LOGIC;
           d: in STD_LOGIC_VECTOR(N-1 downto 0);
           max_tick, min_tick: out std_logic;
           q: out STD_LOGIC_VECTOR(N-1 downto 0)
           );
end universal_bin_counter;

architecture Behavioral of universal_bin_counter is
    signal r_reg: unsigned(N-1 downto 0);
    signal r_next: unsigned(N-1 downto 0);

begin
    -- Estado
    process(clk, reset)
    begin
        if(reset='1')then
            r_reg <= (others => '0');
        elsif(clk'event and clk='1') then
            r_reg <= r_next;
        end if ;
    end process;
    
    r_next <= (others => '0') when syn_clr='1' else
        unsigned(d) when load='1' else
        r_reg+ 1 when en='1' and up='1' else
        r_reg- 1 when en='1' and up='0' else
        r_reg;
    
    -- salida
    q <= std_logic_vector(r_reg);
    max_tick <=  '1' when r_reg= (2**N-1) else '0';
    min_tick <=  '1' when r_reg = 0 else '0';
end Behavioral;
