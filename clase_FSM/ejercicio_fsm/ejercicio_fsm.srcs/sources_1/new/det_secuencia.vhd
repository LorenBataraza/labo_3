----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/03/2024 03:35:53 PM
-- Design Name: 
-- Module Name: det_secuencia - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity det_secuencia is
    Port ( clk: in std_logic; 
           reset: in std_logic;
           entrada : in STD_LOGIC;
           salida : out STD_LOGIC);
end det_secuencia;

architecture Behavioral of det_secuencia is
    type estados is (inicial, uno, uno_cero, uno_cero_uno);
    signal state_reg, state_next: estados;
begin  

    -- Registro Proceso
    process(clk, reset)
    begin
        if (reset = '1') then
            state_reg <= inicial;
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
        end if;
    end process;
        
    -- Log Cambio de Estado
    process(state_reg, entrada)
    begin
        state_next <= state_reg; -- default
        case state_reg is
            when inicial =>
                if entrada = '1' then
                    state_next <= uno;
                end if;
                
            when uno =>
                if entrada = '0' then 
                    state_next <= uno_cero;
                end if;
                
            when uno_cero =>
                if entrada = '1' then
                    state_next <= uno_cero_uno; else
                    state_next <= inicial;
                end if;
                
           when uno_cero_uno =>
                if entrada = '1' then
                    state_next <= uno; else
                    state_next <= uno_cero;
                end if;
             
        end case;
    end process;
    
    --- Log output 
    process(state_reg)
    begin
        case state_reg is
            when uno_cero_uno =>
                salida<= '1';
            when others =>
                salida <= '0';
        end case;
    end process;


end Behavioral;
