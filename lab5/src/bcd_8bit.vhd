LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY bcd_8bit IS
    port (
      in_num           : in std_logic_vector(7 downto 0);
      HEX2, HEX1, HEX0 : out std_logic_vector (6 downto 0)
    );
END bcd_8bit;

ARCHITECTURE behave OF bcd_8bit IS
	 signal hundreds_output : UNSIGNED(7 downto 0) := (others => '0');
	 signal tens_remainder : unsigned(7 downto 0) := (others => '0');
	 signal ones_remainder : unsigned(7 downto 0) := (others => '0');
BEGIN
-- get absolute value of the number

		--calculate outputs
		hundreds_output <= unsigned(in_num) / "01100100";
		tens_remainder <= (unsigned(in_num) rem "01100100") / ("00001010");
		ones_remainder <= (unsigned(in_num) rem "00001010");

		--display HEX2
		hundreds_display : PROCESS(hundreds_output)
		    BEGIN
				  CASE hundreds_output IS
				      WHEN "00000000" => HEX2 <= "1000000";
						WHEN "00000001" => HEX2 <= "1111001";
						WHEN "00000010" => HEX2 <= "0100100";
						WHEN "00000011" => HEX2 <= "0110000";
						WHEN "00000100" => HEX2 <= "0011001";
						WHEN "00000101" => HEX2 <= "0010010";
						WHEN "00000110" => HEX2 <= "0000010";
						WHEN "00000111" => HEX2 <= "1111000";
						WHEN "00001000" => HEX2 <= "0000000";
						WHEN "00001001" => HEX2 <= "0011000";
						WHEN OTHERS => HEX2 <= "0000000";
					END CASE;
				END PROCESS;
		
		--display HEX1
		tens_display : PROCESS(tens_remainder)
			BEGIN
				 	CASE tens_remainder IS
				      WHEN "00000000" => HEX1 <= "1000000";
						WHEN "00000001" => HEX1 <= "1111001";
						WHEN "00000010" => HEX1 <= "0100100";
						WHEN "00000011" => HEX1 <= "0110000";
						WHEN "00000100" => HEX1 <= "0011001";
						WHEN "00000101" => HEX1 <= "0010010";
						WHEN "00000110" => HEX1 <= "0000010";
						WHEN "00000111" => HEX1 <= "1111000";
						WHEN "00001000" => HEX1 <= "0000000";
						WHEN "00001001" => HEX1 <= "0011000";
						WHEN OTHERS => HEX1 <= "0000000";
					END CASE;
				END PROCESS;
		
		--display HEX0
		ones_display : PROCESS(ones_remainder)
			BEGIN
				 	CASE ones_remainder IS
				      WHEN "00000000" => HEX0 <= "1000000";
						WHEN "00000001" => HEX0 <= "1111001";
						WHEN "00000010" => HEX0 <= "0100100";
						WHEN "00000011" => HEX0 <= "0110000";
						WHEN "00000100" => HEX0 <= "0011001";
						WHEN "00000101" => HEX0 <= "0010010";
						WHEN "00000110" => HEX0 <= "0000010";
						WHEN "00000111" => HEX0 <= "1111000";
						WHEN "00001000" => HEX0 <= "0000000";
						WHEN "00001001" => HEX0 <= "0011000";
						WHEN OTHERS => HEX0 <= "0000000";
					END CASE;
				END PROCESS;

END behave;