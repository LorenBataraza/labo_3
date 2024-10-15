----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/15/2024 04:51:24 PM
-- Design Name: 
-- Module Name: igualdad_4bits - Behavioral
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

entity igualdad_4bits is
    generic(N: integer:=4);
    port(
    n1, n2: in std_logic_vector(N-1 downto 0);
    salida: out std_logic_vector(N downto 0);
    enable: in std_logic
    );
end igualdad_4bits;

architecture Behavioral of igualdad_4bits is
begin
    salida <= (others => 'Z') when enable='0' else
              (others => '1') when (n1 = n2) else
              (others => '0');
                  
end Behavioral;
