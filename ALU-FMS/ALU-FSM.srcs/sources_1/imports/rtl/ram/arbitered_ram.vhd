----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: Arbitered RAM
--
-- Dependencies: None.
--
-- Revision: 2024-09-08
-- Additional Comments:
-- This is an instance of a RAM with two write masters and two read masters.
-- Master 0 takes priority over master 1.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.sdp_ram_pkg.all;

entity arbitered_ram is
  port (
    sys_clk_in   : in std_logic;
    -- from read master 0
    rd0_en_in    : in std_logic;
    rd0_addr_in  : in ram_addr_t;
    rd0_data_out : out ram_data_t;
    -- from read master 1
    rd1_en_in    : in std_logic;
    rd1_addr_in  : in ram_addr_t;
    rd1_data_out : out ram_data_t;
    -- from write master 0
    wr0_en_in    : in std_logic;
    wr0_addr_in  : in ram_addr_t;
    wr0_data_in  : in ram_data_t;
    -- from write master 1
    wr1_en_in    : in std_logic;
    wr1_addr_in  : in ram_addr_t;
    wr1_data_in  : in ram_data_t
  );
end entity arbitered_ram;

architecture rtl of arbitered_ram is
  signal wr_en : std_logic;
  signal wr_addr : ram_addr_t;
  signal wr_data : ram_data_t;
  signal rd_en : std_logic;
  signal rd_addr : ram_addr_t;
  signal rd_data : ram_data_t;
begin

  sdp_ram_inst : entity work.sdp_ram
    port map(
      sys_clk_in  => sys_clk_in,
      wr_en_in    => wr_en,
      wr_addr_in  => wr_addr,
      wr_data_in  => wr_data,
      rd_en_in    => rd_en,
      rd_addr_in  => rd_addr,
      rd_data_out => rd_data
    );

  -- write arbitration
  wr_en <= wr0_en_in or wr1_en_in;
  process (wr0_en_in, wr0_addr_in, wr0_data_in, wr1_addr_in, wr1_data_in)
  begin
    if wr0_en_in = '1' then
      wr_addr <= wr0_addr_in;
      wr_data <= wr0_data_in;
    else
      wr_addr <= wr1_addr_in;
      wr_data <= wr1_data_in;
    end if;
  end process;

  -- read arbitration
  rd_en <= rd0_en_in or rd1_en_in;
  rd_addr <= rd0_addr_in when rd0_en_in = '1' else rd1_addr_in;
  rd0_data_out <= rd_data;
  rd1_data_out <= rd_data;

end architecture rtl;
