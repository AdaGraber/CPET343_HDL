library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity lab5 is
  port (
    in_sw            : in std_logic_vector (7 downto 0);
    in_key           : in std_logic_vector(3 downto 0);
    reset            : in std_logic;
    HEX2, HEX1, HEX0 : out std_logic_vector (6 downto 0);
    CLK_50           : in std_logic;
    LEDR             : out std_logic_vector(3 downto 0)
  );
end entity;

architecture arch of lab5 is
  --signals
  signal key      : std_logic_vector(3 downto 0);
  signal sw       : std_logic_vector(7 downto 0);
  signal a        : std_logic_vector(7 downto 0);
  signal b        : std_logic_vector(7 downto 0);
  signal sum      : std_logic_vector(7 downto 0);
  signal diff     : std_logic_vector(7 downto 0);
  signal disp_num : std_logic_vector(7 downto 0);

  --state machines
  type state_type is (RESTART, input_a, input_b, disp_sum, disp_diff);
  signal present_state, next_state : state_type;

  --components
  component rising_edge_synchronizer is
    port (
      CLOCK_50 : in std_logic;
      reset    : in std_logic;
      async_in : in std_logic_vector(3 downto 0);
      sync_out : out std_logic_vector(3 downto 0)
    );
  end component;

  component synchronizer_8bit is
    port (
      CLOCK_50 : in std_logic;
      reset    : in std_logic;
      async_in : in std_logic_vector(7 downto 0);
      sync_out : out std_logic_vector(7 downto 0)
    );
  end component;

  component bcd_8bit is
    port (
      in_num           : in std_logic_vector(7 downto 0);
      HEX2, HEX1, HEX0 : out std_logic_vector (6 downto 0)
    );
  end component;

  component add_sub_8bit is
    port (
      CLOCK_50 : in std_logic;
      reset    : in std_logic;
      a_in     : in std_logic_vector(7 downto 0);
      b_in     : in std_logic_vector(7 downto 0);
      add_out  : out std_logic_vector (7 downto 0);
      sub_out  : out std_logic_vector (7 downto 0)
    );
  end component;
begin
  --port maps
  sync_switch : synchronizer_8bit
  port map
  (
    CLOCK_50 => CLK_50,
    reset    => reset,
    async_in => in_sw,
    sync_out => sw
  );

  bcd_disp : bcd_8bit
  port map
  (
    in_num => disp_num,
    HEX2   => HEX2,
    HEX1   => HEX1,
    HEX0   => HEX0
  );

  RES : rising_edge_synchronizer
  port map
  (
    CLOCK_50 => CLK_50,
    reset    => reset,
    async_in => in_key,
    sync_out => key
  );

  ALU : add_sub_8bit
  port map
  (
    CLOCK_50 => CLK_50,
    reset    => reset,
    a_in     => a,
    b_in     => b,
    add_out  => sum,
    sub_out  => diff
  );
  --state synchronization
  synch : process (reset, CLK_50)
  begin
    if (reset = '1') then
      present_state <= RESTART;
    elsif (rising_edge(CLK_50)) then
      present_state <= next_state;
    end if;
  end process;

  --state transition logic
  trans : process (present_state, sw)
  begin
    case(present_state) is
      when RESTART =>
      next_state <= input_a;
      when input_a =>
      if (key(0) = '0') then
        next_state <= input_b;
      else
        next_state <= next_state;
      end if;
      when input_b =>
      if (key(1) = '0') then
        next_state <= disp_sum;
      else
        next_state <= next_state;
      end if;
      when disp_sum =>
      if (key(2) = '0') then
        next_state <= disp_diff;
      else
        next_state <= next_state;
      end if;
      when disp_diff =>
      if (key(3) = '0') then
        next_state <= input_a;
      else
        next_state <= next_state;
      end if;
    end case;
  end process;

  --control state led signifiers
  led : process (CLK_50)
  begin
    if (rising_edge(CLK_50)) then
      case (present_state) is
        when RESTART =>
          LEDR <= "0000";
        when input_a =>
          LEDR <= "0001";
        when input_b =>
          LEDR <= "0010";
        when disp_sum =>
          LEDR <= "0100";
        when disp_diff =>
          LEDR <= "1000";
      end case;
    end if;
  end process;

  --when in input a state, store sw into a
  assign_num : process (present_state)
  begin
    case(present_state) is
      when input_a =>
      a <= sw;
      when others =>
      a <= a;
    end case;
  end process;

  --when in input b state, store sw into b
  assign_b : process (present_state)
  begin
    case(present_state) is
      when input_b =>
      b <= sw;
      when others =>
      b <= b;
    end case;
  end process;

  --determine what disp should be
  disp : process (CLK_50)
  begin
    if (rising_edge(CLK_50)) then
      case (present_state) is
        when RESTART        =>
          disp_num <= (others => '0');
        when input_a        =>
          disp_num <= a;
        when input_b =>
          disp_num <= b;
        when disp_sum =>
          disp_num <= sum;
        when disp_diff =>
          disp_num <= diff;
      end case;
    end if;
  end process;
end arch;