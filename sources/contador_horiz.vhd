library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_horiz is
    generic(
		N: natural := 10
	);
  port(
    clk_i: in std_logic; -- Clock
    rst_i: in std_logic; -- Reset
    ena_i: in std_logic; -- Enable
    max: out std_logic; -- Cuenta máxima (799)
    count: out std_logic_vector(N-1 downto 0) -- Cuenta (0 a 799)
  );

end contador_horiz;

architecture contador_horiz_arq of contador_horiz is

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

comparador0: entity work.comp_nb port map(a=>aux_cont, b=> "1100011111",s=>aux_max); --cuenta a 799

rst_aux <= aux_max or rst_i; -- Resetea si alguno es '1'
count <= aux_cont;  -- Cuenta
max <= aux_max; -- Indico maxima cuenta

end;
