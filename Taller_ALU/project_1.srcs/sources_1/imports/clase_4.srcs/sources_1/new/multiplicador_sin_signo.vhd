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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplicador_sin_signo is
    generic(N: integer:= 4);
    port(
    enable: in std_logic;
    a,b: in std_logic_vector(N-1 downto 0);
    salida: out std_logic_vector (N downto 0);
    error: out std_logic
    );
end multiplicador_sin_signo;

architecture Behavioral of multiplicador_sin_signo is
     
    constant MAX_INT: integer := 2**N;
    signal producto: signed(2*N-1 downto 0);
    
begin
    
    producto <= signed(a)*signed(b);
    
    salida <= std_logic_vector(producto(N downto 0));
    
    -- En este caso tengo problemas si sale de [-2^(N), 2^(N)] 
    error <= '1' when ( (producto<(-MAX_INT)) or producto>MAX_INT )else
             '0'; 
    
end Behavioral;
