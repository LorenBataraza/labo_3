----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: Program Control
--
-- Dependencies: None.
--
-- Revision: 2024-09-19
-- Additional Comments:
-- This is an instance of a ROM containing a program to be executed by ALU+FSM.
-- It implements a program counter that advances with program_step_in.
-- Operation control signals are taken from the ROM output.
-- Particularly, op_en_out is a delayed version of program_step_in, to account
-- for the read delay to the ROM.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.rom_pkg.all;
use work.sdp_ram_pkg.all;

entity program_control is
  port (
    sys_clk_in      : in std_logic;
    sys_rst_in      : in std_logic;

    program_step_in : in std_logic;

    op_en_out       : out std_logic;
    op_sel_out      : out std_logic_vector(1 downto 0);
    op_addrres_out  : out ram_addr_t;
    op_addr0_out    : out ram_addr_t;
    op_addr1_out    : out ram_addr_t
  );
end entity program_control;

architecture rtl of program_control is
  signal program_counter_reg, program_counter_next : rom_addr_t;
  signal rom_data : rom_data_t;
  signal op_en_reg, op_en_next : std_logic;
begin

  process (sys_clk_in)
  begin
    if rising_edge(sys_clk_in) then
      program_counter_reg <= program_counter_next;
      op_en_reg <= op_en_next;
    end if;
  end process;

  process (program_counter_reg, program_step_in, sys_rst_in)
  begin
    program_counter_next <= program_counter_reg;
    if sys_rst_in = '1' then
      program_counter_next <= 0;
      op_en_next <= '0';
    else
      op_en_next <= program_step_in;
      if program_step_in = '1' then
        program_counter_next <= program_counter_reg + 1;
      end if;
    end if;
  end process;

  rom_inst : entity work.rom
    port map(
      sys_clk_in  => sys_clk_in,
      rd_en_in    => program_step_in,
      rd_addr_in  => program_counter_reg,
      rd_data_out => rom_data
    );

  op_en_out <= op_en_reg;
  op_addrres_out <= to_integer(unsigned(rom_data(1 downto 0)));
  op_addr0_out <= to_integer(unsigned(rom_data(3 downto 2)));
  op_addr1_out <= to_integer(unsigned(rom_data(5 downto 4)));
  op_sel_out <= rom_data(7 downto 6);

end architecture rtl;
