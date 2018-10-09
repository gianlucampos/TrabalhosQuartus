--Entidade multiplicador H1 (1010) = -6
----------------------------------------
Library ieee;
use ieee.std_logic_1164.all;

entity mh1 is 
port (x : in std_logic_vector(3 downto 0);
  saida : out std_logic_vector(7 downto 0)
);
end mh1;

Architecture funcionamento of mh1 is

component subtrator is
port (a,b : in std_logic_vector (7 downto 0);
	   res_sub : out std_logic_vector(7 downto 0)
);
end component;

signal h1: std_logic_vector(3 downto 0);--vai ser o valor 1010(-6)
signal res,res_h1,res_h3 : std_logic_vector (7 downto 0);

begin

h1 <= "1010";
--só nos interessa os niveis logicos em 1 de h1
res(0) <= h1(1) and x(0);
res(1) <= h1(1) and x(1);
res(2) <= h1(1) and x(2);
res(3) <= h1(1) and x(3);

res(4) <= h1(3) and x(0);
res(5) <= h1(3) and x(1);
res(6) <= h1(3) and x(2);
res(7) <= h1(3) and x(3);

res_h1 <= "111" & res(3) & res(2) & res(1) & res(0) & '0';
res_h3 <= '1' & res(7) & res(6) & res(5) & res(4) & "000";

c_mh1 : subtrator port map (res_h1,res_h3,saida);

end funcionamento;









