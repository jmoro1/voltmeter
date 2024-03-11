library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_nb_tb is
end reg_nb_tb;

architecture Behavioral of reg_nb_tb is

component reg_nb is
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
end component;

   signal rst_tb : std_logic := '1';
   signal clk_tb : std_logic := '0';
   signal ena_tb : std_logic := '0';
   signal dato_tb: std_logic_vector(3 downto 0):="0010";
   signal q_reg_tb: std_logic_vector(3 downto 0);

begin

        rst_tb <= '0' after 200 ns;
        ena_tb <= '1' after 300 ns;
        clk_tb <= not clk_tb after 50 ns;

DUT: reg_nb port map(
    clk_i=>clk_tb,
    rst_i=>rst_tb, 
    ena_i=>ena_tb,
    D_reg=>dato_tb, 
    Q_reg=>q_reg_tb
    );
end;
