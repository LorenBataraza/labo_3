----------------------------------------------------------------------------------
-- Institution: Instituto Balseiro
-- Dev:         Jose Quinteros del Castillo
--
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: PicoBlaze Example
--
-- Dependencies: None.
--
-- Revision: 2023-08-11
-- Additional Comments:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity picoblaze_example_top is
  port (
    clk       : in std_logic;
    rst       : in std_logic;
    in_switch : in std_logic_vector(7 downto 0);
    in_control: in std_logic_vector(3 downto 0); 
    out_led   : out std_logic_vector(7 downto 0);
    an_0: out std_logic_vector(3 downto 0);
    sseg_0: out std_logic_vector(7 downto 0)
    );
end entity picoblaze_example_top;

architecture rtl of picoblaze_example_top is

  -------------------------------------------------------------------------------------------
  -- Signals
  -------------------------------------------------------------------------------------------
  --

  --
  -- Signals for connection of KCPSM6 and Program Memory.
  --

  signal address : std_logic_vector(11 downto 0);
  signal instruction : std_logic_vector(17 downto 0);
  signal bram_enable : std_logic;
  signal in_port : std_logic_vector(7 downto 0);
  signal out_port : std_logic_vector(7 downto 0);
  signal port_id : std_logic_vector(7 downto 0);
  signal write_strobe : std_logic;
  signal kcpsm6_reset : std_logic;
  signal rdl : std_logic;
  
  -- Display 
  signal out_led_aux: std_logic_vector(7 downto 0);
  signal display_n0:  std_logic_vector(7 downto 0);
  signal display_n1:  std_logic_vector(7 downto 0);
  
