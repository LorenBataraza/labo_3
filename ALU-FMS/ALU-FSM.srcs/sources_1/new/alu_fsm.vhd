----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/10/2024 03:05:51 PM
-- Design Name: 
-- Module Name: alu_fsm - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.sdp_ram_pkg.all;

entity alu_fsm is
    Port ( 
    clk: in std_logic;
    error_out: out std_logic;

    -- Entradas Placa 
    op_sel: in std_logic_vector(1 downto 0);
    op_addr0: in ram_addr_t;
    op_addr1: in ram_addr_t;
    op_addrres: in ram_addr_t;
    
    -- Señales Control 
    sys_rst: in std_logic;
    op_en: in std_logic;
    
    -- RAM WRITE
    wr_en    : out std_logic;
    wr_addr  : out ram_addr_t;
    wr_data  : out ram_data_t;
    
    -- RAM READ
    rd_en    : out std_logic;
    rd_addr  : out ram_addr_t;
    rd_data : in ram_data_t
    
    );
end alu_fsm;

architecture Behavioral of alu_fsm is
    constant MAX_INT: integer := (2**MEM_WIDTH)-1;
    
    -- Señales ALU 
    signal op_sel_in : std_logic_vector(1 downto 0);
    signal result_alu: std_logic_vector(MEM_WIDTH downto 0);
    signal error_alu :std_logic;
    signal sig_error  :std_logic;

    -- Señales Registros 
    signal q0, q1: std_logic_vector(MEM_WIDTH - 1 downto 0);
    signal en_dff0, en_dff1: std_logic;
    
    -- Estados
    type estados is (ESPERA, LEER0, GUARDAR0 , LEER1, GUARDAR1 , CALCULO, ESCRITURA, ERROR);
    signal state_reg, state_next: estados:= ESPERA;
    
begin

    -- Creo dos Registros
    ddf_inst0: entity work.d_ff
    generic map(N => MEM_WIDTH)
    port map(clk => clk,
           reset => sys_rst,
           d => rd_data,
           q => q0,
           en => en_dff0);
    
    -- Creo dos Registros
    ddf_inst1: entity work.d_ff
    generic map(N => MEM_WIDTH)
    port map(clk => clk,
           reset => sys_rst,
           d => rd_data,
           q => q1,
           en => en_dff1);  

    alu_inst: entity work.alu_top
    port map(
    op0_in => q0,
    op1_in => q1, 
    op_sel_in => op_sel, 
    result_out => result_alu,
    error_out => error_alu
    );
    -- Se pasa del valor si el bit -x----
    sig_error <= '1' when result_alu(MEM_WIDTH-1)='1'
            else '0';
    
    -- Registro Proceso
    process(clk, sys_rst)
    begin
        if (sys_rst = '1') then
            state_reg <= ESPERA;
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
        end if;
    end process;

    -- Log Cambio de Estado
    process(state_reg, op_en, sig_error )
    begin
        state_next <= state_reg; -- default
        case state_reg is
            when ESPERA =>
                if op_en = '1' then
                    state_next <= LEER0;
                end if;
            when LEER0 =>
                state_next <= GUARDAR0;
            when GUARDAR0 =>
                state_next <= LEER1;
            when LEER1 => 
                state_next <= GUARDAR1;
            when GUARDAR1 => 
                state_next <= CALCULO;        
            when CALCULO => 
                if sig_error  = '1' then 
                    state_next <= ERROR;
                else 
                    state_next <= ESCRITURA;
                end if;
            when ESCRITURA =>
                state_next <= ESPERA; 
            when ERROR =>
                if op_en = '1' then
                    state_next <= LEER0;
                end if;
            when others =>
                state_next <= state_reg; -- default
        end case;
    end process; 
    
    -- Log SALIDAS Y SEÑALES DE CONTROL
    process(state_reg, sys_rst)
    begin
        wr_en <= '0';
        rd_en <= '0';
        en_dff0 <= '0';
        en_dff1 <= '0';
         -- Error out de arranque es 0
        if sys_rst= '1'  then
            error_out <= '0';
        end if; 
            
        case state_reg is
            when LEER0 =>
                rd_en <= '1';
                rd_addr <= op_addr0;
            when GUARDAR0 =>
                en_dff0 <= '1';
            when LEER1 => 
                rd_en <= '1';
                rd_addr <= op_addr1;
            when GUARDAR1 => 
                en_dff1 <= '1';
                error_out <= '0';
            when ESCRITURA =>
                wr_en <= '1';
                wr_addr <= op_addrres;
                wr_data <= result_alu(MEM_WIDTH) & result_alu(MEM_WIDTH-2 downto 0); 
            when ERROR =>
                    error_out <= '1';
            when others =>
                -- VAlores Default
                wr_en <= '0';
                rd_en <= '0';
                en_dff0 <= '0';
                en_dff1 <= '0';
                error_out <= '0';
                  
        end case;
    end process;
    
end Behavioral;
