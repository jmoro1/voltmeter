library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cont_bin_nb is
	generic(
		N: natural := 10
	);
	port(
		rst_i: in std_logic;
		clk_i: in std_logic;
		ena_i: in std_logic;
		q_o: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture cont_bin_nb_arq of cont_bin_nb is

signal and_aux, xor_aux, q_aux: std_logic_vector(N-1 downto 0); 

begin

-- and_aux(0) sólo depende del q_o
	and_aux(0) <= '1';
	xor_aux(0) <= and_aux(0) xor q_aux(0);
	
	ffd_0: entity work.ffd 
	port map(
		clk_i => clk_i,
		rst_i => rst_i,
		ena_i => ena_i,
		D_i => xor_aux(0),
		Q_o => q_aux(0)
		
	);

	gene: for i in 1 to N-1 generate 
		and_aux(i) <= and_aux(i-1) and q_aux(i-1);
		xor_aux(i) <= and_aux(i) xor q_aux(i);
		ffd_i: entity work.ffd 
			port map(
				clk_i => clk_i,
				rst_i => rst_i,
				ena_i => ena_i,
				D_i => xor_aux(i),
				Q_o => q_aux(i)
			);
	end generate;

-- la salida está determinada a partir del vector q_aux generado a partir de todos los ffd. 
q_o <= q_aux;

end;
