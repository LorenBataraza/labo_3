------------------------------------------
-- Electronica Digital / Laboratorio 3  --
-- Autor:       Ejemplo 2               --                                  
-- Proyecto:    Comparador de 2 Bit     --
------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eq2bit_composite is
	port(
		a,b: in std_logic_vector(1 downto 0);
		aeqb: out std_logic
	);
end eq2bit_composite;

architecture struct_arch of eq2bit_composite is
	signal e0, e1 : std_logic;
begin
	-- instanciamos dos comparadores de 1 bit
	eq_bit0_unit: entity work.eq1bit(Behavioral)
		port map(i0 => a(0), i1 => b(0), eq1 => e0);
		
	eq_bit1_unit: entity work.eq1bit(Behavioral)
		port map(i0 => a(1), i1 => b(1), eq1 => e1);
		
	-- a y b son iguales si sus bits individuales
   --	son iguales
	aeqb <= e0 and e1;

end struct_arch;



