library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Ula is 
port (
		opUla: 	 				 in std_logic_vector(1 downto 0);
		r1, r2: 			 		 in std_logic_vector(7 downto 0);
		saida: 					out std_logic_vector(7 downto 0);
		zero:					   out std_logic
);
end Ula;

architecture funcionamento of Ula is
--am  = add
--tr  = and,or,add,sub
--beq = sub
begin process (opUla)
	
	begin
-- AND
	if (opUla = "00") then 
		saida <= r1 and r2;
		zero <= '0';
	end if;
	
-- OR
	if (opUla = "01") then 
		saida <= r1 or r2;
		zero <= '0';
	end if;
-- ADD	
	if (opUla = "10") then 
		saida <= r1 + r2;
		zero <= '0';
	end if;
	
-- SUB
	if (opUla = "11") then
		saida <= r1 - r2;
		if(r1 = r2) then
			zero <= '1';
		else
			zero <= '0';
		end if;
	end if;
end process;
end funcionamento;