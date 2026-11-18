library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity lab7 is
  port (
    CLOCK_50         : in std_logic;
    in_exe           : in std_logic;
    reset            : in std_logic;
    HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0);
    LEDS             : out std_logic_vector(1 downto 0)
  );
end lab7;

architecture rtl of lab7 is
  --rising edge synchronizer
  component rising_edge_synchronizer is
    port (
      CLOCK_50 : in std_logic;
      reset    : in std_logic;
      async_in : in std_logic;
      sync_out : out std_logic
    );
  end component;

  --ALU
  component ALU is
    port (
      reset  : in std_logic;
      a      : in std_logic_vector(7 downto 0);
      b      : in std_logic_vector(7 downto 0);
      op     : in std_logic_vector(1 downto 0); -- 00: add, 01: sub, 10: mult, 11: div
      result : out std_logic_vector(7 downto 0)
    );
  end component;

  --bcd that then goes to hex
  component bcd_8bit is
    port (
      in_num           : in std_logic_vector(7 downto 0);
      HEX2, HEX1, HEX0 : out std_logic_vector (6 downto 0)
    );
  end component;

  component memory is
    generic (
      addr_width : integer := 4;
      data_width : integer := 8);
    port (
      clk  : in std_logic;
      we   : in std_logic;
      addr : in std_logic_vector(addr_width - 1 downto 0);
      din  : in std_logic_vector(data_width - 1 downto 0);
      dout : out std_logic_vector(data_width - 1 downto 0)
    );
  end component;

  --state variables
  type instr_state is (IDLE, FETCH, CONFIRM);
  signal present_state, next_state : instr_state;

  --signals
  signal mem_out     : std_logic_vector(7 downto 0);
  signal exe         : std_logic;
  signal op          : std_logic_vector(1 downto 0);
  signal sw          : std_logic_vector(7 downto 0);
  signal temp_result : std_logic_vector(7 downto 0);
  signal result      : std_logic_vector(7 downto 0);
  signal we          : std_logic;
  signal addr        : std_logic_vector(3 downto 0);
begin

end architecture;