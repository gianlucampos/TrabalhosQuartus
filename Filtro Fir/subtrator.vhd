library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity subtrator is
port(a,b : in std_logic_vector(7 downto 0);
     res_sub : out std_logic_vector(7 downto 0)
);
end subtrator;

Architecture funcionamento of subtrator is

begin

res_sub <= a - b;

end funcionamento;