----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/21/2024 08:03:53 PM
-- Design Name: 
-- Module Name: C2_to_SignMag - Behavioral
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

use IEEE.NUMERIC_STD.ALL;

entity C2_to_SignMag is
    generic(N: integer := 4);  
    Port ( c2 : in std_logic_vector(N-1 downto 0);
           mag_y_signo : out std_logic_vector(N-1 downto 0));
end C2_to_SignMag;

architecture Behavioral of C2_to_SignMag is
    signal aux: unsigned(N-2 downto 0);
begin
    -- Primer bit me dice el signo
    mag_y_signo(N-1) <= c2(N-1);
    
    -- Conversion de siempre 
    aux <= unsigned(not(c2(N-2 downto 0))) + 1;
    mag_y_signo(N-2 downto 0) <= c2(N-2 downto 0) when c2(N-1) = '0' else std_logic_vector(aux);
end Behavioral;

