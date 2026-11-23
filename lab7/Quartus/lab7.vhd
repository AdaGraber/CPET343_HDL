library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity lab7 is
    port (
        CLOCK_50: in std_logic;
        in_exe: in std_logic;
        reset: in std_logic;
        HEX2 , HEX1 , HEX0: out std_logic_vector(6 downto 0);
        LEDS: out std_logic_vector(1 downto 0)
    );
end lab7;

architecture rtl of lab7 is
    --rising edge synchronizer
    component rising_edge_synchronizer is
        port (
            CLOCK_50: in std_logic;
            reset: in std_logic;
            async_in: in std_logic;
            sync_out: out std_logic
        );
    end component;

    --ALU
    component ALU is
        port (
            reset: in std_logic;
            a: in std_logic_vector(7 downto 0);
            b: in std_logic_vector(7 downto 0);
            op: in std_logic_vector(1 downto 0); -- 00: add, 01: sub, 10: mult, 11: div
            result: out std_logic_vector(7 downto 0)
        );
    end component;

    --bcd that then goes to hex
    component bcd_8bit is
        port (
            in_num: in std_logic_vector(7 downto 0);
            HEX2 , HEX1 , HEX0: out std_logic_vector(6 downto 0)
        );
    end component;

    component memory is
        generic (
            addr_width: integer := 4;
            data_width: integer := 8
        );
        port (
            clk: in std_logic;
            we: in std_logic;
            addr: in std_logic_vector(addr_width - 1 downto 0);
            din: in std_logic_vector(data_width - 1 downto 0);
            dout: out std_logic_vector(data_width - 1 downto 0)
        );
    end component;

    component read_mem is
        port (
            clk , reset , en: in std_logic;
            op: out STD_LOGIC_VECTOR(1 downto 0);
            data: out std_logic_vector(7 downto 0)
        );
    end component;
    --state variables
    type instr_state is (IDLE, FETCH, CONFIRM);
    signal present_state, next_state: instr_state;

    --signals
    signal mem_out: std_logic_vector(7 downto 0);
    signal exe: std_logic;
    signal op: std_logic_vector(1 downto 0);
    signal b: std_logic_vector(7 downto 0);
    signal temp_result: std_logic_vector(7 downto 0);
    signal result: std_logic_vector(7 downto 0);
    signal we: std_logic;
    signal addr: std_logic_vector(3 downto 0);
begin
    --port maps
    --res for exe button
    rising_edge_synchronizer_inst: rising_edge_synchronizer
        port map (
            CLOCK_50 => CLOCK_50,
            reset => reset,
            async_in => in_exe,
            sync_out => exe
        );

    --rom
    read_mem_inst: read_mem
        port map (
            clk => CLOCK_50,
            reset => reset,
            en => exe,
            op => op,
            data => b
        );

    --ram for memory to be stored into and read out of
    memory_inst: entity work.memory
        generic map (
            addr_width => 4,
            data_width => 8
        )
        port map (
            clk => CLOCK_50,
            we => we,
            addr => addr,
            din => result,
            dout => mem_out
        );

    ALU_inst: ALU
        port map (
            reset => reset,
            a => mem_out,
            b => b,
            op => op,
            result => temp_result
        );

    bcd_8bit_inst: bcd_8bit
        port map (
            in_num => result,
            HEX2 => HEX2,
            HEX1 => HEX1,
            HEX0 => HEX0
        );

    --processes
    confirm_result: process(CLOCK_50, reset)
    begin
        if (reset = '0') then
            addr <= "00";
            result <= (others => '0');
            we <= '1';
        elsif (rising_edge(CLOCK_50)) then
            if (exe = '1') then
                addr <= addr + '1';
                result <= temp_result;
                we <= '1';
            else
                we <= '0';
                result <= result;
                addr <= addr;
            end if;
        end if;
    end process;
end architecture;
