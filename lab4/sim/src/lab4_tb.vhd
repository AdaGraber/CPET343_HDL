library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity lab4_tb is
end entity;

architecture test of lab4_tb is
  component lab4 is
    port (
      sw_a, sw_b                                 : in std_logic_vector(2 downto 0);
      pb_add, pb_sub                             : in std_logic;
      CLOCK_50                                   : in std_logic;
      reset                                      : in std_logic;
      seven_seg_a, seven_seg_b, seven_seg_result : out std_logic_vector(6 downto 0)
    );
  end component;

  constant period : time := 20 ns;
  signal a_in, b_in          : std_logic_vector(2 downto 0) := "000";
  signal addi, subt          : std_logic;
  signal clk                 : std_logic := '0';
  signal reset               : std_logic := '1';
  signal hex_a, hex_b, hex_r : std_logic_vector (6 downto 0);

begin

  uut : lab4
  port map
  (
    sw_a             => a_in,
    sw_b             => b_in,
    pb_add           => addi,
    pb_sub           => subt,
    CLOCK_50         => clk,
    reset            => reset,
    seven_seg_a      => hex_a,
    seven_seg_b      => hex_b,
    seven_seg_result => hex_r
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

  sequential_tb : process
  begin
    report "****************** sequential testbench start ****************";
    wait for 10 ns; -- let all the initial conditions trickle through
    for i in 0 to 1 loop
      if (i = 0) then
        addi <= '0';
        subt <= '1';
      elsif (i = 1) then
        addi <= '1';
        subt <= '0';
      end if;
      for j in 0 to ((2 ** 3) - 1) loop
        a_in <= std_logic_vector(unsigned(a_in) + 1);
        for k in 0 to ((2 ** 3) - 1) loop
          b_in <= std_logic_vector(unsigned(b_in) + 1);
          wait for 10 ns;
        end loop;
      end loop;
    end loop;
    report "****************** sequential testbench stop ****************";
    wait;
  end process;
end architecture;