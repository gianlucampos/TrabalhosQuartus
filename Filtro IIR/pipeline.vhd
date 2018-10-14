--Filtro IIR com Pipeline
--Autor: Gianluca Campos
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity somador is 
port ( a,b : in std_logic_vector  (7 downto 0);
	     res : out std_logic_vector (7 downto 0)
);
end somador;

Architecture funcionamento of somador is

begin

res <= a + b;

end funcionamento;
----------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplicador is 
port ( a,b : in std_logic_vector (7 downto 0);
	   res: out std_logic_vector (7 downto 0)
);
end multiplicador;

Architecture funcionamento of multiplicador is

signal aux : std_logic_vector (15 downto 0);

begin

aux <= a*b;
res <= aux(15 downto 8);

end funcionamento;
---------------------------------------------- 
Library ieee;
use ieee.std_logic_1164.all;

entity registrador is 
port ( clk : in std_logic;
       ent : in std_logic_vector(7 downto 0);
      saida: out std_logic_vector(7 downto 0)
);

end registrador;

Architecture funcionamento of registrador is 

begin
	process(clk)
begin
	if clk'event and clk = '1' then
		saida <= ent;
		end if;
	end process;
end funcionamento;
----------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;

package my_components is 

component somador is 
port ( a,b : in std_logic_vector (7 downto 0);
	   res: out std_logic_vector (7 downto 0)
);
end component;


component multiplicador is 
port ( a,b : in std_logic_vector (7 downto 0);
	   res: out std_logic_vector (7 downto 0)
);
end component;

component registrador is 
port ( clk : in std_logic;
       ent : in std_logic_vector(7 downto 0);
      saida: out std_logic_vector(7 downto 0)
);
end component;

end my_components;
----------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity pipeline is 
port (clk : in std_logic; 
	   xn : in std_logic_vector(7 downto 0);
	    a : in std_logic_vector(7 downto 0);
	   yn,yn1 : out std_logic_vector(7 downto 0)
);
end pipeline;

Architecture funcionamento of pipeline is
--sentido comeca em XN, percorre sentido horario ate ir para Yn-1
signal soma1_reg1,reg1_soma2,soma2_yn,soma2_reg2,
reg2_reg3,reg3_mult1,mult1_soma3,soma3_reg4,
reg4_yn1,
--sentido comeca no no do reg3 e vai para esquerda e sobe ate soma2
reg3_mult2,mult2a_mult2,mult2_soma2,
--sentido comeca em xn-1(reg5) e sobe
reg5_mult3,mult3_soma1,
--sentido comeca em xn-1(reg5) e segue para direita
reg5_reg6,reg6_soma3: std_logic_vector(7 downto 0);--reg5_mult3 = reg5_reg6

begin

c_soma1  : somador port map (xn,mult3_soma1,soma1_reg1);
c_reg1	 : registrador port map (clk,soma1_reg1,reg1_soma2);
c_soma2  : somador port map (reg1_soma2,mult2_soma2,soma2_reg2);
c_reg2   : registrador port map (clk,soma2_reg2,reg2_reg3);
c_reg3	 : registrador port map (clk,reg2_reg3,reg3_mult1);--reg3_mult1 = reg3_mult2
c_mult1  : multiplicador port map (a,reg3_mult1,mult1_soma3);
c_soma3  : somador port map (reg6_soma3,mult1_soma3,soma3_reg4);
c_reg4   : registrador port map (clk,soma3_reg4,reg4_yn1);

c_mult2a : multiplicador port map (a,a,mult2a_mult2);
c_mult2  : multiplicador port map (mult2a_mult2,reg3_mult1,mult2_soma2);

c_reg5   : registrador port map (clk,xn,reg5_mult3);
c_mult3  : multiplicador port map (a,reg5_mult3,mult3_soma1);

c_reg6   : registrador port map (clk,reg5_mult3,reg6_soma3);

yn<= soma2_reg2;
yn1<= reg4_yn1;

end funcionamento;