begin
  -----------------------------------------------------------------------------------------
  -- Instantiate KCPSM6 and connect to Program Memory
  -----------------------------------------------------------------------------------------
  --
  -- The KCPSM6 generics can be defined as required but the default values are shown below
  -- and these would be adequate for most designs.
  --

  processor : entity work.kcpsm6
    generic map(
      hwbuild                 => X"00",
      interrupt_vector        => X"3FF",
      scratch_pad_memory_size => 64)
    port map(
      address        => address,
      instruction    => instruction,
      bram_enable    => bram_enable,
      port_id        => port_id,
      write_strobe   => write_strobe,
      k_write_strobe => open,
      out_port       => out_port,
      read_strobe    => open,
      in_port        => in_port,
      interrupt      => '0',
      interrupt_ack  => open,
      sleep          => '0',
      reset          => kcpsm6_reset,
      clk            => clk);

  --
  -- The default Program Memory recommended for development.
  --
  -- If your design also needs to be able to reset KCPSM6 the arrangement below should be
  -- used to 'OR' your signal with 'rdl' from the program memory.
  --

  program_rom : entity work.test --Name to match your PSM file
    generic map(
      C_FAMILY             => "7S", --Family 'S6', 'V6' or '7S'
      C_RAM_SIZE_KWORDS    => 1,    --Program size '1', '2' or '4'
      C_JTAG_LOADER_ENABLE => 0)    --Include JTAG Loader when set to '1'
    port map(
      address     => address,
      instruction => instruction,
      enable      => bram_enable,
      rdl         => rdl,
      clk         => clk);

  kcpsm6_reset <= rst or rdl;
  --
  -----------------------------------------------------------------------------------------
  -- General Purpose Input Ports.
  -----------------------------------------------------------------------------------------
  --
  --
  -- The inputs connect via a pipelined multiplexer. For optimum implementation, the input
  -- selection control of the multiplexer is limited to only those signals of 'port_id'
  -- that are necessary. In this case, only 2-bits are required to identify each of
  -- four input ports to be read by KCPSM6.
  --
  -- Note that 'read_strobe' only needs to be used when whatever supplying information to
  -- KPPSM6 needs to know when that information has been read. For example, when reading
  -- a FIFO a read signal would need to be generated when that port is read such that the
  -- FIFO would know to present the next oldest information.
  --

  input_ports : process (clk)
  begin
    if (rising_edge(clk)) then

      case port_id(1 downto 0) is

          -- Read input_port_a at port address 00 hex
        when "00" => in_port <= in_switch;

          --   -- Read input_port_b at port address 01 hex
          -- when "01" => in_port <= input_port_b;

          --   -- Read input_port_c at port address 02 hex
          when "10" => in_port <= "0000" & in_control;

          --   -- Read input_port_d at port address 03 hex
          -- when "11" => in_port <= input_port_d;

          -- To ensure minimum logic implementation when defining a multiplexer always
          -- use don't care for any of the unused cases (although there are none in this
          -- example).

        when others => in_port <= "XXXXXXXX";

      end case;

    end if;

  end process input_ports;
  --
  -----------------------------------------------------------------------------------------
  -- General Purpose Output Ports
  -----------------------------------------------------------------------------------------
  --
  --
  -- Output ports must capture the value presented on the 'out_port' based on the value of
  -- 'port_id' when 'write_strobe' is High.
  --
  -- For an optimum implementation the allocation of output ports should be made in a way
  -- that means that the decoding of 'port_id' is minimised. Whilst there is nothing
  -- logically wrong with decoding all 8-bits of 'port_id' it does result in a function
  -- that can not fit into a single 6-input look up table (LUT6) and requires all signals
  -- to be routed which impacts size, performance and power consumption of your design.
  -- So unless you really have a lot of output ports it is best practice to use 'one-hot'
  -- allocation of addresses as used below or to limit the number of 'port_id' bits to
  -- be decoded to the number required to cover the ports.
  --
  -- Code examples in which the port address is 04 hex.
  --
  -- Best practice in which one-hot allocation only requires a single bit to be tested.
  -- Supports up to 8 output ports with each allocated a different bit of 'port_id'.
  --
  --   if port_id(2) = '1' then output_port_x <= out_port;
  --
  --
  -- Limited decode in which 5-bits of 'port_id' are used to identify up to 32 ports and
  -- the decode logic can still fit within a LUT6 (the 'write_strobe' requiring the 6th
  -- input to complete the decode).
  --
  --   if port_id(4 downto 0) = '00100' then output_port_x <= out_port;
  --
  --
  -- The 'generic' code may be the easiest to write with the minimum of thought but will
  -- result in two LUT6 being used to implement each decoder. This will also impact
  -- performance and power. This is not generally a problem and hence it is reasonable to
  -- consider this as over attention to detail but good design practice will often bring
  -- rewards in the long term. When a large design struggles to fit into a given device
  -- and/or meet timing closure then it is often the result of many small details rather
  -- that one big cause. PicoBlaze is extremely efficient so it would be a shame to
  -- spoil that efficiency with unnecessarily large and slow peripheral logic.
  --
  --   if port_id = X"04" then output_port_x <= out_port;
  --
    
    
  -- Mapeo 
  cod_inst_n0: entity work.cod_7_seg
        port map(
        num => out_led_aux(3 downto 0), codigo_display => display_n0, punto => '0'
        );  
  cod_inst_n1: entity work.cod_7_seg
        port map(
        num => out_led_aux(7 downto 4), codigo_display => display_n1, punto => '0'
        );
  
  
  disp_mux_0: entity work.disp_mux
    port map(
    clk => clk , 
    reset=> rst,
    in0=>"11111111",
    in1=>"11111111",
    in2=>display_n0,
    in3=>display_n1,
    an=> an_0,
    sseg => sseg_0
    );  
    
   out_led <= out_led_aux;
   
  output_ports : process (clk)
  begin

    if (rising_edge(clk)) then

      -- 'write_strobe' is used to qualify all writes to general output ports.
      if write_strobe = '1' then

        -- Write to output_port_w at port addrress 01 hex
        if port_id(0) = '1' then
          out_led_aux <= out_port;
        end if;
                
        -- -- Write to output_port_x at port address 02 hex
        -- if port_id(1) = '1' then
        --   output_port_x <= out_port;
        -- end if;

        -- -- Write to output_port_y at port address 04 hex
        -- if port_id(2) = '1' then
        --   output_port_y <= out_port;
        -- end if;

        -- -- Write to output_port_z at port address 08 hex
        -- if port_id(3) = '1' then
        --   output_port_z <= out_port;
        -- end if;

      end if;

    end if;

  end process output_ports;

end architecture rtl;
