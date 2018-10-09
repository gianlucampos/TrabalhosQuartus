Library ieee;
use ieee.std_logic_1164.all;

Entity Mips is 
port(clk,escreve_reg:  in std_logic;
					opUla:  in std_logic_vector(1 downto 0);
				r1,r2,rd:  IN INTEGER RANGE 0 TO 7;
				rd_valor: out std_logic_vector(7 downto 0);
					 zero: out std_LOGIC
);
end Mips;

Architecture funcionamento of Mips is

component Rom is
PORT (r1: IN INTEGER RANGE 0 TO 7;
		r2: IN INTEGER RANGE 0 TO 7;
		saida_r1: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		saida_r2: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
end component;

component Ula is
port (opUla: 	 				 in std_logic_vector(1 downto 0);
		r1, r2: 			 		 in std_logic_vector(7 downto 0);
		saida: 					out std_logic_vector(7 downto 0);
		zero:					   out std_logic
);
end component;

component Ram is
PORT ( 	 escreve_reg, clk: IN STD_LOGIC;
			 rd: IN INTEGER RANGE 0 TO 15;
			 data_in: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			 data_out: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
end component;

signal sr1,sr2,s_ula,s_ram: std_logic_vector(7 downto 0);

begin

c_rom: Rom port map (r1,r2,sr1,sr2);
c_ula: Ula port map (opUla,sr1,sr2,s_ula,zero);
c_ram: Ram port map (escreve_reg,clk,rd,s_ula,s_ram);

rd_valor <= s_ram;

end funcionamento;