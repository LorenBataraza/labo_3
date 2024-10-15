----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/15/2024 04:25:34 PM
-- Design Name: 
-- Module Name: printeo - Behavioral
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

entity printeo is
    port( 
    n1, n2: in signed(3 downto 0);
    op: in std_logic_vector(1 downto 0);
    
    enable_printeo : out std_logic;
    error: out std_logic;
    
    -- 7 Segmentos
    clk, reset: in std_logic;
    -- N0
    an_0: out std_logic_vector(3 downto 0);
    sseg_0: out std_logic_vector(7 downto 0);
    -- N1
    an_1: out std_logic_vector(3 downto 0);
    sseg_1: out std_logic_vector(7 downto 0);
        
    -- LEDS
    -- Numeros a printerar 
    n1_printeo: out std_logic_vector(3 downto 0);
    n2_printeo: out std_logic_vector(3 downto 0);
    -- Operacion
    op_printeo: out std_logic_vector(1 downto 0)
    
    );
    
end printeo;

architecture Behavioral of printeo is
    signal salida_signo_magnitud : signed (4 downto 0);
    signal magnitud_a_printear : STD_LOGIC_vector (3 downto 0);
    signal auxiliar_operacion : STD_LOGIC_vector (3 downto 0);
    
    signal n1_magnitud: STD_LOGIC_vector (3 downto 0);
    signal n2_magnitud: STD_LOGIC_vector (3 downto 0);

    signal display_signo_n1: STD_LOGIC_vector (7 downto 0);
    signal display_n1: STD_LOGIC_vector (7 downto 0);
    signal display_signo_n2: STD_LOGIC_vector (7 downto 0);
    signal display_n2: std_logic_vector (7 downto 0);
    signal display_op: std_logic_vector (7 downto 0);
    signal display_signo_resultado: STD_LOGIC_vector (7 downto 0);
    signal display_resultado: std_logic_vector (7 downto 0);
begin
    -- Mapeo Numeros Signed -> STD_LOGIC
    magnitud_a_printear <= std_logic_vector(salida_signo_magnitud(3 downto 0));
    enable_printeo <= '1';
    n1_printeo <= std_logic_vector(n1);
    n2_printeo <= std_logic_vector(n2);
    op_printeo <= op;
    auxiliar_operacion <= ("00" & op);
   
   -- Alu
   alu_4_bits: entity work.alu_4bits
       port map(op=>op, n1=>n1, n2 => n2,
       error => error, salida_signo_magnitud => salida_signo_magnitud
       );
    
   --- Mapeos Números -> Señal Display
   n1_magnitud <= '0'&std_logic_vector(n1(2 downto 0));
   n2_magnitud <= '0'&std_logic_vector(n2(2 downto 0));

   cod_inst_n1: entity work.cod_7_seg
        port map(
        num => n1_magnitud, codigo_display => display_n1, punto => '0'
        );
   cod_inst_n2: entity work.cod_7_seg
        port map(
        num => n2_magnitud, codigo_display => display_n2, punto => '0'
        );
        
   cod_inst_op: entity work.cod_7_seg
        port map(
        num => auxiliar_operacion, codigo_display => display_op, punto => '0'
        );
           
   cod_inst_resultado: entity work.cod_7_seg
        port map(
        num => magnitud_a_printear , codigo_display => display_resultado, punto => '0'
        );
      
   -- Obtengo señales para signos
    display_signo_n1 <= "10111111" when n1(3)='1' else
                        "11111111";
   
    display_signo_n2 <= "10111111" when n2(3)='1' else
                        "11111111";
    
    display_signo_resultado <= "10111111" when salida_signo_magnitud(4)='1' else
                               "11111111";
    
      
   -- in0: Signo n1, in1: Mangitud n1
   -- in2: Signo n2, in3: Mangitud n2
   disp_mux_0: entity work.disp_mux
    port map(
    clk => clk , reset=> reset,
    in0=>display_signo_n1,
    in1=>display_n1,
    in2=>display_signo_n2,
    in3=>display_n2,
    an=> an_0,
    sseg => sseg_0
    );   
    
    disp_mux_1: entity work.disp_mux
    port map(
    clk => clk , reset=> reset,
    in0=>display_op,
    in1=>"11111111",
    in2=>display_signo_resultado,
    in3=>display_resultado,
    an=> an_1,
    sseg => sseg_1
    );     
    
    
    
end Behavioral;
