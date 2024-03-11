library IEEE;
use IEEE.std_logic_1164.all;

entity cont_BCD is 
    port (
        rst, clk, ena : in std_logic;
        q_o : out std_logic_vector(3 downto 0) 
    );
end;

architecture cont_BCD_arq of cont_BCD is

signal 	q_neg_aux: std_logic_vector(3 downto 0);
signal 	q_aux, d_aux: std_logic_vector(3 downto 0);

begin
    
    -- Da = QbQcQd + QaQdneg
    d_aux(3) <= (q_aux(2) and q_aux(1) and q_aux(0)) 
                or (q_aux(3) and (not q_aux(0))) ;

    -- Db = QbnegQcQd+QbQcneg+QbQdneg
    d_aux(2) <= ((not q_aux(2)) and q_aux(1) and q_aux(0)) 
                or (q_aux(2) and (not q_aux(1)))
                or (q_aux(2) and (not q_aux(0)));

    -- Dc = QanegQcnegQd+QcQdneg
    d_aux(1) <= ((not q_aux(3)) and (not q_aux(1)) and q_aux(0)) 
                or (q_aux(1) and (not q_aux(0)));
    
    -- Dd = Qdneg
    d_aux(0) <= not q_aux(0);
    
   -- Instancio los FFD
   
    ffd_0 : entity work.ffd port map (clk, rst, ena, d_aux(3), q_aux(3)); 

    ffd_1 : entity work.ffd port map (clk, rst, ena, d_aux(2), q_aux(2)); 
    
    ffd_2 : entity work.ffd port map (clk, rst, ena, d_aux(1), q_aux(1));

    ffd_3 : entity work.ffd port map (clk, rst, ena, d_aux(0), q_aux(0));
		  
    q_o <= q_aux; 

end;
