library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity ALU is
    port (
    op1 : in STD_LOGIC_VECTOR(31 downto 0);
	op2 : in STD_LOGIC_VECTOR(31 downto 0);
	cin : in STD_LOGIC;

    cmd : in STD_LOGIC_VECTOR(1 downto 0);

    res : out STD_LOGIC_VECTOR(31 downto 0);
    cout : out STD_LOGIC;
	z : out STD_LOGIC;
	n : out STD_LOGIC;
	v : out STD_LOGIC;

	vdd : in bit;
	vss : in bit);
end ALU;

architecture dataflow of ALU is

	signal ALU_Result : std_logic_vector (31 downto 0);
	signal tmp : std_logic_vector (32 downto 0);
	signal addition : std_logic_vector (31 downto 0);

begin
	tmp(0) <= cin;
	boucle: for i in 0 to 31 generate
		add: entity work.adder port map(op1(i), op2(i), tmp(i), addition(i), tmp(i+1), vdd, vss);
	end generate;

	ALU_Result <=	addition		when cmd = "00" else
					(op1 and op2)	when cmd = "01" else
					(op1 or op2)	when cmd = "10" else
					(op1 xor op2)	when cmd = "11";
	
	res <= ALU_Result;
	cout <= tmp(32);
	
	z <= '1' when addition = x"00000000" else
		'0';
	n <= '1' when addition(31) = '1' else
		'0';
	v <= (not op1(31) and not op2(31) and ALU_Result(31)) or (op1(31) and op2(31) and not ALU_Result(31));

end dataflow;