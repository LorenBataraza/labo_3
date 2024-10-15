----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: Input conditioning
--
-- Dependencies: None.
--
-- Revision: 2024-09-08
-- Additional Comments:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.sdp_ram_pkg.all;

entity input_conditioning is
  generic (
    SIM_ONLY : std_logic := '0'
  );
  port (
    sys_clk_in     : in std_logic;

    buttons_in     : in std_logic_vector(3 downto 0);
    switches_in    : in std_logic_vector(7 downto 0);

    sys_rst_out    : out std_logic;

    poke_addr_out  : out ram_addr_t;
    poke_data_out  : out ram_data_t;
    poke_en_out    : out std_logic;

    peek_addr_out  : out ram_addr_t;
    peek_en_out    : out std_logic;

    op_sel_out     : out std_logic_vector(1 downto 0);
    op_addrres_out : out ram_addr_t;
    op_addr0_out   : out ram_addr_t;
    op_addr1_out   : out ram_addr_t;
    op_en_out      : out std_logic
  );
end entity input_conditioning;

architecture rtl of input_conditioning is
  signal sys_rst : std_logic;
  -- -1 because last button is used for reset
  constant DEBOUNCER_COUNT_MAX : natural := 10_000_000; -- 100M / DEBOUNCER_COUNT_MAX = 0.1s
  constant INPUTS_LENGTH : natural := switches_in'length + buttons_in'length - 1;

  signal inputs : std_logic_vector(INPUTS_LENGTH - 1 downto 0);
  signal inputs_sync : std_logic_vector(INPUTS_LENGTH - 1 downto 0);
  signal inputs_deb : std_logic_vector(INPUTS_LENGTH - 1 downto 0);

  signal switches : std_logic_vector(switches_in'length - 1 downto 0);
  signal buttons : std_logic_vector(buttons_in'length - 2 downto 0);

  signal peek_en : std_logic;
  signal peek_en_reg : std_logic;
  signal poke_en : std_logic;
  signal poke_en_reg : std_logic;
  signal op_en : std_logic;
  signal op_en_reg : std_logic;

begin
  inputs <= switches_in & buttons_in(buttons_in'length - 2 downto 0);

  sim_only_gen : if SIM_ONLY = '1' generate
    switches <= inputs(inputs'length - 1 downto inputs'length - switches'length);
    buttons <= inputs(buttons'length - 1 downto 0);
    sys_rst <= buttons_in(3);
  end generate sim_only_gen;

  impl_gen : if SIM_ONLY = '0' generate

    inputs_conditioning_gen : for I in 0 to inputs'length - 1 generate
      level_synchronizer_inst : entity work.level_synchronizer
        port map(
          sys_clk_in => sys_clk_in,
          sys_rst_in => sys_rst,
          data_in    => inputs(I),
          data_out   => inputs_sync(I)
        );

      debouncer_inst : entity work.debouncer
        generic map(
          COUNT_MAX => DEBOUNCER_COUNT_MAX
        )
        port map(
          sys_clk_in => sys_clk_in,
          sys_rst_in => sys_rst,
          data_in    => inputs_sync(I),
          data_out   => inputs_deb(I)
        );
    end generate inputs_conditioning_gen;

    reset_synchronizer_inst : entity work.reset_synchronizer
      port map(
        sys_clk_in => sys_clk_in,
        ext_rst_in => buttons_in(3),
        rst_out    => sys_rst
      );
    switches <= inputs_deb(inputs_deb'length - 1 downto inputs_deb'length - switches'length);
    buttons <= inputs_deb(buttons'length - 1 downto 0);

  end generate impl_gen;

  sys_rst_out <= sys_rst;
  -- POKE control mapping
  poke_addr_out <= to_integer(unsigned(switches(1 downto 0)));
  poke_data_out <= switches(2 + MEM_WIDTH - 1 downto 2);
  poke_en <= buttons(0);

  -- PEEK control mapping
  peek_addr_out <= to_integer(unsigned(switches(1 downto 0)));
  peek_en <= buttons(1);

  -- OP control mapping
  op_addrres_out <= to_integer(unsigned(switches_in(1 downto 0)));
  op_addr0_out <= to_integer(unsigned(switches_in(3 downto 2)));
  op_addr1_out <= to_integer(unsigned(switches_in(5 downto 4)));
  op_sel_out <= switches_in(7 downto 6);
  op_en <= buttons(2);

  -- rising edge detector: we want a single-shot pulse
  process (sys_clk_in)
  begin
    if rising_edge(sys_clk_in) then
      peek_en_reg <= peek_en;
      peek_en_out <= peek_en and not peek_en_reg;
      poke_en_reg <= poke_en;
      poke_en_out <= poke_en and not poke_en_reg;
      op_en_reg <= op_en;
      op_en_out <= op_en and not op_en_reg;
      if (sys_rst = '1') then
        peek_en_reg <= '0';
        peek_en_out <= '0';
        poke_en_reg <= '0';
        poke_en_out <= '0';
        op_en_reg <= '0';
        op_en_out <= '0';
      end if;
    end if;
  end process;

end architecture rtl;
