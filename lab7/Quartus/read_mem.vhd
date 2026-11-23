library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity read_mem is
    port (
        clk , reset , en: in std_logic;
        op: out STD_LOGIC_VECTOR(1 downto 0);
        data: out std_logic_vector(7 downto 0)
    );
end read_mem;

architecture rtl of read_mem is
    type rom_type is array (5 downto 0) of STD_LOGIC_VECTOR(9 downto 0);
    signal rom: rom_type := ("0101101011", "1110010010", "0011010111", "1001001101", "0110110001",
    "1100100100", "0001111010", "1011010011", "0111001010", "0010101111", "1101110000", "1000010110", 
    "0100111101", "1111100011", "0001001011", "1010100010", "0110011100", "1101000111", "0011110010", 
    "1000111011", "0101010100", "1110001111", "0000111001", "1011110101", "0110101000", "1100011011", 
    "0010000111", "1001100101", "0100001110", "1111011001", "0000010110", "1011000001");

    signal addr: STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
begin
    d_out: process(clk, reset)
    begin
        if (reset = '1') then
            addr <= (others => '0');
            data <= rom(0)(7 downto 0);
            op <= rom(0)(9 downto 8);
        elsif (rising_edge(clk)) then
            if (en = '1') then
                addr <= addr + '1';
                data <= rom(to_integer(unsigned(addr)))(7 downto 0);
                op <= rom(to_integer(unsigned(addr)))(9 downto 8);
            else
                addr <= addr;
                data <= data;
                op <= op;
            end if;
        end if;
    end process;
end architecture;
