library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity lab5_tb is
end entity;

architecture test of lab5_tb is
  component lab5 is
  port (
    in_sw            : in std_logic_vector (7 downto 0);
    in_key           : in std_logic_vector(3 downto 0);
    reset            : in std_logic;
    HEX2, HEX1, HEX0 : out std_logic_vector (6 downto 0);
    CLK_50           : in std_logic;
    LEDR             : out std_logic_vector(3 downto 0)
  );
  end component;

  --signals
  constant period : time := 20 ns;
  signal clk                 : std_logic := '0';
 signal reset               : std_logic := '1';
 signal hex_0, hex_1, hex_2 : std_logic_vector (6 downto 0);
 signal switch_input : std_logic_vector(7 downto 0);
 signal leds : STD_LOGIC_VECTOR(3 downto 0);
 signal key : STD_LOGIC_VECTOR(3 downto 0);
begin
    uut : lab5
     port map(
        in_sw => switch_input,
        in_key => key,
        reset => reset,
        HEX2 => HEX_2,
        HEX1 => HEX_1,
        HEX0 => HEX_0,
        CLK_50 => CLK,
        LEDR => LEDs
    );

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



end test;