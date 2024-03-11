library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_vert is
    generic(
		N: natural := 10
	);
  port(
    clk_i: in std_logic; -- Clock
    rst_i: in std_logic; -- Reset
    ena_i: in std_logic; -- Enable
    max: out std_logic; -- Cuenta máxima (524)
    count: out std_logic_vector(N-1 downto 0) -- Cuenta (0 a 524)
  );

end contador_vert;

architecture contador_vert_arq of contador_vert is

signal aux_cont: std_logic_vector (N-1 downto 0);
signal aux_max: std_logic; 
signal rst_aux: std_logic;

begin

  contador_H: entity work.cont_bin_nb generic map(N=>10)port map (
            rst_i => rst_aux,
            clk_i => clk_i,
            ena_i => ena_i,
            q_o => aux_cont 
        );

comparador0: entity work.comp_nb port map(a=>aux_cont, b=> "1000001100",s=>aux_max); --cuenta a 524

rst_aux <= aux_max or rst_i; -- Resetea si alguno es '1'
count <= aux_cont;  -- Cuenta
max <= aux_max; -- Indico maxima cuenta

end;
