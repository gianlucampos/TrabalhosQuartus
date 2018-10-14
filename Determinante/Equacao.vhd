--Equacao 1/det[2x2]
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

Entity Equacao is 
port ( x1,x2,x3,x4 : in integer range 0 to 7;
	   resto	   : out integer range 0 to 15;
	   erro 	   : out std_logic;
	   saida	   : out std_logic_vector (3 downto 0)
);
end Equacao;

architecture funcionamento of Equacao is 

component Determinante is
port ( x1,x2,x3,x4 : in integer range 0 to 7;
			  resp : out integer range 0 to 15
);
END component;

component Divisor IS
	PORT ( 
	    a: IN INTEGER RANGE 0 TO 15;
		y: OUT std_logic_vector (3 downto 0);
		resto: OUT INTEGER RANGE 0 TO 15;
		erro : OUT STD_LOGIC
		);
 END component;

signal s : integer range 0  to 15;

begin

c_determinante : Determinante port map (x1,x2,x3,x4,s);
c_divisor	   : Divisor port map (s,saida,resto,erro);

end funcionamento;