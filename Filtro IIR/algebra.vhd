--Filtro IIR com Transformacao Algebrica
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

entity algebra is 
port (clk : in std_logic; 
	   xn : in std_logic_vector(7 downto 0);
	    a : in std_logic_vector(7 downto 0);
	   yn,yn1 : out std_logic_vector(7 downto 0)
);
end algebra;

Architecture funcionamento of algebra is
--Para compreender os Signals observe os portmaps e siga o caminho indicado
-- reg2_mult1 -> no que vai para baixo
-- reg4_mult3 -> no que vai para cima
signal soma1_soma2,soma2_reg1,reg1_reg2,reg2_mult1,mult1_soma3,soma3_reg3,reg3_yn1,
mult2_soma2,mult2a_mult2,mult3_soma1,reg4_mult3: std_logic_vector(7 downto 0);

begin
-- Comeca em Xn e segue no sentido horario 
c_soma1  : somador port map (xn,mult3_soma1,soma1_soma2);
c_soma2  : somador port map (soma1_soma2,mult2_soma2,soma2_reg1);
c_reg1   : registrador port map (clk,soma2_reg1,reg1_reg2);
c_reg2   : registrador port map (clk,reg1_reg2,reg2_mult1);
c_mult1  : multiplicador port map (reg2_mult1,a,mult1_soma3);
c_soma3  : somador port map (reg4_mult3,mult1_soma3,soma3_reg3);
-- Aqui ele vai para direita e termina o caminho (Yn-1)
c_reg3   : registrador port map (clk,soma3_reg3,reg3_yn1);
-- Comeca no A^2 e segue para cima ate c_soma2 e termina
c_mult2a : multiplicador port map(a,a,mult2a_mult2);
c_mult2  : multiplicador port map (mult2a_mult2,reg2_mult1,mult2_soma2);
-- Comeca no canto inferior esquerdo (Xn-1),sobe e termina
c_reg4   : registrador port map (clk,xn,reg4_mult3);
c_mult3  : multiplicador port map (reg4_mult3,a,mult3_soma1);	

yn<= soma2_reg1;
yn1<= reg3_yn1;

end funcionamento;