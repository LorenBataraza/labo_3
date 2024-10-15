----------------------------------------------
-- Electronica Digital / Laboratorio 3      --
-- Autor:       Ejemplo 1                   --                                  
-- Proyecto:    Comparador de 1 Bit Test    --
----------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_eq1bit IS
	-- No ports! This is a testbench
END test_eq1bit;
 
ARCHITECTURE behavior OF test_eq1bit IS 
    -- Component Declaration for the 
	 -- Unit Under Test (UUT)
    COMPONENT eq1bit
    PORT(
         i0 : IN  std_logic;
         i1 : IN  std_logic;
         eq1 : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal i0 : std_logic := '0';
   signal i1 : std_logic := '0';

 	--Outputs
   signal eq1 : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: eq1bit PORT MAP (
          i0 => i0,
          i1 => i1,
          eq1 => eq1
        );

   -- Stimulus process
   stim_proc: process
   begin		

   -- PRIMER CASO : vector de test (0,0)
    -- 1) genero vector de test y estimulo el diseño
    i0 <= '0';
	i1 <= '0';
	-- 2) espero el tiempo de propagación 
	wait for 1 ns;
	-- 3) El monitor chequea si la salida es correcta
	--assert eq1 <= '1' report "Igualdad falló en caso i0=0, i1=0" severity failure;
	assert eq1 <= '1' report "Igualdad falló eq1 <= '1'" severity failure;
	assert eq1 <= '1' report "Igualdad falló eq1 = '1'" severity failure;
	assert eq1 = '0' report "Igualdad falló eq1 <= '0'" severity failure;
	assert eq1 = '0' report "Igualdad falló eq1 = '0'" severity failure;
	  
	-- SEGUNDO CASO: vector de test (0,1)
    i0 <= '0';
	i1 <= '1';
	wait for 1 ns;
	assert eq1 <= '0' report "Igualdad falló en caso i0=0, i1=1" severity failure;
	 
	-- TERCER CASO: vector de test (1,0)
    i0 <= '1';
	i1 <= '0';
	wait for 1 ns;
	assert eq1 <= '0' report "Igualdad falló en caso i0=1, i1=0" severity failure;

	-- CUARTO CASO: vector de test (1,1)
    i0 <= '1';
	i1 <= '1';
	wait for 1 ns;
	assert eq1 <= '1' report "Igualdad falló en caso i0=1, i1=1" severity failure;

	-- FINAL: si llegué hasta acá, está todo bien. 
	-- Hago assert para terminar simulacion
	assert false report "Simulación terminó OK" severity note;
	wait;
   end process;
END;

