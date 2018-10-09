--Trabalho 4: Filtro Fir com Arquitetura Transposta

Library ieee;
use ieee.std_logic_1164.all;

Entity fir_transposto is 
port(clk: in std_logic;
     xn: in std_logic_vector(7 downto 0);
	 h0,h1,h2,h3,h4,h5,h6,h7: in std_logic_vector(7 downto 0);
	 yn: out std_logic_vector(15 downto 0)
);
end entity;

Architecture funcionamento of fir_transposto is 

component somador is
port(a,b : in std_logic_vector(15 downto 0);
     res_soma : out std_logic_vector(15 downto 0)
);
end component;

component registrador is 
port(clk: in std_logic;
     ent: in std_logic_vector(15 downto 0);
	saida: out std_logic_vector(15 downto 0)
);
end component;

component multiplicador is
port(a,b : in std_logic_vector(7 downto 0);
     res_mult : out std_logic_vector(15 downto 0)
);
end component;

--8 Signals para Multiplicadores
signal sm7,sm6,sm5,sm4,sm3,sm2,sm1,sm0: std_logic_vector(15 downto 0);

--7 Signals para Registradores
signal sr6,sr5,sr4,sr3,sr2,sr1,sr0: std_logic_vector(15 downto 0);

--5 Signals para Somadores
signal ss5,ss4,ss3,ss2,ss1,ss0: std_logic_vector(15 downto 0);

begin

--8 Multiplicadores
mult7 : multiplicador port map (xn,h7,sm7);
mult6 : multiplicador port map (xn,h6,sm6);
mult5 : multiplicador port map (xn,h5,sm5);
mult4 : multiplicador port map (xn,h4,sm4);

mult3 : multiplicador port map (xn,h3,sm3);
mult2 : multiplicador port map (xn,h2,sm2);
mult1 : multiplicador port map (xn,h1,sm1);
mult0 : multiplicador port map (xn,h0,sm0);

--7 Registradores

reg6 : registrador port map (clk,sm7,sr6);
reg5 : registrador port map (clk,ss5,sr5);
reg4 : registrador port map (clk,ss4,sr4);
reg3 : registrador port map (clk,ss3,sr3);

reg2 : registrador port map (clk,ss2,sr2);
reg1 : registrador port map (clk,ss1,sr1);
reg0 : registrador port map (clk,ss0,sr0);

--6 Somadores

soma5 : somador port map (sr6,sm6,ss5);
soma4 : somador port map (sr5,sm5,ss4);
soma3 : somador port map (sr4,sm4,ss3);

soma2 : somador port map (sr3,sm3,ss2);
soma1 : somador port map (sr2,sm2,ss1);
soma0 : somador port map (sr1,sm1,ss0);

end architecture;