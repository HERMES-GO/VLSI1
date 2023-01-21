library ieee;
use ieee.std_logic_1164.all;

entity adder4 is
port (A, B : in std_logic_vector(3 downto 0);
		C : in std_logic;
		S : out std_logic_vector(3 downto 0);
		Cout : out std_logic;
		vdd, vss : in bit
	);
end adder4;

architecture dataflow of adder4 is

component adder
	Port ( A : in std_logic;
		B : in std_logic;
		C : in std_logic;
		S : out std_logic;
		Cout : out std_logic;
		vdd, vss : in bit
	);
end component;

signal c1,c2,c3: std_logic;

begin

	FA1: entity work.adder port map( A(0), B(0), C, S(0), c1, vdd, vss);
	FA2: entity work.adder port map( A(1), B(1), c1, S(1), c2, vdd, vss);
	FA3: entity work.adder port map( A(2), B(2), c2, S(2), c3, vdd, vss);
	FA4: entity work.adder port map( A(3), B(3), c3, S(3), Cout, vdd, vss);

end dataflow;