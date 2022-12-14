library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shifter is
    port(
        shift_lsl   : in std_logic;
        shift_lsr   : in std_logic;
        shift_asr   : in std_logic;
        shift_ror   : in std_logic;
        shift_rrx   : in std_logic;
        shift_val   : in std_logic_vector(4 downto 0);

        din         : in std_logic_vector(31 downto 0);
        cin         : in std_logic;

        dout        : out std_logic_vector(31 downto 0);
        cout        : out std_logic;

        vdd         : in bit;
        vss         : in bit
    );
end Shifter;


architecture behavior of shifter is
    signal sft_lsl, sft_lsr, sft_asr, sft_ror, sft_rrx : std_logic_vector(31 downto 0);
    signal carry : std_logic;

    component shifter_left
        port(
            shift_val   : in std_logic_vector(4 downto 0);
            din         : in std_logic_vector(31 downto 0);
            dout        : out std_logic_vector(31 downto 0);
            cout        : out std_logic;

            vdd         : in bit;
            vss         : in bit
        );
    end component;

    component shifter_right
        port(
            shift_val   : in std_logic_vector(4 downto 0);
            din         : in std_logic_vector(31 downto 0);
            dout        : out std_logic_vector(31 downto 0);
            cout        : out std_logic;

            vdd         : in bit;
            vss         : in bit
        );
    end component;

    component shifter_asr
        port(
            shift_val   : in std_logic_vector(4 downto 0);
            din         : in std_logic_vector(31 downto 0);
            dout        : out std_logic_vector(31 downto 0);
            cout        : out std_logic;

            vdd         : in bit;
            vss         : in bit
        );
    end component;

    component shifter_ror
        port(
            shift_val   : in std_logic_vector(4 downto 0);
            din         : in std_logic_vector(31 downto 0);
            sft_lsr     : in std_logic_vector(31 downto 0);
            dout        : out std_logic_vector(31 downto 0);
            cout        : out std_logic;

            vdd         : in bit;
            vss         : in bit
        );
    end component;

    begin
        LSL : shifter_left port map(shift_val, din, sft_lsl, carry, vdd, vss);
        LSR : shifter_right port map(shift_val, din, sft_lsr, carry, vdd, vss);
        ASR : shifter_asr port map(shift_val, din, sft_asr, carry, vdd, vss);
        ROR : shifter_ror port map(shift_val, din, sft_lsr, sft_ror, carry, vdd, vss);

        sft_rrx <= cin & din(31 downto 1);
        carry <= din(0) when shift_rrx = '1';
        cout <= carry when shift_rrx = '1';
        dout <= sft_lsl when shift_lsl = '1' else
                sft_lsr when shift_lsr = '1' else
                sft_asr when shift_asr = '1' else
                sft_ror when shift_ror = '1' else
                sft_rrx when shift_rrx = '1' else
                din;

end behavior;