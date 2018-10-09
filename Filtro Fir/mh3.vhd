--Entidade mh3 (1111) -1
Library ieee;
use ieee.std_logic_1164.all;

entity mh3 is 
port (x : in std_logic_vector(3 downto 0);
  saida : out std_logic_vector(7 downto 0)
);
end mh3;

Architecture funcionamento of mh3 is

component somador is
port(a,b : in std_logic_vector(7 downto 0);
     res_soma : out std_logic_vector(7 downto 0)
);
end component;

component subtrator is
port(a,b : in std_logic_vector(7 downto 0);
     res_sub : out std_logic_vector(7 downto 0)
);
end component;

signal h3: std_logic_vector(3 downto 0);--vai ser o valor 1111(-1)
signal res_h0,res_h1,res_h2,res_h3,y0,y1 : std_logic_vector (7 downto 0);
signal res : std_logic_vector (15 downto 0);

begin

h3 <= "1111";
--dessa vez vamos pegar todos os niveis logicos de h3 e multiplicar por cada do x
res(0) <= h3(1) and x(0);
res(1) <= h3(1) and x(1);
res(2) <= h3(1) and x(2);
res(3) <= h3(1) and x(3);

res(4) <= h3(2) and x(0);
res(5) <= h3(3) and x(1);
res(6) <= h3(3) and x(2);
res(7) <= h3(3) and x(3);

res(8) <= h3(2) and x(0);
res(9) <= h3(2) and x(1);
res(10) <= h3(2) and x(2);
res(11) <= h3(2) and x(3);

res(12) <= h3(3) and x(0);
res(13) <= h3(3) and x(1);
res(14) <= h3(3) and x(2);
res(15) <= h3(3) and x(3);

res_h0 <= "1111" & res(3) & res(2) & res(1) & res(0);
res_h1 <= "111"  & res(7) & res(6) & res(5) & res(4) & '0';
res_h2 <= "11"   & res(11) & res(10) & res(9) & res(8) & "00";
res_h3 <= '1'    & res(12) & res(13) & res(14) & res(15) & "111";

c_mh3_parte1 : somador port map (res_h0,res_h1,y0);
c_mh3_parte2 : somador port map (y0,res_h2,y1);
c_mh3_res : subtrator port map (y1,res_h3,saida);

end funcionamento;