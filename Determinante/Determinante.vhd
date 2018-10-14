--Determinante Ok
--[x1,x2]
--[x3,x4]
--Determinate =  (x1*x4) - (x3*x2)

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

Entity Determinante is
port (x1,x2,x3,x4 : in integer range 0 to 7;
	  resp: out integer range 0 to 15
);

end Determinante;

architecture funcionamento of Determinante is 

signal s1,s2: integer range 0 to 15;

begin

s1 <= x1*x4;
s2 <= x3*x2;
resp <= s1-s2;

end funcionamento;