library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_add_w_carry is
    generic(N: integer:=4);
    port(
        a, b: in signed(N-1 downto 0);
        cout: out std_logic;
        sum: out signed(N downto 0);
        enable: in std_logic
    );
end gen_add_w_carry;
architecture arch of gen_add_w_carry is

begin
   
    sum <= (others => 'Z') when enable='0' else 
           a+b; -- Alta imp si no esta prendido
           
end arch;