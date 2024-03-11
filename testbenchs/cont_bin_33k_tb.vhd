    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    
    entity cont_bin_33k_tb is
    end cont_bin_33k_tb;
    
    architecture cont_bin_33k_tb_arq of cont_bin_33k_tb is
    
        signal clk_tb: std_logic := '0';
        signal ena_tb: std_logic := '0';
        signal rst_tb: std_logic := '1';
        signal Q_BCD_tb: std_logic;
        signal Q_reg_tb: std_logic;
        
        begin
        rst_tb <= '0' after 200 ns;
        ena_tb <= '1' after 300 ns;
        clk_tb <= not clk_tb after 50 ns;
            
        -- Contador General
        DUT0: entity work.cont_bin_33k generic map(N => 16) port map (clk_i=>clk_tb,ena_i => ena_tb,rst_i => rst_tb,Q_BCD => Q_BCD_tb,Q_reg=>Q_reg_tb );

        
    end cont_bin_33k_tb_arq;
----------------------------------------------------------------------------------

