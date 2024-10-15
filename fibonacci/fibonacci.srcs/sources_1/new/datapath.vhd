----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2024 03:53:48 PM
-- Design Name: 
-- Module Name: datapath - Behavioral
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

entity datapath is
    generic(N: integer := 4);
    Port ( i : in unsigned(N-1 DOWNTO 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           fib: out unsigned(N-1 DOWNTO 0);
           done_tick: out STD_LOGIC;
           ready: out STD_LOGIC
           );
end datapath;


architecture Behavioral of datapath is
    -- Defino Estados
    type estados is (espera, calculando, terminado);
    signal state_reg: estados := espera;
    signal next_state: estados;
    
    signal d1, q1: unsigned(N-1 DOWNTO 0);
    signal d2, q2: unsigned(N-1 DOWNTO 0);
    signal d_cont, q_cont: unsigned(N-1 DOWNTO 0);
    signal suma: unsigned(N-1 DOWNTO 0);

    signal q_cont_ult: std_logic;
    
    -- 
    signal sig_done_tick: std_logic;
    signal sig_ready: std_logic;

begin

    -- Defino los dos registros
    dff_1: entity work.d_ff  
    generic map(N=>N)
    Port map(
    clk => clk,
    reset => '0',
    d => d1,
    q => q1,
    en => '1' 
    );
    
    dff_2: entity work.d_ff
    generic map(N=>N)
    Port map(
    clk => clk,
    reset => '0',
    d => d2,
    q => q2,
    en => '1' 
    );
    
    -- Tomo el último bit del contador 
    -- como el clock de los bloques suma
    q_cont_ult <= q_cont(0);
  
    -- Control de Suma
    suma <= q1 + q2;
    
    d1 <= TO_UNSIGNED(0,N) when reset='1' else
           q1 when clk='1'else
           suma;
   
    d2 <= TO_UNSIGNED(1,N) when reset='1' else
           q2 when clk='0'else
           suma;
   
   -- Contador
   dff_cont: entity work.d_ff
   generic map(N=>N)
    Port map(
    clk => clk,
    reset => reset,
    d => d_cont,
    q => q_cont,
    en => '1' 
    );
    
    d_cont <= (others => '0') when (reset or start)='1' else
               q_cont+1;
    
    -- Logica - Salidas
    fib <=suma;
    sig_ready <= '1' when (q_cont = 0) else '0';
    sig_done_tick <= '1' when (q_cont = i) else '0';


    -- Logica de actualizacion de estado
    process (clk, reset)
    begin
        if reset='1' then
            state_reg <= espera;
        elsif (clk'event and clk='1') then
            state_reg <= next_state;
        end if;
    end process;
    
    -- Logica Cambio de Estado
    process(state_reg, start, sig_done_tick)
    begin
        next_state <= state_reg;
        case state_reg is 
            when espera =>
                if(start= '1') then
                next_state <= calculando;
                end if;
            when calculando =>
                if(sig_done_tick = '1') then
                next_state <= terminado;
                end if;
            when terminado =>
                next_state <= espera;
        end case;   
    end process;
    
    -- Logica de salida 
    process(state_reg)
    begin
        done_tick <= '0';
        ready <= '0';
        case state_reg is 
            when espera =>
                ready <= '1';
            when terminado =>
                done_tick <= '1';
            when calculando => 
                ready <= '0';
        end case;
    end process;
    
end Behavioral;
