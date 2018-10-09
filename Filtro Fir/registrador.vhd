LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY registrador IS
PORT ( 
		clk : IN STD_LOGIC;
		ent : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
	 saida : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END registrador;

ARCHITECTURE funcionamento OF registrador IS
 
 BEGIN
 
	PROCESS (clk)
		BEGIN
			IF clk  'EVENT AND clk = '1' THEN
			saida <= ent;
			END IF;
	END PROCESS;

END architecture; 