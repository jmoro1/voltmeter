library IEEE;
use IEEE.std_logic_1164.all;

entity reg_nb is
  generic(
    N: natural := 4 -- Defino 4 bits porque es BCD
  );
  port(
    clk_i: in std_logic; 
    rst_i: in std_logic; 
    ena_i: in std_logic; 
    D_reg: in std_logic_vector(N-1 downto 0); 
    Q_reg: out std_logic_vector(N-1 downto 0) 
  );
end;

architecture reg_nb_arq of reg_nb is

begin
  ffd_gen: for x in 0 to N-1 generate -- Genero registros de 4 bits
    ffd_x: entity work.ffd port map(clk_i =>clk_i, rst_i =>rst_i,ena_i =>ena_i,D_i=>D_reg(x),Q_o=>Q_reg(x));
  end generate ffd_gen;
end;
