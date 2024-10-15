----------------------------------------------
-- Electronica Digital / Laboratorio 3      --
-- Autor:       Ejemplo 2                   --                                  
-- Proyecto:    Comparador de 2 Bit - Test  --
----------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY eq2bit_test IS
	-- No ports! This is a testbench
END eq2bit_test;
 
ARCHITECTURE behavior OF eq2bit_test IS 

   --Inputs
   signal test_in0, test_in1 : std_logic_vector(1 downto 0) := (others => '0');
   signal test_out : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.eq2bit_composite PORT MAP (
          a => test_in0,
          b => test_in1,
          aeqb => test_out
        );

   -- Stimulus process
   stim_proc: process
   begin	
      wait for 10 ns;	
		-- test_vector 0
		test_in0 <= "00";
		test_in1 <= "00";
		wait for 10 ns;
		
		assert test_out <= '1' report "Fallo en vector de test 0" severity FAILURE;
		
		-- test_vector 1
		test_in0 <= "00";
		test_in1 <= "01";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 1" severity FAILURE;
	
		-- test_vector 2
		test_in0 <= "00";
		test_in1 <= "10";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 2" severity FAILURE;
      

		-- test_vector 3
		test_in0 <= "00";
		test_in1 <= "11";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 3" severity FAILURE;


		-- test_vector 4
		test_in0 <= "01";
		test_in1 <= "00";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 4" severity FAILURE;


		-- test_vector 5
		test_in0 <= "01";
		test_in1 <= "01";
		wait for 10 ns;
		
		assert test_out <= '1' report "Fallo en vector de test 5" severity FAILURE;


		-- test_vector 6
		test_in0 <= "01";
		test_in1 <= "10";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 6" severity FAILURE;

		-- test_vector 7
		test_in0 <= "01";
		test_in1 <= "11";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 7" severity FAILURE;


		-- test_vector 8
		test_in0 <= "10";
		test_in1 <= "00";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 8" severity FAILURE;

		-- test_vector 9
		test_in0 <= "10";
		test_in1 <= "01";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 9" severity FAILURE;
		
		-- test_vector 10
		test_in0 <= "10";
		test_in1 <= "10";
		wait for 10 ns;
		
		assert test_out <= '1' report "Fallo en vector de test 10" severity FAILURE;

        -- test_vector 11
		test_in0 <= "10";
		test_in1 <= "11";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 11" severity FAILURE;
		
		-- test_vector 12
		test_in0 <= "11";
		test_in1 <= "00";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 12" severity FAILURE;
		
		-- test_vector 13
		test_in0 <= "11";
		test_in1 <= "01";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 13" severity FAILURE;
		
		-- test_vector 14
		test_in0 <= "11";
		test_in1 <= "10";
		wait for 10 ns;
		
		assert test_out <= '0' report "Fallo en vector de test 14" severity FAILURE;
		
		-- test_vector 15
		test_in0 <= "11";
		test_in1 <= "11";
		wait for 10 ns;
		
		assert test_out <= '1' report "Fallo en vector de test 15" severity FAILURE;
		
		-- si llegu  hasta ac , esta OK
		assert false report "Tests OK!" severity NOTE;
        wait;
   end process;

END;
