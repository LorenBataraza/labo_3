----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/21/2024 11:39:43 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    port(
        clk, reset: in std_logic;
        an: out std_logic_vector(3 downto 0);
        sseg: out std_logic_vector(7 downto 0)
    );
end top;

architecture Behavioral of top is
    signal n0: std_logic_vector (3 downto 0) := "1010";
    signal n1: std_logic_vector (3 downto 0) := "1011";
    signal n2: std_logic_vector (3 downto 0) := "1100";
    signal n3: std_logic_vector (3 downto 0) := "1101";

    signal display_n0: STD_LOGIC_vector (7 downto 0);
    signal display_n1: STD_LOGIC_vector (7 downto 0);
    signal display_n2: STD_LOGIC_vector (7 downto 0);
    signal display_n3: STD_LOGIC_vector (7 downto 0);
    
 
begin

    counter_inst_n0: entity work.cod_7_seg
        port map(
        num => n0, codigo_display => display_n0, punto => '0'
        );
        
   cod_inst_n1: entity work.cod_7_seg
        port map(
        num => n1, codigo_display => display_n1, punto => '0'
        );
        
   cod_inst_n2: entity work.cod_7_seg
        port map(
        num => n2, codigo_display => display_n2, punto => '0'
        );
        
   cod_inst_n3: entity work.cod_7_seg
        port map(
        num => n3, codigo_display => display_n3, punto => '0'
        );    
        
    mux_inst: entity work.disp_mux
        port map(
        clk => clk , reset=> reset,
        in3=>display_n3 , in2=>display_n2 , 
        in1=> display_n1, in0=>display_n0,
        an=> an,
        sseg => sseg
        );    
        
end Behavioral;
