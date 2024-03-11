LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
entity cont_BCD_tb is
end cont_BCD_tb;
 
architecture behavior of cont_BCD_tb is 
 
   signal rst_tb : std_logic := '1';
   signal clk_tb : std_logic := '0';
   signal ena_tb : std_logic := '0';
   signal q_o_tb : std_logic_vector(3 downto 0);

 
begin
        rst_tb <= '0' after 200 ns;
        ena_tb <= '1' after 300 ns;
        clk_tb <= not clk_tb after 50 ns;

   DUT: entity work.cont_BCD port map(rst => rst_tb, clk => clk_tb, ena => ena_tb, q_o => q_o_tb);

end;