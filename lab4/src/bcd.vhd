library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity bcd is 
port(
    CLOCK_50 : in std_logic;
    reset : in std_logic;
    num_in : in std_logic_vector(3 downto 0);
    seven_seg_out : out std_logic_vector (6 downto 0)
);
end entity;


architecture arch of bcd is

begin

      --display seven_seg_out
  hex_disp : process (num_in)
  begin
    case num_in is
        --numbers
      when "0000" => seven_seg_out <= "1000000";
      when "0001" => seven_seg_out <= "1111001";
      when "0010" => seven_seg_out <= "0100100";
      when "0011" => seven_seg_out <= "0110000";
      when "0100" => seven_seg_out <= "0011001";
      when "0101" => seven_seg_out <= "0010010";
      when "0110" => seven_seg_out <= "0000010";
      when "0111" => seven_seg_out <= "1111000";
      when "1000" => seven_seg_out <= "0000000";
      when "1001" => seven_seg_out <= "0011000";

      --letter
      when "1010" => seven_seg_out <= "0001000";
      when "1011" => seven_seg_out <= "0000011";
      when "1100" => seven_seg_out <= "0100001";
      when "1101" => seven_seg_out <= "0110011";
      when "1110" => seven_seg_out <= "0000110";
      when "1111" => seven_seg_out <= "0001110";
      when others     => seven_seg_out     <= "0000000";
    end case;
  end process;

end architecture;