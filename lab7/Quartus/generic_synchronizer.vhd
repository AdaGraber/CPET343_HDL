-------------------------------------------------------------------------------
-- Dr. Kaputa
-- synchronizer 3 bit example
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity generic_synchronizer is
  generic(
    num_bits : integer range 0 to 9 := 7
  );
  port (
    CLOCK_50      : in std_logic;
    reset    : in std_logic;
    async_in : in std_logic_vector(num_bits downto 0);
    sync_out : out std_logic_vector(num_bits downto 0)
  );
end generic_synchronizer;

architecture beh of generic_synchronizer is
  -- signal declarations
  signal flop1 : std_logic_vector(num_bits downto 0);
  signal flop2 : std_logic_vector(num_bits downto 0);

begin
  double_flop : process (reset, CLOCK_50, async_in)
  begin
    if reset = '0' then
      flop1 <= (others => '0');
      flop2 <= (others => '0');
    elsif rising_edge(CLOCK_50) then
      flop1 <= async_in;
      flop2 <= flop1;
    end if;
  end process;

  sync_out <= flop2;
end beh;