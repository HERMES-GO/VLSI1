library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg is
	port(
	-- Write Port 1 prioritaire
		wdata1		: in Std_Logic_Vector(31 downto 0);
		wadr1			: in Std_Logic_Vector(3 downto 0);
		wen1			: in Std_Logic;

	-- Write Port 2 non prioritaire
		wdata2		: in Std_Logic_Vector(31 downto 0);
		wadr2			: in Std_Logic_Vector(3 downto 0);
		wen2			: in Std_Logic;

	-- Write CSPR Port
		wcry			: in Std_Logic;
		wzero			: in Std_Logic;
		wneg			: in Std_Logic;
		wovr			: in Std_Logic;
		cspr_wb		: in Std_Logic;
		
	-- Read Port 1 32 bits
		reg_rd1		: out Std_Logic_Vector(31 downto 0);
		radr1			: in Std_Logic_Vector(3 downto 0);
		reg_v1		: out Std_Logic;

	-- Read Port 2 32 bits
		reg_rd2		: out Std_Logic_Vector(31 downto 0);
		radr2			: in Std_Logic_Vector(3 downto 0);
		reg_v2		: out Std_Logic;

	-- Read Port 3 32 bits
		reg_rd3		: out Std_Logic_Vector(31 downto 0);
		radr3			: in Std_Logic_Vector(3 downto 0);
		reg_v3		: out Std_Logic;

	-- read CSPR Port
		reg_cry		: out Std_Logic;
		reg_zero		: out Std_Logic;
		reg_neg		: out Std_Logic;
		reg_cznv		: out Std_Logic;
		reg_ovr		: out Std_Logic;
		reg_vv		: out Std_Logic;
		
	-- Invalidate Port 
		inval_adr1	: in Std_Logic_Vector(3 downto 0);
		inval1		: in Std_Logic;

		inval_adr2	: in Std_Logic_Vector(3 downto 0);
		inval2		: in Std_Logic;

		inval_czn	: in Std_Logic;
		inval_ovr	: in Std_Logic;

	-- PC
		reg_pc		: out Std_Logic_Vector(31 downto 0);
		reg_pcv		: out Std_Logic;
		inc_pc		: in Std_Logic;
	
	-- global interface
		ck				: in Std_Logic;
		reset_n		: in Std_Logic;
		vdd			: in bit;
		vss			: in bit);
end Reg;

architecture Behavior OF Reg is
	signal r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14 : std_logic_vector(31 downto 0);
	signal r0_v, r1_v, r2_v, r3_v, r4_v, r5_v, r6_v, r7_v, r8_v, r9_v, r10_v, r11_v, r12_v, r13_v, r14_v, pcv : std_logic;
	signal c, z, n, cznv, ovr, vv : std_logic;
	signal pc : std_logic_vector(31 downto 0);

