--(serve para carregar X)
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY regX IS
PORT ( clk, LX : IN STD_LOGIC;
	      d : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END regX;

Architecture funcionamento of regX is
Begin
Process(LX,clk)
Begin 

	IF clk'EVENT AND clk = '1' THEN
		IF LX = '1' THEN
			q <= d;
		end if;
	end if;

END PROCESS;

end funcionamento;
-------------------------------------

--(escolhe se vai ABC ou X)
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux4x1 IS
PORT (     LM1: IN STD_LOGIC_VECTOR (1 downto 0);
       x,a,b,c: IN STD_LOGIC_VECTOR (7 downto 0);
             y: OUT STD_LOGIC_VECTOR (7 downto 0)
);
END mux4x1;

Architecture funcionamento of mux4x1 is
BEGIN
PROCESS (LM1, x, a, b, c) 
BEGIN
CASE LM1 IS
	WHEN "00" => y <= x;
	WHEN "01" => y <= a;	
	WHEN "10" => y <= b;
	WHEN OTHERS => y <= c;
END CASE;
END PROCESS;
END funcionamento;
-------------------------------------
--(escolhe se * x(xm) ou +(soma) o polinomio)

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2x1 IS
PORT (     LM2: IN STD_LOGIC;
       xm,soma: IN STD_LOGIC_VECTOR (7 downto 0);
             y: OUT STD_LOGIC_VECTOR (7 downto 0)
);
END mux2x1;

Architecture funcionamento of mux2x1 is
BEGIN
PROCESS (LM2, xm, soma) 
BEGIN
CASE LM2 IS
	WHEN '0' => y <= xm;
	WHEN OTHERS => y <= soma;
END CASE;
END PROCESS;
END funcionamento;
-------------------------------------
--(escolhe se * ou +)

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY ula IS

PORT (opULA: IN STD_LOGIC;
	   m, s: STD_LOGIC_VECTOR (7 downto 0);
	ula_out: OUT STD_LOGIC_VECTOR (7 downto 0) 
);
END ula;  

ARCHITECTURE funcionamento OF ula IS

SIGNAL s1: STD_LOGIC_VECTOR (15 downto 0);

BEGIN
PROCESS (opULA, m, s, s1)
BEGIN

    IF opULA = '1' THEN
    s1 <= m * s;
	ula_out <= s1(7 downto 0);
	
	ELSE
	
	ula_out <= m + s;

END IF;
END PROCESS;	
	
END funcionamento;
-------------------------------------
--(recebe da ula o valor e desloca)

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg_final IS
PORT ( 	clk, LR2 : IN STD_LOGIC;
	 equacao_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	equacao_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END reg_final;

ARCHITECTURE funcionamento OF reg_final IS
BEGIN
PROCESS (clk)
BEGIN

IF clk'EVENT AND clk = '1' THEN

  equacao_out <= equacao_in;

END IF;

END PROCESS;

END funcionamento;
-------------------------------------
--(controla os signals do polinomio)
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mef IS
PORT (clk, clr: IN STD_LOGIC;
      LX, LM2, opULA,LR2: OUT STD_LOGIC;
      LM1: OUT STD_LOGIC_VECTOR (1 downto 0)
);
END mef;

ARCHITECTURE funcionamento OF mef IS
TYPE estados is (e0, e1, e2, e3, e4);
SIGNAL estado:estados;

BEGIN

PROCESS(clk,clr)
BEGIN

IF clr ='0'then
estado <= e0;

ELSE
IF (clk 'EVENT AND clk = '1') then

CASE estado is
  WHEN e0 => --x
		estado<= e1;
		LX    <= '1';
		LM1   <= "00";
		LM2   <= '1';
		opULA <= '1';
		LR2   <= '1';
  WHEN e1 => --Ax
		estado<= e2;
		LX    <= '0';
		LM1   <= "01";
		LM2   <= '0';
		opULA <= '1';
		LR2   <= '1';
  WHEN e2 => -- Ax + B
		estado<= e3;
		LX    <= '0';
		LM1   <= "10";
		LM2   <= '1';
		opULA <= '0';
		LR2   <= '1';
  WHEN e3 => -- (Ax + B)*x
		estado<= e4;
		LX    <= '0';
		LM1   <= "00";
		LM2   <= '1';
		opULA <= '1';
		LR2   <= '1';
  WHEN e4 => -- (Ax + B)*x + C
		estado<= e0;
		LX    <= '0';
		LM1   <= "11";
		LM2   <= '1';
		opULA <= '0';
		LR2   <= '0';

END CASE;
END IF;
END IF;
END PROCESS;
END funcionamento;
----- File my_components.vhd: ---------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE my_components IS


COMPONENT regX IS
PORT ( clk, LX : IN STD_LOGIC;
	      d : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END COMPONENT;

COMPONENT mux4x1 IS
PORT (     LM1: IN STD_LOGIC_VECTOR (1 downto 0);
       x,a,b,c: IN STD_LOGIC_VECTOR (7 downto 0);
             y: OUT STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;

COMPONENT mux2x1 IS
PORT (     LM2: IN STD_LOGIC;
       xm,soma: IN STD_LOGIC_VECTOR (7 downto 0);
             y: OUT STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;

COMPONENT ula IS
PORT (opULA: IN STD_LOGIC;
	   m, s: STD_LOGIC_VECTOR (7 downto 0);
	ula_out: OUT STD_LOGIC_VECTOR (7 downto 0) 
);
END COMPONENT;  

COMPONENT reg_final IS
PORT ( 	clk, LR2 : IN STD_LOGIC;
	 equacao_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	equacao_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END COMPONENT;

COMPONENT mef IS
PORT (clk, clr: IN STD_LOGIC;
      LX, LM2, opULA,LR2: OUT STD_LOGIC;
      LM1: OUT STD_LOGIC_VECTOR (1 downto 0)
);
END COMPONENT;

END my_components;
------------------------------------
--Entidade Principal: Polinomio

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;

ENTITY polinomio IS
	PORT (clk, clrn: IN STD_LOGIC;
	      X, A, B, C: IN STD_LOGIC_VECTOR (7 downto 0);
		  S: OUT STD_LOGIC_VECTOR (7 downto 0)
	);
END polinomio;

ARCHITECTURE funcionamento OF polinomio IS

--valor de X e da equação y
SIGNAL sx,sy: STD_LOGIC_VECTOR (7 downto 0);

--Maquina de Estados
SIGNAL s_lx,s_lm2,s_opULA,s_lr2: STD_LOGIC; 
SIGNAL s_lm1: STD_LOGIC_VECTOR (1 downto 0);

--Mux4x1 saida, Mux2x1 saida, Ula saida respectivamente
SIGNAL s0,s1,s2: STD_LOGIC_VECTOR (7 downto 0);

BEGIN

 	c_mef: 		mef    		port map (clk,clrn,s_lx,s_lm2,s_opULA,s_lr2,s_lm1);
	c_regx:   	regX   		port map (clk,s_lx,X,sx);
 	c_mux4x1:   mux4x1 		port map (s_lm1,sx,A,B,C,s0);
 	c_mux2x1:	mux2x1  	port map (s_lm2,sx,sy,s1);
 	c_ula:		ula			port map (s_opULA,s0,s1);
 	c_regfinal: reg_final	port map (clk,s_lr2,s2,sy);
    
S <= sy;

END funcionamento;
























