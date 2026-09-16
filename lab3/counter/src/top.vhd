library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity top is
  port (
    clk50                  : in std_logic;
    reset                  : in std_logic;
    HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0);
    led : out std_logic
  );
end top;

architecture beh of top is

  --counter component
  component generic_counter is
    generic (
      max_count : integer := 9
    );
    port (
      clk    : in std_logic;
      reset  : in std_logic;
      output : out std_logic
    );
  end component;

  --bcd component
component seven_seg is
  port (
    clk                    : in std_logic;
    reset                  : in std_logic;
    num_in                 : in std_logic_vector(7 downto 0);
    HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
  );
end component;

  --adder component
  component generic_adder_beh is
    generic (
      bits : integer := 8
    );
    port (
      a    : in std_logic_vector(bits - 1 downto 0);
      b    : in std_logic_vector(bits - 1 downto 0);
      cin  : in std_logic;
      sum  : out std_logic_vector(bits - 1 downto 0);
      cout : out std_logic
    );
  end component;

  --signals between components
  signal sum_sig : std_logic_vector(7 downto 0);
  signal sum     : std_logic_vector(7 downto 0);
  signal enabled : std_logic;
  signal b_in    : std_logic_vector(7 downto 0) := "00000001";

begin

  --port map for generic_counter
  counter : generic_counter
  generic map(
    max_count => 50000000
  )
  port map
  (
    clk    => clk50,
    reset  => reset,
    output => enabled
  );
  --port map for generic_adder
  adder : generic_adder_beh
  generic map(
    bits => 8
  )
  port map
  (
    a    => sum_sig,
    b    => b_in,
    cin  => '0',
    sum  => sum,
    cout => open
  );

  --port map for seven_segment
 seven_segment : seven_seg
 port map
 (
   clk    => clk50,
   reset  => reset,
   num_in => sum_sig,
   HEX3   => HEX3,
   HEX2   => HEX2,
   HEX1   => HEX1,
   HEX0   => HEX0
 );

  --sum register process
  sum_reg : process (enabled, sum)
  begin
      if (enabled = '1') then
        sum_sig <= sum;
    end if;
  end process;

  led<= enabled;
end beh;