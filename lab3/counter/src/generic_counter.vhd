-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity generic_counter is
  generic (
    max_count       : integer := 9
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end generic_counter;  

architecture beh of generic_counter  is

signal count_sig    : integer range 0 to max_count := 3;
signal output_sig : std_logic;
begin
process(clk,reset)
  begin
    if (reset = '1') then 
      count_sig <= 0;
      output_sig <= '0';
    elsif (clk'event and clk = '1') then
      if (count_sig = max_count) then
        count_sig <= 0;
        output_sig <= not output_sig;
      else
        count_sig <= count_sig + 1;
     --   output_sig <= '0';
      end if; 
    end if;
  end process;

  output <= output_sig;
end beh;