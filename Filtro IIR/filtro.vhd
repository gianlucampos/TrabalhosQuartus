--Entidades Somador,Multiplicador,Registrador e Filtro IIR padrão
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

entity filtro is 
port (clk : in std_logic; 
	   xn : in std_logic_vector(7 downto 0);
	    a : in std_logic_vector(7 downto 0);
	   yn : out std_logic_vector(7 downto 0)
);

end filtro;

Architecture funcionamento of filtro is

signal xnsoma_reg,xnreg_mult,xnmult_soma : std_logic_vector(7 downto 0);

begin

c_soma : somador port map (xn,xnmult_soma,yn);
c_mult : multiplicador port map (a,xnreg_mult,xnmult_soma);
c_reg  : registrador port map (clk,xnsoma_reg,xnreg_mult);

end funcionamento;