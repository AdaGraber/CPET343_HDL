library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity rising_edge_synchronizer is 
  port (
    CLOCK_50               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic;
    sync_out          : out std_logic
  );
end rising_edge_synchronizer;

architecture arch of rising_edge_synchronizer is
    signal in_1 : std_logic;
    signal in_2 : std_logic;
    signal in_3 : std_logic;
begin
  double_flop : process (reset, CLOCK_50, async_in)
  begin
    if reset = '1' then
      in_1 <= '0';
      in_2 <= '0';
    elsif rising_edge(CLOCK_50) then
      in_1 <= async_in;
      in_2 <= in_1;
    end if;
  end process;

rising_edge_detector: process(reset,clock_50,in_2)
  begin
    if reset = '1' then
      sync_out        <= '0';
      in_3   <= '1';
    elsif rising_edge(clock_50) then
      in_3   <= in_2;
      sync_out <= (in_2 xor in_3) and in_2;
    end if;
end process;  
end arch;