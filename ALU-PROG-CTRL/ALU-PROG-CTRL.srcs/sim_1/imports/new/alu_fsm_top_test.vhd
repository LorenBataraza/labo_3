----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/10/2024 05:15:42 PM
-- Design Name: 
-- Module Name: alu_fsm_top_test - Behavioral
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
use work.sdp_ram_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity alu_fsm_top_test is
--  Port ( );
end alu_fsm_top_test;

architecture Behavioral of alu_fsm_top_test is
    constant T_CLK: time:= 10ns;
    -- Tiempos para procesos
    constant T_WAIT_POKE: time:= T_CLK*10;

    signal sys_clk_in  : std_logic;

    signal buttons_in  : std_logic_vector(3 downto 0);
    signal switches_in : std_logic_vector(7 downto 0);

    signal sseg_out    : std_logic_vector(7 downto 0);
    signal an_out      : std_logic_vector(3 downto 0);
    signal error_out   : std_logic;
    
    
begin
    -- Generación de clock
    process
    begin
        sys_clk_in <='0';
        wait for T_CLK/2;
        sys_clk_in <= '1';
        wait for T_CLK/2;
    end process;
    
    alu_fsm_top_inst: entity work.alu_fsm_top
    port map(
        sys_clk_in => sys_clk_in, 
        buttons_in => buttons_in,
        switches_in => switches_in,
        sseg_out => sseg_out,
        an_out => an_out,
        error_out => error_out
    );
    
    
    stim_proc: process
    begin
    -- Default de arranque 
        buttons_in <= "0000";
        switches_in <= "00000000";
        sseg_out <= "00000000";
        an_out <= "0000";
                            
    wait for T_CLK;
    
    -- Compruebo sys_reset
    buttons_in  <= "1000";
    wait for 2*T_CLK;
    
    -------------------------
    -- PROGRAMA 1 : A*B+ C-D
    -------------------------
    -- Compruebo carga de valor
    switches_in <= "00000100"; -- Addr0 <= 1
    buttons_in <= "0001"; -- Toco botón de POKE
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00001001"; -- Addr1 <= 2 
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00010010"; -- Addr2 <= 4
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00100011"; -- Addr3 <= 8
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    -- PRIMER Paso 
    buttons_in <= "0100"; --  PROGRAM STEP
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
    -- SEGUNDO Paso 
    buttons_in <= "0100";
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
     -- TERCER Paso 
    buttons_in <= "0100";
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
    -- ESPERO AL FINAL
    wait for T_CLK*5;
    
    
    
    
    -------------------------
    -- PROGRAMA 2 : A*B+ C*D
    -------------------------
    -- Compruebo carga de valor
    switches_in <= "00000100"; -- Addr0 <= 1
    buttons_in <= "0001"; -- Toco botón de POKE
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00001001"; -- Addr1 <= 2 
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00010010"; -- Addr2 <= 4
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00100011"; -- Addr3 <= 8
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    -- PRIMER Paso 
    buttons_in <= "0100"; --  PROGRAM STEP
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
    -- SEGUNDO Paso 
    buttons_in <= "0100";
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
     -- TERCER Paso 
    buttons_in <= "0100";
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
    -- ESPERO AL FINAL
    wait for T_CLK*5;
    

    -------------------------
    -- PROGRAMA 3 : (A-B) * (C-D)
    -------------------------
    -- Compruebo carga de valor
    switches_in <= "00000100"; -- Addr0 <= 1
    buttons_in <= "0001"; -- Toco botón de POKE
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00001001"; -- Addr1 <= 2 
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00010010"; -- Addr2 <= 4
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    switches_in <= "00100011"; -- Addr3 <= 8
    buttons_in <= "0001";
    wait for T_CLK;
    buttons_in <= "0000";
    wait for T_WAIT_POKE;

    -- PRIMER Paso 
    buttons_in <= "0100"; --  PROGRAM STEP
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
    -- SEGUNDO Paso 
    buttons_in <= "0100";
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
     -- TERCER Paso 
    buttons_in <= "0100";
    wait for 2*T_CLK;
    buttons_in <= "0000";
    wait for T_CLK*10;
    -- ESPERO AL FINAL
    wait for T_CLK*5;
    
    
    
    
    assert false report "Simulación terminó OK" severity failure;
    wait;
    end process;
    
end Behavioral;
