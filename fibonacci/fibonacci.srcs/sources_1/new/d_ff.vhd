----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/21/2024 08:31:45 PM
-- Design Name: 
-- Module Name: d_ff - Behavioral
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

entity d_ff is
    generic(N : integer := 4);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           d : in unsigned(N-1 DOWNTO 0);
           q : out unsigned(N-1 DOWNTO 0);
           en : in STD_LOGIC);
end d_ff;

architecture Behavioral of d_ff is
begin
process(clk, reset)
    begin
        if(reset='1')then
            q<=(others => '0');
        elsif(clk'event and clk='1') then
            if(en='1') then
                q <= d;
            end if ;
        end if ;
    end process;
end Behavioral;