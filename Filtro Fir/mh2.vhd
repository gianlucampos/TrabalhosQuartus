--Entidade multiplicador h2 (0111) = +7
Library ieee;
use ieee.std_logic_1164.all;

entity mh2 is 
port (x : in std_logic_vector(3 downto 0);
  saida : out std_logic_vector(7 downto 0)
);
end mh2;

Architecture funcionamento of mh2 is

component somador is
port(a,b : in std_logic_vector(7 downto 0);
     res_soma : out std_logic_vector(7 downto 0)
);
end component;

signal h2: std_logic_vector(3 downto 0);--vai ser o valor 0111 (+1)
signal res_h0,res_h1,res_h2,y0 : std_logic_vector (7 downto 0);--res_h2 = h2(2)
signal res : std_logic_vector (11 downto 0);

begin

h2 <= "0111";

res(0) <= h2(0) and x(0);
res(1) <= h2(0) and x(1);
res(2) <= h2(0) and x(2);
res(3) <= h2(0) and x(3);

res(4) <= h2(1) and x(0);
res(5) <= h2(1) and x(1);
res(6) <= h2(1) and x(2);
res(7) <= h2(1) and x(3);

res(8) <= h2(2) and x(0);
res(9) <= h2(2) and x(1);
res(10) <= h2(2) and x(2);
res(11) <= h2(2) and x(3);

res_h0 <= "0000" & res(3) & res(2) & res(1) & res(0);
res_h1 <= "000" & res(7) & res(6) & res(5) & res(4) & '0';
res_h2 <= "00" & res(11) & res(10) & res(9) & res(8) & "00";

c_mh2_parte : somador port map (res_h0,res_h1,y0);
c_mh2_resp  : somador port map (y0,res_h2,saida);

end funcionamento;









