library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity seven_seg is
  port (
    clk                    : in std_logic;
    reset                  : in std_logic;
    num_in                 : in std_logic_vector(7 downto 0);
    HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
  );
end seven_seg;

architecture arch of seven_seg is
  signal abs_value       : UNSIGNED(7 downto 0);
  signal hundreds_output : UNSIGNED(7 downto 0);
  signal tens_remainder  : unsigned(7 downto 0);
  signal ones_remainder  : unsigned(7 downto 0);
begin

  -- check if negative number or not
  neg_check : process (num_in)
  begin
    if (num_in(7) = '0') then
      HEX3 <= "1111111";
    else
      HEX3 <= "0111111";
    end if;
  end process;


  -- get absolute value of the number
  abs_val : process (num_in)
  begin
    if (num_in(7) = '1') then
      abs_value <= (unsigned(not(num_in)) + 1);
    else
      abs_value <= unsigned(num_in);
    end if;
  end process;

  -- do math to get the hundreds, tens, and ones digits
  hundreds_output <= (abs_value / "01100100");
  tens_remainder  <= (abs_value rem "01100100") / ("00001010");
  ones_remainder  <= (abs_value rem "00001010");

  --display HEX2
  hundreds_display : process (hundreds_output)
  begin
    case hundreds_output is
      when "00000000" => HEX2 <= "1000000";
      when "00000001" => HEX2 <= "1111001";
      when "00000010" => HEX2 <= "0100100";
      when "00000011" => HEX2 <= "0110000";
      when "00000100" => HEX2 <= "0011001";
      when "00000101" => HEX2 <= "0010010";
      when "00000110" => HEX2 <= "0000010";
      when "00000111" => HEX2 <= "1111000";
      when "00001000" => HEX2 <= "0000000";
      when "00001001" => HEX2 <= "0011000";
      when others     => HEX2     <= "0000000";
    end case;
  end process;

  --display HEX1
  tens_display : process (tens_remainder)
  begin
    case tens_remainder is
      when "00000000" => HEX1 <= "1000000";
      when "00000001" => HEX1 <= "1111001";
      when "00000010" => HEX1 <= "0100100";
      when "00000011" => HEX1 <= "0110000";
      when "00000100" => HEX1 <= "0011001";
      when "00000101" => HEX1 <= "0010010";
      when "00000110" => HEX1 <= "0000010";
      when "00000111" => HEX1 <= "1111000";
      when "00001000" => HEX1 <= "0000000";
      when "00001001" => HEX1 <= "0011000";
      when others     => HEX1     <= "0000000";
    end case;
  end process;

  --display HEX0
  ones_display : process (ones_remainder)
  begin
    case ones_remainder is
      when "00000000" => HEX0 <= "1000000";
      when "00000001" => HEX0 <= "1111001";
      when "00000010" => HEX0 <= "0100100";
      when "00000011" => HEX0 <= "0110000";
      when "00000100" => HEX0 <= "0011001";
      when "00000101" => HEX0 <= "0010010";
      when "00000110" => HEX0 <= "0000010";
      when "00000111" => HEX0 <= "1111000";
      when "00001000" => HEX0 <= "0000000";
      when "00001001" => HEX0 <= "0011000";
      when others     => HEX0     <= "0000000";
    end case;
  end process;
end arch;