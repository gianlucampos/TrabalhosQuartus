library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

Entity multiplicador is
port(a,b : in std_logic_vector(7 downto 0);
     res_mult : out std_logic_vector(15 downto 0)
);
end multiplicador;

Architecture funcionamento of multiplicador is

begin

res_mult <= a * b;

end funcionamento;