begin
	reg_cry <= c;
	reg_zero <= z;
	reg_neg <= n;
	reg_cznv <= cznv;
	reg_ovr <= ovr;
	reg_vv <= vv;

	with radr1 select reg_rd1 <=	r0 when "0000",
									r1 when "0001",
									r2 when "0010",
									r3 when "0011",
									r4 when "0100",
									r5 when "0101",
									r6 when "0110",
									r7 when "0111",
									r8 when "1000",
									r9 when "1001",
									r10 when "1010",
									r11 when "1011",
									r12 when "1100",
									r13 when "1101",
									r14 when "1110",
									pc when "1111",
									x"00000000" when others;

	with radr1 select reg_v1 <=			r0_v when "0000",
									r1_v when "0001",
									r2_v when "0010",
									r3_v when "0011",
									r4_v when "0100",
									r5_v when "0101",
									r6_v when "0110",
									r7_v when "0111",
									r8_v when "1000",
									r9_v when "1001",
									r10_v when "1010",
									r11_v when "1011",
									r12_v when "1100",
									r13_v when "1101",
									r14_v when "1110",
									pcv when "1111",
									'0' when others;

	with radr2 select reg_rd2 <=	r0 when "0000",
									r1 when "0001",
									r2 when "0010",
									r3 when "0011",
									r4 when "0100",
									r5 when "0101",
									r6 when "0110",
									r7 when "0111",
									r8 when "1000",
									r9 when "1001",
									r10 when "1010",
									r11 when "1011",
									r12 when "1100",
									r13 when "1101",
									r14 when "1110",
									pc when "1111",
									x"00000000" when others;

	with radr2 select reg_v2 <=		r0_v when "0000",
									r1_v when "0001",
									r2_v when "0010",
									r3_v when "0011",
									r4_v when "0100",
									r5_v when "0101",
									r6_v when "0110",
									r7_v when "0111",
									r8_v when "1000",
									r9_v when "1001",
									r10_v when "1010",
									r11_v when "1011",
									r12_v when "1100",
									r13_v when "1101",
									r14_v when "1110",
									pcv when "1111",
									'0' when others;

	with radr3 select reg_rd3 <=	r0 when "0000",
									r1 when "0001",
									r2 when "0010",
									r3 when "0011",
									r4 when "0100",
									r5 when "0101",
									r6 when "0110",
									r7 when "0111",
									r8 when "1000",
									r9 when "1001",
									r10 when "1010",
									r11 when "1011",
									r12 when "1100",
									r13 when "1101",
									r14 when "1110",
									pc when "1111",
									x"00000000" when others;

	with radr3 select reg_v3 <=		r0_v when "0000",
									r1_v when "0001",
									r2_v when "0010",
									r3_v when "0011",
									r4_v when "0100",
									r5_v when "0101",
									r6_v when "0110",
									r7_v when "0111",
									r8_v when "1000",
									r9_v when "1001",
									r10_v when "1010",
									r11_v when "1011",
									r12_v when "1100",
									r13_v when "1101",
									r14_v when "1110",
									pcv when "1111",
									'0' when others;

	reg_pc <= pc;
	reg_pcv <= pcv;

	process(ck)
	begin
		if(rising_edge(ck)) then
			if(reset_n = '0') then
				r0_v <= '1';
				r1_v <= '1';
				r2_v <= '1';
				r3_v <= '1';
				r4_v <= '1';
				r5_v <= '1';
				r6_v <= '1';
				r7_v <= '1';
				r8_v <= '1';
				r9_v <= '1';
				r10_v <= '1';
				r11_v <= '1';
				r12_v <= '1';
				r13_v <= '1';
				r14_v <= '1';
				cznv <= '1';
				vv <= '1';
				pcv <= '1';
				pc <= x"00000000";
			else
				if(cznv = '1') then
					if(inval_czn = '1') then
						cznv <= '0';
					else
						cznv <= '1';
					end if;
				else
					if(inval_czn = '0') then
						if(cspr_wb = '1') then
							cznv <= '1';
						else
							cznv <= '0';
						end if;
					else
						cznv <= '0';
					end if;
				end if;

				if (vv = '1') then
					if(inval_ovr = '1') then
						vv <= '0';
					else
						vv <= '1';
					end if;
				else
					if(inval_ovr = '0') then
						if(cspr_wb = '1') then
							vv <= '1';
						else
							vv <= '0';
						end if;
					else
						vv <= '0';
					end if;
				end if;

				if(r0_v = '1') then
					if((inval1 = '1' and inval_adr1 = "0000") or (inval2 = '1' and inval_adr2 = "0000")) then
						r0_v <= '0';
					else
						r0_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "0000") or (inval2 = '1' and inval_adr2 = "0000"))) then
						if((wen1 = '1' and wadr1 = "0000") or (wen2 = '1' and wadr2 = "0000")) then
							r0_v <= '1';
						else
							r0_v <= '0';
						end if;
					else
						r0_v <= '0';
					end if;
				end if;

				if(r1_v = '1') then
					if((inval1 = '1' and inval_adr1 = "0001") or (inval2 = '1' and inval_adr2 = "0001")) then
						r1_v <= '0';
					else
						r1_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "0001") or (inval2 = '1' and inval_adr2 = "0001"))) then
						if((wen1 = '1' and wadr1 = "0001") or (wen2 = '1' and wadr2 = "0001")) then
							r1_v <= '1';
						else
							r1_v <= '0';
						end if;
					else
						r1_v <= '0';
					end if;
				end if;

				if(r2_v = '1') then
					if((inval1 = '1' and inval_adr1 = "0010") or (inval2 = '1' and inval_adr2 = "0010")) then
						r2_v <= '0';
					else
						r2_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "0010") or (inval2 = '1' and inval_adr2 = "0010"))) then
						if((wen1 = '1' and wadr1 = "0010") or (wen2 = '1' and wadr2 = "0010")) then
							r2_v <= '1';
						else
							r2_v <= '0';
						end if;
					else
						r2_v <= '0';
					end if;
				end if;

				if(r3_v = '1') then
					if((inval1 = '1' and inval_adr1 = "0011") or (inval2 = '1' and inval_adr2 = "0011")) then
						r3_v <= '0';
					else
						r3_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "0011") or (inval2 = '1' and inval_adr2 = "0011"))) then
						if((wen1 = '1' and wadr1 = "0011") or (wen2 = '1' and wadr2 = "0011")) then
							r3_v <= '1';
						else
							r3_v <= '0';
						end if;
					else
						r3_v <= '0';
					end if;
				end if;

				if(r4_v = '1') then
					if((inval1 = '1' and inval_adr1 = "0100") or (inval2 = '1' and inval_adr2 = "0100")) then
						r4_v <= '0';
					else
						r4_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "0100") or (inval2 = '1' and inval_adr2 = "0100"))) then
						if((wen1 = '1' and wadr1 = "0100") or (wen2 = '1' and wadr2 = "0100")) then
							r4_v <= '1';
						else
							r4_v <= '0';
						end if;
					else
						r4_v <= '0';
					end if;
				end if;

				if(r5_v = '1') then
					if((inval1 = '1' and inval_adr1 = "0101") or (inval2 = '1' and inval_adr2 = "0101")) then
						r5_v <= '0';
					else
						r5_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "0101") or (inval2 = '1' and inval_adr2 = "0101"))) then
						if((wen1 = '1' and wadr1 = "0101") or (wen2 = '1' and wadr2 = "0101")) then
							r5_v <= '1';
						else
							r5_v <= '0';
						end if;
					else
						r5_v <= '0';
					end if;
				end if;

				if(r6_v = '1') then
					if((inval1 = '1' and inval_adr1 = "0110") or (inval2 = '1' and inval_adr2 = "0110")) then
						r6_v <= '0';
					else
						r6_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "0110") or (inval2 = '1' and inval_adr2 = "0110"))) then
						if((wen1 = '1' and wadr1 = "0110") or (wen2 = '1' and wadr2 = "0110")) then
							r6_v <= '1';
						else
							r6_v <= '0';
						end if;
					else
						r6_v <= '0';
					end if;
				end if;

				if(r7_v = '1') then
					if((inval1 = '1' and inval_adr1 = "0111") or (inval2 = '1' and inval_adr2 = "0111")) then
						r7_v <= '0';
					else
						r7_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "0111") or (inval2 = '1' and inval_adr2 = "0111"))) then
						if((wen1 = '1' and wadr1 = "0111") or (wen2 = '1' and wadr2 = "0111")) then
							r7_v <= '1';
						else
							r7_v <= '0';
						end if;
					else
						r7_v <= '0';
					end if;
				end if;

				if(r8_v = '1') then
					if((inval1 = '1' and inval_adr1 = "1000") or (inval2 = '1' and inval_adr2 = "1000")) then
						r8_v <= '0';
					else
						r8_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "1000") or (inval2 = '1' and inval_adr2 = "1000"))) then
						if((wen1 = '1' and wadr1 = "1000") or (wen2 = '1' and wadr2 = "1000")) then
							r8_v <= '1';
						else
							r8_v <= '0';
						end if;
					else
						r8_v <= '0';
					end if;
				end if;

				if(r9_v = '1') then
					if((inval1 = '1' and inval_adr1 = "1001") or (inval2 = '1' and inval_adr2 = "1001")) then
						r9_v <= '0';
					else
						r9_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "1001") or (inval2 = '1' and inval_adr2 = "1001"))) then
						if((wen1 = '1' and wadr1 = "1001") or (wen2 = '1' and wadr2 = "1001")) then
							r9_v <= '1';
						else
							r9_v <= '0';
						end if;
					else
						r9_v <= '0';
					end if;
				end if;

				if(r10_v = '1') then
					if((inval1 = '1' and inval_adr1 = "1010") or (inval2 = '1' and inval_adr2 = "1010")) then
						r10_v <= '0';
					else
						r10_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "1010") or (inval2 = '1' and inval_adr2 = "1010"))) then
						if((wen1 = '1' and wadr1 = "1010") or (wen2 = '1' and wadr2 = "1010")) then
							r10_v <= '1';
						else
							r10_v <= '0';
						end if;
					else
						r10_v <= '0';
					end if;
				end if;

				if(r11_v = '1') then
					if((inval1 = '1' and inval_adr1 = "1011") or (inval2 = '1' and inval_adr2 = "1011")) then
						r11_v <= '0';
					else
						r11_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "1011") or (inval2 = '1' and inval_adr2 = "1011"))) then
						if((wen1 = '1' and wadr1 = "1011") or (wen2 = '1' and wadr2 = "1011")) then
							r11_v <= '1';
						else
							r11_v <= '0';
						end if;
					else
						r11_v <= '0';
					end if;
				end if;

				if(r12_v = '1') then
					if((inval1 = '1' and inval_adr1 = "1100") or (inval2 = '1' and inval_adr2 = "1100")) then
						r12_v <= '0';
					else
						r12_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "1100") or (inval2 = '1' and inval_adr2 = "1100"))) then
						if((wen1 = '1' and wadr1 = "1100") or (wen2 = '1' and wadr2 = "1100")) then
							r12_v <= '1';
						else
							r12_v <= '0';
						end if;
					else
						r12_v <= '0';
					end if;
				end if;

				if(r13_v = '1') then
					if((inval1 = '1' and inval_adr1 = "1101") or (inval2 = '1' and inval_adr2 = "1101")) then
						r13_v <= '0';
					else
						r13_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "1101") or (inval2 = '1' and inval_adr2 = "1101"))) then
						if((wen1 = '1' and wadr1 = "1101") or (wen2 = '1' and wadr2 = "1101")) then
							r13_v <= '1';
						else
							r13_v <= '0';
						end if;
					else
						r13_v <= '0';
					end if;
				end if;

				if(r14_v = '1') then
					if((inval1 = '1' and inval_adr1 = "1110") or (inval2 = '1' and inval_adr2 = "1110")) then
						r14_v <= '0';
					else
						r14_v <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "1110") or (inval2 = '1' and inval_adr2 = "1110"))) then
						if((wen1 = '1' and wadr1 = "1110") or (wen2 = '1' and wadr2 = "1110")) then
							r14_v <= '1';
						else
							r14_v <= '0';
						end if;
					else
						r14_v <= '0';
					end if;
				end if;

				if(pcv = '1') then
					if((inval1 = '1' and inval_adr1 = "1111") or (inval2 = '1' and inval_adr2 = "1111")) then
						pcv <= '0';
					else
						pcv <= '1';
					end if;
				else
					if((not(inval1 = '1' and inval_adr1 = "1111") or (inval2 = '1' and inval_adr2 = "1111"))) then
						if((wen1 = '1' and wadr1 = "1111") or (wen2 = '1' and wadr2 = "1111")) then
							pcv <= '1';
						else
							pcv <= '0';
						end if;
					else
						pcv <= '0';
					end if;
				end if;
			end if;


			if(cznv = '0') then
				if(cspr_wb = '1') then
					c <= wcry;
					z <= wzero;
					n <= wneg;
				end if;
			else
				c <= c;
				z <= z;
				n <= n;
			end if;

			if(vv = '0') then
				if(cspr_wb = '1') then
					ovr <= wovr;
				end if;
			else
				ovr <= ovr;
			end if;

			if((r0_v = '0') and (wen1 = '1' and wadr1 = "0000")) then
				r0 <= wdata1;
			elsif((r0_v ='0') and (wen2 = '1' and wadr2 = "0000")) then
				r0 <= wdata2;
			else
				r0 <= r0;
			end if;

			if((r1_v = '0') and (wen1 = '1' and wadr1 = "0001")) then
				r1 <= wdata1;
			elsif((r1_v ='0') and (wen2 = '1' and wadr2 = "0001")) then
				r1 <= wdata2;
			else
				r1 <= r1;
			end if;

			if((r2_v = '0') and (wen1 = '1' and wadr1 = "0010")) then
				r2 <= wdata1;
			elsif((r2_v ='0') and (wen2 = '1' and wadr2 = "0010")) then
				r2 <= wdata2;
			else
				r2 <= r2;
			end if;

			if((r3_v = '0') and (wen1 = '1' and wadr1 = "0011")) then
				r3 <= wdata1;
			elsif((r3_v ='0') and (wen2 = '1' and wadr2 = "0011")) then
				r3 <= wdata2;
			else
				r3 <= r3;
			end if;

			if((r4_v = '0') and (wen1 = '1' and wadr1 = "0100")) then
				r4 <= wdata1;
			elsif((r4_v ='0') and (wen2 = '1' and wadr2 = "0100")) then
				r4 <= wdata2;
			else
				r4 <= r4;
			end if;

			if((r5_v = '0') and (wen1 = '1' and wadr1 = "0101")) then
				r5 <= wdata1;
			elsif((r5_v ='0') and (wen2 = '1' and wadr2 = "0101")) then
				r5 <= wdata2;
			else
				r5 <= r5;
			end if;

			if((r6_v = '0') and (wen1 = '1' and wadr1 = "0110")) then
				r6 <= wdata1;
			elsif((r6_v ='0') and (wen2 = '1' and wadr2 = "0110")) then
				r6 <= wdata2;
			else
				r6 <= r6;
			end if;

			if((r7_v = '0') and (wen1 = '1' and wadr1 = "0111")) then
				r7 <= wdata1;
			elsif((r7_v ='0') and (wen2 = '1' and wadr2 = "0111")) then
				r7 <= wdata2;
			else
				r7 <= r7;
			end if;

			if((r8_v = '0') and (wen1 = '1' and wadr1 = "1000")) then
				r8 <= wdata1;
			elsif((r8_v ='0') and (wen2 = '1' and wadr2 = "1000")) then
				r8 <= wdata2;
			else
				r8 <= r8;
			end if;

			if((r9_v = '0') and (wen1 = '1' and wadr1 = "1001")) then
				r9 <= wdata1;
			elsif((r9_v ='0') and (wen2 = '1' and wadr2 = "1001")) then
				r9 <= wdata2;
			else
				r9 <= r9;
			end if;

			if((r10_v = '0') and (wen1 = '1' and wadr1 = "1010")) then
				r10 <= wdata1;
			elsif((r10_v ='0') and (wen2 = '1' and wadr2 = "1010")) then
				r10 <= wdata2;
			else
				r10 <= r10;
			end if;

			if((r11_v = '0') and (wen1 = '1' and wadr1 = "1011")) then
				r11 <= wdata1;
			elsif((r11_v ='0') and (wen2 = '1' and wadr2 = "1011")) then
				r11 <= wdata2;
			else
				r11 <= r11;
			end if;

			if((r12_v = '0') and (wen1 = '1' and wadr1 = "1100")) then
				r12 <= wdata1;
			elsif((r12_v ='0') and (wen2 = '1' and wadr2 = "1100")) then
				r12 <= wdata2;
			else
				r12 <= r12;
			end if;

			if((r13_v = '0') and (wen1 = '1' and wadr1 = "1101")) then
				r13 <= wdata1;
			elsif((r13_v ='0') and (wen2 = '1' and wadr2 = "1101")) then
				r13 <= wdata2;
			else
				r13 <= r13;
			end if;

			if((r14_v = '0') and (wen1 = '1' and wadr1 = "1110")) then
				r14 <= wdata1;
			elsif((r14_v ='0') and (wen2 = '1' and wadr2 = "1110")) then
				r14 <= wdata2;
			else
				r14 <= r14;
			end if;

			if(reset_n = '0') then
				pc <= x"00000000";
			elsif((pcv = '0') and (wen1 = '1' and wadr1 = "1111")) then
				pc <= wdata1;
			elsif((pcv = '0') and (wen2 = '1' and wadr2 = "1111")) then
				pc <= wdata2;
			elsif((pcv = '1') and (inc_pc = '1')) then
				pc <= std_logic_vector(unsigned(pc) + 4);
			else
				pc <= pc;
			end if;
		end if;
	end process;
	
end Behavior;
