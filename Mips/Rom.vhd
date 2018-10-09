---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------
ENTITY Rom IS
GENERIC ( 
			 bits: INTEGER := 8;
			 words: INTEGER := 8
);
PORT ( 
		r1: IN INTEGER RANGE 0 TO words-1;
		r2: IN INTEGER RANGE 0 TO words-1;
		saida_r1: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0);
		saida_r2: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0)
);
END Rom;
---------------------------------------------------
ARCHITECTURE Rom OF Rom IS
TYPE vector_array IS ARRAY (0 TO words-1) OF
		STD_LOGIC_VECTOR (bits-1 DOWNTO 0);
		
CONSTANT memory: vector_array := (  
												"00000000",
											   "00000010",
												"00000100",
												"00001000",
												"00010000",
												"00100000",
												"01000000",
												"10000000"
);
BEGIN
saida_r1 <= memory(r1);
saida_r2 <= memory(r2);
END Rom;
---------------------------------------------------