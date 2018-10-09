--Filtro Fir Com MAC otimizado e arquitetura paralela
Library ieee;
use ieee.std_logic_1164.all;

Entity fir is 
port(clk: in std_logic;
     x: in std_logic_vector(3 downto 0);
	  y: out std_logic_vector(7 downto 0)
);
end entity;

Architecture funcionamento of fir is

component somador is
port(a,b : in std_logic_vector(7 downto 0);
     res_soma : out std_logic_vector(7 downto 0)
);
end component;

component subtrator is
port(a,b : in std_logic_vector(7 downto 0);
     res : out std_logic_vector(7 downto 0)
);
end component;

component registrador is 
port(clk: in std_logic;
     ent: in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(3 downto 0)
);
end component;

component mh0 is
port (x : in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(7 downto 0)
);
end component;

component mh1 is
port (x : in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(7 downto 0)
);
end component;

component mh2 is
port (x : in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(7 downto 0)
);
end component;

component mh3 is
port (x : in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(7 downto 0)
);
end component;

signal reg1_reg2,reg2_reg3,reg3_mult4: std_logic_vector(3 downto 0);
signal mult1_soma1,mult2_soma1,
soma1_soma2,mult3_soma2,
soma2_soma3,mult4_soma3: std_logic_vector(7 downto 0);

begin 

reg1 : registrador port map(clk,x,reg1_reg2);
reg2 : registrador port map(clk,reg1_reg2,reg2_reg3);--entrada-liga-saida = entrada reg2 liga saida reg3
reg3 : registrador port map(clk,reg2_reg3,reg3_mult4);

mult1 : mh0 port map(x,mult1_soma1);
mult2 : mh1 port map(reg1_reg2,mult2_soma1);
mult3 : mh2 port map(reg2_reg3,mult3_soma2);
mult4 : mh3 port map(reg3_mult4,mult4_soma3);

soma1 : somador port map(mult1_soma1,mult2_soma1,soma1_soma2);
soma2 : somador port map(soma1_soma2,mult3_soma2,soma2_soma3);
soma3 : somador port map(soma2_soma3,mult4_soma3,y);

end architecture;