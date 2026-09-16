-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_tb is
end seven_seg_tb;

architecture arch of seven_seg_tb is

component seven_seg is
  port (
    clk                    : in std_logic;
    reset                  : in std_logic;
    num_in                 : in std_logic_vector(7 downto 0);
    HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
  );
end component; 

signal output       : std_logic;
constant period     : time := 20 ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal num_in       : std_logic_vector(7 downto 0) := "00000000";
signal HEX3, HEX2, HEX1, HEX0 : std_logic_vector(6 downto 0);

begin

-- bcd iteration
sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80 ns;   -- let all the initial conditions trickle through
      for i in 0 to 9 loop
        num_in <= std_logic_vector(unsigned(num_in) + 1 );
        wait for 40 ns;
      end loop;
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 

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

uut: seven_seg  
  port map(        
    clk            => clk,
    reset          => reset,
    num_in         => num_in,
    HEX3           => HEX3,
    HEX2           => HEX2,
    HEX1           => HEX1,
    HEX0           => HEX0
  );
end arch;