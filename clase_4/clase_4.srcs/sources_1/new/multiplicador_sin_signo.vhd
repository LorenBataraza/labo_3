----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2024 07:50:27 PM
-- Design Name: 
-- Module Name: multiplicador_sin_signo - Behavioral
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

entity multiplicador_sin_signo is
    generic(N: integer:= 4);
    port(
    a,b: in unsigned (N downto 0);
    product: out unsigned (2*N downto 0);
    )
end multiplicador_sin_signo;


architecture Behavioral of multiplicador_sin_signo is
begin
    product <= a*b;
end Behavioral;
