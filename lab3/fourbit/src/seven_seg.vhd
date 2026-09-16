library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity seven_seg is
  port (
    clk                    : in std_logic;
    reset                  : in std_logic;
    num_in                 : in std_logic_vector(3 downto 0);
    HEX0 : out std_logic_vector(6 downto 0)
  );
end seven_seg;

architecture arch of seven_seg is 

begin
  --display HEX0
  ones_display : process (num_in)
  begin
    case num_in is
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