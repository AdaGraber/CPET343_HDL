library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity add_or_sub is
  port (
    CLOCK_50        : in std_logic;
    reset    : in std_logic;
    a_in       : in std_logic_vector(2 downto 0);
    b_in       : in std_logic_vector(2 downto 0);
    op         : in std_logic;
    result_out : out std_logic_vector (3 downto 0)
  );
end entity;

architecture arch of add_or_sub is

begin

  operation : process (CLOCK_50, reset)
  begin
    if (reset = '1') then
      result_out <= "0000";
    elsif (rising_edge(CLOCK_50)) then
      if (op = '1') then
        result_out <= ('0' & a_in) + ('0' & b_in);
      elsif (op = '0') then
        result_out <= ('0' & a_in) - ('0' & b_in);
      else --defaults to subtracting
        result_out <= ('0' & a_in) - ('0' & b_in);
      end if;
    end if;
  end process;
end architecture;