------------------------------------------
-- Electronica Digital / Laboratorio 3  --
-- Autor:       Ejemplo 1               --                                  
-- Proyecto:    Comparador de 1 Bit     --
------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eq1bit is
	
	port (
		i0,i1: in std_logic;
		eq1:  out std_logic
	);
end eq1bit;

architecture Behavioral of eq1bit is
	signal p0,p1:std_logic;

begin
	-- suma de dos productos
	eq1 <= p0 or p1;
	-- terminos producto
	p0 <= (not i0) and (not i1);
	p1 <= i0 and i1;
	
end Behavioral;


