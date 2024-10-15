----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/15/2024 04:14:26 PM
-- Design Name: 
-- Module Name: alu_4bits - Behavioral
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

entity alu_4bits is
    generic(N: integer:=4);
    port( 
    op: in std_logic_vector(1 downto 0);
    n1, n2: in signed(N-1 downto 0);  
      
    error: out std_logic;
    salida_signo_magnitud: out signed(N downto 0)
    );
end alu_4bits;

architecture Behavioral of alu_4bits is
    -- Control
    signal en_mult, en_igual, en_sum: std_logic:= '1';
    -- Conversiones
    signal c2_1, c2_2: signed(n-1 downto 0);
    -- Resultados 
    signal resultado_calculadora: signed(N downto 0);
    signal salida_signo_magnitud_aux: signed(N downto 0);
begin
    --- Obtengo complemento 2  de ambos números
    MyS_2_C2_inst_1: entity work.MyS_2_C2 
        generic map(N=>N)
        port map(mag_y_signo => n1, c2 => c2_1);
        
    MyS_2_C2_inst_2: entity work.MyS_2_C2 
        generic map(N=>N)
        port map(mag_y_signo => n2, c2 => c2_2);

    -- Calculo Salida
    calculadora_elemental_inst: entity work.calculadora_elemental 
        generic map(N=>N)
        port map(
        n1_c2 => c2_1, 
        n2_c2 => c2_2,
        op => op,
        salida => resultado_calculadora,
        error => error
        );

   -- Covierto Devuelta a Signo y magnitud 
   C2_to_SignMag: entity work.MyS_2_C2 
        generic map(N=>5)
        port map(mag_y_signo => resultado_calculadora, c2 => salida_signo_magnitud_aux);
    
   -- No tengo que convertir si es para igualar 
   with op select
      salida_signo_magnitud <= resultado_calculadora when "11",
                salida_signo_magnitud_aux when others;
			
			
end Behavioral;
