library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity subtractor is
	generic (N : positive := 8);
	port (
		a : in  std_logic_vector(N-1 downto 0);
		b : in  std_logic_vector(N-1 downto 0);
		s : out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture beh of subtractor is
	signal a_unsigned, b_unsigned, diff_unsigned : unsigned(N-1 downto 0);  -- Sinais temporários do tipo unsigned
begin
	-- Convertendo as entradas de std_logic_vector para unsigned para realizar a subtração
	a_unsigned <= unsigned(a);
	b_unsigned <= unsigned(b);

	-- Realiza a subtração e ajusta para o valor positivo (módulo)
	diff_unsigned <= (a_unsigned - b_unsigned) when (a_unsigned >= b_unsigned) else (b_unsigned - a_unsigned);

	-- Converte o resultado de unsigned para std_logic_vector e atribui à saída
	s <= std_logic_vector(diff_unsigned);

end architecture;
