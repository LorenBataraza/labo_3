----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/20/2024 02:34:23 PM
-- Design Name: 
-- Module Name: alu_test - Behavioral
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

entity alu_test is

--  Port ( );
end alu_test;

architecture Behavioral of alu_test is  
   constant N: integer:=4;
   signal op:  std_logic_vector(1 downto 0);
   signal n1, n2:  signed(N-1 downto 0);
   signal salida: signed(N downto 0);
   signal error: std_logic;
   
begin

alu_4bits_inst: entity work.alu_4bits
    generic map(N=>N)
    port map(op=>op, salida_signo_magnitud=>salida, 
    error=>error, n1=>n1 , n2=>n2
    );
                      
    stim_proc: process
    begin
    -- Agrego los test que me dice el tp
    
    -- OPS: 
    -- "00" SUMA
    -- "01" RESTA
    -- "00" PRODUCTO
    -- "00" IGUALDAD
    
    --a) 5 + 2 = 7 //  0101 + 0010 => 00111
    op <="00"; n1<="0101"; n2<="0010";
    wait for 1 ns; 
    assert salida <= "00111" and error<='0' report "Salida Mala" severity failure;
    
    --b) 4 - 5 = -1 //  0100 - 0101 => 01111
    op <="01"; n1<="0100"; n2<="0101";
    wait for 1 ns; 
    assert salida = "10001" and error ='0' report "Salida Mala" severity failure;
    
    --c) -2 - 3 = -5 //  1010 + 1011 => 11011
    op <="01"; n1<="1010"; n2<="0011";
    wait for 1 ns; 
    assert salida = "10101" and error ='0' report "Salida Mala" severity failure;
    
    --d) 3 * 2 = 6 //  0011 + 0010 => 0110
    op <="10"; n1<="0011"; n2<="0010";
    wait for 1 ns; 
    assert salida = "00110" and error ='0' report "Salida Mala" severity failure;
    
    --- CHEQUEAR
    --e) -4 * -3 = 12 
    op <="10"; n1<="1100"; n2<="1011";
    wait for 1 ns; 
    assert salida = "01100" and error ='0' report "Salida Mala" severity failure;
    
    --f) 4 * 7 =  //  1010 * 1011 => ERROR 
    op <="10"; n1<="0100"; n2<="0111";
    wait for 1 ns; 
    assert error='1' report "Salida Mala" severity failure;
    
    --g) 1=7 //  0001 + 0111 => 00001
    op <="11"; n1<="0001"; n2<="0010";
    wait for 1 ns; 
    assert salida = "00000" and error='0' report "Salida Mala" severity failure;
    
    --h) 6=6  //  1100 + 0010 => 11111
    op <="11"; n1<="1110"; n2<="1110";
    wait for 1 ns; 
    assert salida = "11111" and error='0' report "Salida Mala" severity failure;
    
    
    assert false report "Simulación terminó OK" severity failure;
    wait;
    end process;
    
end Behavioral;
