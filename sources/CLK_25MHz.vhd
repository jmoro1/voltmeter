library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLK_25MHz is
    port(
          rst_i : in std_logic;
          clk_i : in std_logic; -- Entrada de clock de 100MHz
          ena_i : in std_logic;
          Q_25MHZ : out std_logic -- Salida de clock a 25MHz 
          );
          
end CLK_25MHz;

architecture CLK_25MHz_arq of CLK_25MHz is

signal aux_25: std_logic_vector (1 downto 0);

begin
contador: entity work.cont_bin_nb -- instancio el contador de 2 bits que hara la division de clock
generic map(N => 2)
        port map (
            rst_i => rst_i,
            clk_i => clk_i,
            ena_i => ena_i,
            q_o => aux_25
        );
        
 Q_25MHZ<=aux_25(1); -- mando a la salida solo el segundo componente del vector

end CLK_25MHz_arq;
