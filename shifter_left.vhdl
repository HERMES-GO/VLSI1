library ieee;
use ieee.std_logic_1164.all;

entity shifter_left is
    port(
        shift_val   : in std_logic_vector(4 downto 0);

        din         : in std_logic_vector(31 downto 0);

        dout        : out std_logic_vector(31 downto 0);
        cout        : out std_logic;

        vdd         : in bit;
        vss         : in bit
    );
end shifter_left;

architecture behavior of shifter_left is
    signal sft_16, sft_8, sft_4, sft_2, sft_1 : std_logic_vector(31 downto 0);
    signal cout_tmp;

    begin
        cout_tmp <= din(16) when shift_val(4) = '1' else '0';
        sft_16 <= din(15 downto 0) & x"0000" when shift_val(4) = '1' else din;
        cout_tmp <= sft_16(24) when shift_val(3) = '1';
        sft_8  <= sft_16(23 downto 0) & x"00" when shift_val(3) = '1' else sft_16;
        cout_tmp <= sft_8(28) when shift_val(2) = '1';
        sft_4  <= sft_8(27 downto 0) & x"0" when shift_val(2) = '1' else sft_8;
        cout_tmp <= sft_4(30) when shift_val(1) = '1';
        sft_2  <= sft_4(29 downto 0) & "00" when shift_val(1) = '1' else sft_4;
        cout_tmp <= sft_2(31) when shift_val(0) = '1';
        sft_1  <= sft_2(30 downto 0) & '0' when shift_val(0) = '1' else sft_2;

        cout <= cout_tmp;
        dout <= sft_1;

end behavior;