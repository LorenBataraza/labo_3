----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/15/2024 04:22:13 PM
-- Design Name: 
-- Module Name: mux_5canales - Behavioral
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

entity calculadora_elemental is
generic(N: integer:=4);
Port(
    n1_c2: in signed(N-1 downto 0);
    n2_c2: in signed(n-1 downto 0);
    op: in std_logic_vector(1 downto 0);
    salida: out signed(n downto 0);
    error : out std_logic
    );
end calculadora_elemental;


architecture Behavioral of calculadora_elemental is
    SIGNAL n1_c2_ext, n2_c2_ext : signed(2*n-1 downto 0); 
    constant MAX_INT: integer := (2**N)-1;
    signal salida_extendida : signed(2*n-1 downto 0);
    signal chequeo_maximo: signed(n downto 0);  
begin   
 
    n1_c2_ext(2*N-1 downto N) <= (others => n1_c2(n-1));
    n1_c2_ext(N-1 downto 0) <= n1_c2;
    
    n2_c2_ext(2*N-1 downto N) <= (others => n2_c2(n-1));
    n2_c2_ext(N-1 downto 0) <= n2_c2;
    
    salida_extendida <=  n1_c2*n2_c2 when op="10" else
             n1_c2_ext+n2_c2_ext when op="00" else
             n1_c2_ext-n2_c2_ext when op="01" else 
             (others => '1') when  op="11" and n1_c2=n2_c2 else
             (others => '0');
             
    salida <= salida_extendida(n downto 0);
    chequeo_maximo <= salida_extendida(n downto 0);
    
    error <= '1' when ((salida_extendida<(-MAX_INT) or salida_extendida>MAX_INT))
                else '0'; 
        
end Behavioral;