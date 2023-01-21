library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter_ror is
    port(
        shift_val   : in std_logic_vector(4 downto 0);

        din         : in std_logic_vector(31 downto 0);
        sft_lsr   : in std_logic_vector(31 downto 0);

        dout        : out std_logic_vector(31 downto 0);
        cout        : out std_logic;

        vdd         : in bit;
        vss         : in bit
    );
end shifter_ror;

architecture behavior of shifter_ror is
    signal left_out : std_logic_vector(31 downto 0);
    signal sft_val, shift_val_left : std_logic_vector(4 downto 0);
    signal cout_tmp : std_logic;

    component adder5
        port(
            A, B : in std_logic_vector(4 downto 0);
            C    : in std_logic;
            S    : out std_logic_vector(4 downto 0);
            Cout : out std_logic;
            vdd, vss : in bit
        );
    end component;

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

begin
    shift_val_left <= not(shift_val);

    add5 : adder5 port map(shift_val_left, "00001", '0', sft_val, cout_tmp, vdd, vss);
    shift_left : shifter_left port map(sft_val, din, left_out, cout_tmp, vdd, vss);

    cout <= cout_tmp;
    dout <= left_out or sft_lsr;

end behavior;