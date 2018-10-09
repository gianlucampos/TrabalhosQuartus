--Entidade multiplicador H0 (0101) = +5
Library ieee;
use ieee.std_logic_1164.all;
--use work.my_components.all;

entity mh0 is 
port (x : in std_logic_vector(3 downto 0);
  saida : out std_logic_vector(7 downto 0)
);
end mh0;

Architecture funcionamento of mh0 is

component somador is
port(a,b : in std_logic_vector(7 downto 0);
     res_soma : out std_logic_vector(7 downto 0)
);
end component;

signal h0: std_logic_vector(3 downto 0);--vai ser o valor 0101 (+5)
signal res,res_h0,res_h2 : std_logic_vector (7 downto 0);

begin

h0 <= "0101";

--só nos interessa os niveis logicos em 1 de h0
res(0) <= h0(0) and x(0);
res(1) <= h0(0) and x(1);
res(2) <= h0(0) and x(2);
res(3) <= h0(0) and x(3);

res(4) <= h0(2) and x(0);
res(5) <= h0(2) and x(1);
res(6) <= h0(2) and x(2);
res(7) <= h0(2) and x(3);

res_h0 <= "0000" & res(3) & res(2) & res(1) & res(0);
res_h2 <= "00" & res(7) & res(6) & res(5) & res(4) & "00";

c_mh0 : somador port map (res_h0,res_h2,saida);
end funcionamento;









