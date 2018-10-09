---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------
ENTITY Ram IS
GENERIC ( bits: INTEGER := 8;
			 words: INTEGER := 16);
PORT ( 
			 escreve_reg, clk: IN STD_LOGIC;
			 rd: IN INTEGER RANGE 0 TO words-1;
			 data_in: IN STD_LOGIC_VECTOR (bits-1 DOWNTO 0);
			 data_out: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0)
);
END Ram;
---------------------------------------------------
ARCHITECTURE Ram OF Ram IS
TYPE vector_array IS ARRAY (0 TO words-1) OF
			STD_LOGIC_VECTOR (bits-1 DOWNTO 0);

SIGNAL memory: vector_array;

BEGIN
PROCESS (clk, escreve_reg)
	BEGIN
	IF (escreve_reg='1') THEN
		IF (clk'EVENT AND clk='1') THEN
			memory(rd) <= data_in;
		END IF;
	END IF;
END PROCESS;

data_out <= memory(rd);

END Ram;
---------------------------------------------------