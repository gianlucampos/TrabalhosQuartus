library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity somador is
port(a,b : in std_logic_vector(15 downto 0);
     res_soma : out std_logic_vector(15 downto 0)
);
end somador;

Architecture funcionamento of somador is

begin

res_soma <= a + b;

end funcionamento;