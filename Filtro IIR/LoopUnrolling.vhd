--Filtro IIR LoopUnrolling
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

entity loopUnrolling is 
port (clk : in std_logic; 
	   xn : in std_logic_vector(7 downto 0);
	    a : in std_logic_vector(7 downto 0);
	   yn,yn1 : buffer std_logic_vector(7 downto 0)
);
end loopUnrolling;

Architecture funcionamento of loopUnrolling is

signal reg1_reg2,reg2_mult1,mult1_soma2,
reg3_soma2,soma2_reg4,mult2_soma1: std_logic_vector(7 downto 0);

begin

c_soma1 : somador port map (xn,mult2_soma1,yn);
c_reg1  : registrador port map (clk,yn,reg1_reg2);
c_reg2  : registrador port map (clk,reg1_reg2,reg2_mult1);
c_mult1 : multiplicador port map (a,reg2_mult1,mult1_soma2);
c_reg3  : registrador port map (clk,xn,reg3_soma2);
c_soma2 : somador port map (reg3_soma2,mult1_soma2,soma2_reg4);
c_reg4  : registrador port map (clk,soma2_reg4,yn1);
c_mult2 : multiplicador port map (a,yn1,mult2_soma1);


end funcionamento;