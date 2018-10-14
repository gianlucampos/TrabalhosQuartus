--Divisor 1/det
--Foi utilizado o divisor que está no livro do Pedroni
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------
Entity Divisor is 
port ( a : in integer range 0 to 15;
	   y : OUT std_logic_vector (3 downto 0);
	   resto: OUT INTEGER RANGE 0 TO 15;
	   erro : OUT STD_LOGIC
);
end Divisor;

Architecture funcionamento of Divisor is

begin

process(a)
variable t1: integer range 0 to 15;--dividendo
variable t2: integer range 0 to 15;--divisor

begin

t1 := 1;
t2 := a;

--Nao deixa dividir por 0
if (a=0) then 
 erro <= '1';
else 
 erro <= '0';
end if;

--Segue abaixo a divisão utilizada no livro:
-- y(3)
IF (t1 >= t2 * 8) THEN
 y(3) <= '1';
 t1 := t1 - t2*8;
ELSE 
 y(3) <= '0';
END IF;

-- y(2)
IF (t1 >= t2 * 4) THEN
 y(2) <= '1';
 t1 := t1 - t2 * 4;
ELSE 
 y(2) <= '0';
END IF;

-- y(1)
IF (t1 >= t2 * 2) THEN
 y(1) <= '1';
 t1 := t1 - t2 * 2;
ELSE 
 y(1) <= '0';
END IF;
 
-- y(0) 
IF (t1 >= t2) THEN
 y(0) <= '1';
 t1 := t1 - t2;
ELSE 
 y(0) <= '0';
END IF;
 
resto <= t1; 

END PROCESS;
END architecture;