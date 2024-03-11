library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cont_BCD_5dig is
    generic (
        N : natural := 4  								
        ); 
    port ( 
		rst_i: in std_logic; 
		clk_i : in std_logic; 
		ena_i : in std_logic;
		bcd0_o: inout std_logic_vector(N-1 downto 0);
		bcd1_o: inout std_logic_vector(N-1 downto 0);
		bcd2_o: inout std_logic_vector(N-1 downto 0); 
		bcd3_o: inout std_logic_vector(N-1 downto 0); 
		bcd4_o: inout std_logic_vector(N-1 downto 0) 
	);
end entity;

architecture cont_BCD_5dig_arq of cont_BCD_5dig is

signal ena_aux: std_logic_vector(4 downto 0); 


begin

    ena_aux(0) <= ena_i;
    ena_aux(1) <= ena_aux(0) and (bcd0_o(3)) and (not bcd0_o(2)) and (not bcd0_o(1)) and (bcd0_o(0)); 
    ena_aux(2) <= ena_aux(1) and (bcd1_o(3)) and (not bcd1_o(2)) and (not bcd1_o(1)) and (bcd1_o(0));
    ena_aux(3) <= ena_aux(2) and (bcd2_o(3)) and (not bcd2_o(2)) and (not bcd2_o(1)) and (bcd2_o(0));
    ena_aux(4) <= ena_aux(3) and (bcd3_o(3)) and (not bcd3_o(2)) and (not bcd3_o(1)) and (bcd3_o(0)); 
    
    bcd0_cont: entity work.cont_BCD port map(rst_i, clk_i, ena_aux(0), bcd0_o);        
    bcd1_cont: entity work.cont_BCD port map(rst_i, clk_i, ena_aux(1), bcd1_o);
    bcd2_cont: entity work.cont_BCD port map(rst_i, clk_i, ena_aux(2), bcd2_o);
    bcd3_cont: entity work.cont_BCD port map(rst_i, clk_i, ena_aux(3), bcd3_o);
    bcd4_cont: entity work.cont_BCD port map(rst_i, clk_i, ena_aux(4), bcd4_o);

end;
