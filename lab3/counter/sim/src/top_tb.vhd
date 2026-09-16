library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture beh of top_tb is

component top is
  port (
    clk50             : in  std_logic; 
    reset           : in  std_logic;
    HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
  );
end component;

constant period     : time := 20 ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal HEX3, HEX2, HEX1, HEX0 : std_logic_vector(6 downto 0);

begin

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

uut: top  
  port map(
    clk50     => clk,
    reset     => reset,
    HEX3      => HEX3,
    HEX2      => HEX2,
    HEX1      => HEX1,
    HEX0      => HEX0
  );
end beh;