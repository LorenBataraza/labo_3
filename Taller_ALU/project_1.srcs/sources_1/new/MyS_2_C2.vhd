library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MyS_2_C2 is
    generic(N: integer:=4);  -- N es el número de bits, incluyendo el bit de signo
    Port ( mag_y_signo : in signed(N-1 downto 0);
           c2 : out signed(N-1 downto 0));
end MyS_2_C2;

architecture Behavioral of MyS_2_C2 is
    signal aux: signed(N-2 downto 0);
begin
    -- Compruebo si el número es cero
    c2(N-1) <= '0' when unsigned(mag_y_signo(N-2 downto 0)) = 0 else 
            mag_y_signo(N-1);
    
    -- Cálculo del complemento a 2
    aux <= signed(not(mag_y_signo(N-2 downto 0))) + 1;

    -- Asignación final del resultado
    c2(N-2 downto 0) <= mag_y_signo(N-2 downto 0) when mag_y_signo(N-1) = '0' 
        else aux;
end Behavioral;
