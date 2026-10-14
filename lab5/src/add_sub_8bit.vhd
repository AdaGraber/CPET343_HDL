library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity add_sub_8bit is
  port (
    CLOCK_50        : in std_logic;
    reset    : in std_logic;
    a_in       : in std_logic_vector(7 downto 0);
    b_in       : in std_logic_vector(7 downto 0);
    add_out : out std_logic_vector (7 downto 0);
    sub_out : out std_logic_vector (7 downto 0)
  );
end entity;

architecture arch of add_sub_8bit is

begin

  operation : process (CLOCK_50, reset)
  begin
    if (reset = '1') then
      add_out <= (others => '0');
      sub_out <= (others => '0');
    elsif (rising_edge(CLOCK_50)) then
      add_out <= a_in + b_in;
      sub_out <= a_in - b_in;
    end if;
  end process;
end architecture;