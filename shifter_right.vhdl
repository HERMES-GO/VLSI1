library ieee;
use ieee.std_logic_1164.all;

entity shifter_right is
    port(
        shift_val   : in std_logic_vector(4 downto 0);

        din         : in std_logic_vector(31 downto 0);

        dout        : out std_logic_vector(31 downto 0);
        cout        : out std_logic;

        vdd         : in bit;
        vss         : in bit
    );
end shifter_right;

architecture behavior of shifter_right is
    signal sft_16, sft_8, sft_4, sft_2, sft_1 : std_logic_vector(31 downto 0);
    signal cout_tmp_1, cout_tmp_2, cout_tmp_3, cout_tmp_4, cout_tmp_5 : std_logic;

    begin
        cout_tmp_1 <= din(15) when shift_val(4) = '1' else '0';
        sft_16 <= x"0000" & din(31 downto 16) when shift_val(4) = '1' else din;
        cout_tmp_2 <= sft_16(7) when shift_val(3) = '1' else cout_tmp_1;
        sft_8  <= x"00" & sft_16(31 downto 8) when shift_val(3) = '1' else sft_16;
        cout_tmp_3 <= sft_8(3) when shift_val(2) = '1' else cout_tmp_2;
        sft_4  <= x"0" & sft_8(31 downto 4) when shift_val(2) = '1' else sft_8;
        cout_tmp_4 <= sft_4(1) when shift_val(1) = '1' else cout_tmp_3;
        sft_2  <= "00" & sft_4(31 downto 2) when shift_val(1) = '1' else sft_4;
        cout_tmp_5 <= sft_2(0) when shift_val(0) = '1' else cout_tmp_4;
        sft_1  <= '0' & sft_2(31 downto 1) when shift_val(0) = '1' else sft_2;

        cout <= cout_tmp_5;
        dout <= sft_1;

end behavior;