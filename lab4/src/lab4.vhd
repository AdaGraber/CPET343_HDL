library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity lab4 is
  port (
    sw_a, sw_b                                 : in std_logic_vector(2 downto 0);
    pb_add, pb_sub                             : in std_logic;
    CLOCK_50                                   : in std_logic;
    reset                                      : in std_logic;
    seven_seg_a, seven_seg_b, seven_seg_result : out std_logic_vector(6 downto 0)
  );
end lab4;

architecture arch of lab4 is
  --components
  component bcd is
    port (
      CLOCK_50      : in std_logic;
      reset         : in std_logic;
      num_in        : in std_logic_vector(3 downto 0);
      seven_seg_out : out std_logic_vector (6 downto 0)
    );
  end component;

  component synchronizer_3bit is
    port (
      CLOCK_50 : in std_logic;
      reset    : in std_logic;
      async_in : in std_logic_vector(2 downto 0);
      sync_out : out std_logic_vector(2 downto 0)
    );
  end component;

  component rising_edge_synchronizer is
    port (
      CLOCK_50 : in std_logic;
      reset    : in std_logic;
      async_in : in std_logic;
      sync_out : out std_logic
    );
  end component;

  component add_or_sub is
    port (
      CLOCK_50   : in std_logic;
      reset      : in std_logic;
      a_in       : in std_logic_vector(2 downto 0);
      b_in       : in std_logic_vector(2 downto 0);
      op         : in std_logic;
      result_out : out std_logic_vector (3 downto 0)
    );
  end component;
  --signals
  signal sync_add_pb, sync_sub_pb, op : std_logic;
  signal a_to_bcd, b_to_bcd, result   : std_logic_vector(3 downto 0);
  signal a, b                         : std_logic_vector(2 downto 0);
begin

  --port maps
  sync_a : synchronizer_3bit
  port map
  (
    CLOCK_50 => CLOCK_50,
    reset    => reset,
    async_in => sw_a,
    sync_out => a
  );
  sync_b : synchronizer_3bit
  port map
  (
    CLOCK_50 => CLOCK_50,
    reset    => reset,
    async_in => sw_b,
    sync_out => b
  );

  sync_pb_add : rising_edge_synchronizer
  port map
  (
    CLOCK_50 => CLOCK_50,
    reset    => reset,
    async_in => pb_add,
    sync_out => sync_add_pb
  );

  sync_pb_sub : rising_edge_synchronizer
  port map
  (
    CLOCK_50 => CLOCK_50,
    reset    => reset,
    async_in => pb_sub,
    sync_out => sync_sub_pb
  );

  add_or_sub_inst : add_or_sub
  port map
  (
    CLOCK_50   => CLOCK_50,
    reset      => reset,
    a_in       => a,
    b_in       => b,
    op         => op,
    result_out => result
  );

  a_bcd : bcd
  port map
  (
    CLOCK_50      => CLOCK_50,
    reset         => reset,
    num_in        => a_to_bcd,
    seven_seg_out => seven_seg_a
  );

  b_bcd : bcd
  port map
  (
    CLOCK_50      => CLOCK_50,
    reset         => reset,
    num_in        => b_to_bcd,
    seven_seg_out => seven_seg_b
  );

  result_bcd : bcd
  port map
  (
    CLOCK_50      => CLOCK_50,
    reset         => reset,
    num_in        => result,
    seven_seg_out => seven_seg_result
  );

  --process to append a 0 to the a and b to be displayed to the seven seg.
  append_zero : process (CLOCK_50, reset, a, b)
  begin
    if (reset = '1') then
      a_to_bcd <= "0000";
      b_to_bcd <= "0000";
    elsif (rising_edge(CLOCK_50)) then
      a_to_bcd <= '0' & a;
      b_to_bcd <= '0' & b;
    end if;
  end process;

  --process to determine operation performed
  operation_to_perform : process (CLOCK_50, sync_add_pb, sync_sub_pb)
  begin
    if (rising_edge(CLOCK_50)) then
      if (sync_add_pb = '0') then
        op <= '1';
      elsif (sync_sub_pb = '0') then
        op <= '0';
      end if;
    end if;
  end process;
end architecture;