library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity top is
  port (
    clk50 : in std_logic;
    reset : in std_logic;
    switches : in std_logic_vector(3 downto 0);
    HEX0  : out std_logic_vector(6 downto 0);
    led   : out std_logic
  );
end top;

architecture arch of top is

  --bcd component
 --component seven_seg is
 --  port (
 --    clk                    : in std_logic;
 --    reset                  : in std_logic;
 --    num_in                 : in std_logic_vector(3 downto 0);
 --    HEX0                   : out std_logic_vector(6 downto 0)
 --  );
 --end component;

  --


  --signals between components
  signal sum     : std_logic_vector(7 downto 0);
  signal enabled : std_logic;

begin
  --port map for seven_seg
 --bcd : seven_seg
 --port map(
 --  clk => clk50,
 --  reset => reset,
 --  num_in => switches,
 --  HEX0 => HEX0
 --);
   switchtohex : process (switches) is 
  begin
    case switches is
      when "0000" => HEX0 <= "1000000";
      when "0001" => HEX0 <= "1111001";
      when "0010" => HEX0 <= "0100100";
      when "0011" => HEX0 <= "0110000";
      when "0100" => HEX0 <= "0011001";
      when "0101" => HEX0 <= "0010010";
      when "0110" => HEX0 <= "0000010";
      when "0111" => HEX0 <= "1111000";
      when "1000" => HEX0 <= "0000000";
      when "1001" => HEX0 <= "0011000";
      when others     => HEX0     <= "0000000";
    end case;
  end process;
  
end arch;
