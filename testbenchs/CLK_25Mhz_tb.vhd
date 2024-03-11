library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CLK_25MHz_tb is
end CLK_25MHz_tb;

architecture CLK_25MHz_tb_arq of CLK_25MHz_tb is
    
        signal clk_tb: std_logic := '0';
        signal ena_tb: std_logic := '0';
        signal rst_tb: std_logic := '1';
        signal Q_25MHZ_tb:std_logic;
                
        begin
        rst_tb <= '0' after 200 ns;
        ena_tb <= '1' after 300 ns;
        clk_tb <= not clk_tb after 50 ns;
            
        -- Contador General
        DUT0: entity work.CLK_25MHz port map (clk_i=>clk_tb,ena_i => ena_tb,rst_i => rst_tb,Q_25MHZ => Q_25MHZ_tb );

        
    end CLK_25MHz_tb_arq;
