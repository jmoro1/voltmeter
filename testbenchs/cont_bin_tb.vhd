    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    
    entity cont_bin_nb_tb is
    end cont_bin_nb_tb;
    
    architecture cont_bin_nb_tb_arq of cont_bin_nb_tb is
    
    component cont_bin_nb is
        generic(
		N: natural := 10
	        );
	        port(
            rst_i: in std_logic;
            clk_i: in std_logic;
            ena_i: in std_logic;
            q_o: out std_logic_vector(N-1 downto 0)
            );
        end component;
        
        signal clk_tb: std_logic := '0';
        signal ena_tb: std_logic := '0';
        signal rst_tb: std_logic := '1';
        signal q_o_tb: std_logic_vector (9 downto 0);

               
        begin
        rst_tb <= '0' after 200 ns;
        ena_tb <= '1' after 300 ns;
        clk_tb <= not clk_tb after 50 ns;
            
        -- Contador General
        DUT0: entity work.cont_bin_nb port map (clk_i=>clk_tb,ena_i => ena_tb,rst_i => rst_tb,q_o => q_o_tb);

        
    end cont_bin_nb_tb_arq;
