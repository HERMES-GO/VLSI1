library ieee;
use ieee.std_logic_1164.all;

entity shifter_asr is
    port(
        shift_val   : in std_logic_vector(4 downto 0);

        din         : in std_logic_vector(31 downto 0);

        dout        : out std_logic_vector(31 downto 0);
        cout        : out std_logic;

        vdd         : in bit;
        vss         : in bit
    );
end shifter_asr;

architecture behavior of shifter_asr is
    signal sft_16, sft_8, sft_4, sft_2, sft_1 : std_logic_vector(31 downto 0);
    signal sign_16 : std_logic_vector(15 downto 0);
    signal sign_8  : std_logic_vector(7 downto 0);
    signal sign_4  : std_logic_vector(3 downto 0);
    signal sign_2  : std_logic_vector(1 downto 0);
    signal sign_1  : std_logic;
    signal cout_tmp_1, cout_tmp_2, cout_tmp_3, cout_tmp_4, cout_tmp_5 : std_logic;

    begin
        sign_1  <= din(31);
        sign_2  <= sign_1 & sign_1;
        sign_4  <= sign_2 & sign_2;
        sign_8  <= sign_4 & sign_4;
        sign_16 <= sign_8 & sign_8;

        cout_tmp_1 <= din(15) when shift_val(4) = '1' else '0';
        sft_16 <= sign_16 & din(31 downto 16) when shift_val(4) = '1' else din;
        cout_tmp_2 <= sft_16(7) when shift_val(3) = '1' else cout_tmp_1;
        sft_8  <= sign_8 & sft_16(31 downto 8) when shift_val(3) = '1' else sft_16;
        cout_tmp_3 <= sft_8(3) when shift_val(2) = '1' else cout_tmp_2;
        sft_4  <= sign_4 & sft_8(31 downto 4) when shift_val(2) = '1' else sft_8;
        cout_tmp_4 <= sft_4(1) when shift_val(1) = '1' else cout_tmp_3;
        sft_2  <= sign_2 & sft_4(31 downto 2) when shift_val(1) = '1' else sft_4;
        cout_tmp_5 <= sft_2(0) when shift_val(0) = '1' else cout_tmp_4;
        sft_1  <= sign_1 & sft_2(31 downto 1) when shift_val(0) = '1' else sft_2;

        cout <= cout_tmp_5;
        dout <= sft_1;

end behavior;