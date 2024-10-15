------------------------------------------
-- Electronica Digital / Laboratorio 3  --
-- Autor:       Ejemplo 2               --                                  
-- Proyecto:    Comparador de 2 Bit     --
------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eq2bit is
	port(
		a,b: in std_logic_vector(1 downto 0);
		aeqb: out std_logic
	);
end eq2bit;

architecture Behavioral of eq2bit is
	signal p0,p1,p2,p3 : std_logic;
begin
	-- suma de productos
	aeqb <= p0 or p1 or p2 or p3;
	-- productos
	p0 <=	(not a(0)) and (not a(1)) and
			(not b(0)) and (not b(1));
	p1 <=	(not a(0)) and a(1) and
			(not b(0)) and b(1);
	p2 <=	 a(0) and (not a(1)) and
			 b(0) and (not b(1));
	p3 <=	 a(0) and a(1) and b(0) and b(1);
end Behavioral;

architecture struct_arch of eq2bit is
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

architecture component_arch of eq2bit is

	-- declaramos los componentes que vamos a usar
	component eq1bit is
		port(
			i0,i1: in std_logic;
			eq1:out std_logic
		);
	end component;
	
	signal e0, e1 : std_logic;
begin
	-- instanciamos dos comparadores de 1 bit
	eq_bit0_unit: eq1bit
		port map(i0 => a(0), i1 => b(0), eq1 => e0);
		
	eq_bit1_unit: eq1bit
		port map(i0 => a(1), i1 => b(1), eq1 => e1);
		
	-- a y b son iguales si sus bits individuales
   --	son iguales
	aeqb <= e0 and e1;

end component_arch;
