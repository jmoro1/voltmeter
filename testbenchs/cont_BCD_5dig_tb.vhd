library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity cont_BCD_5dig_tb IS
end cont_BCD_5dig_tb;
 
architecture behavior of cont_BCD_5dig_tb is 
 
    component cont_BCD_5dig
    port(
         rst_i : in  std_logic;
         clk_i : in  std_logic;
         ena_i : in  std_logic;
         bcd0_o : inout  std_logic_vector(3 downto 0);
         bcd1_o : inout  std_logic_vector(3 downto 0);
         bcd2_o : inout  std_logic_vector(3 downto 0);
         bcd3_o : inout  std_logic_vector(3 downto 0);
         bcd4_o : inout  std_logic_vector(3 downto 0)
        );
    end component;
    

   signal rst_tb : std_logic := '1';
   signal clk_tb : std_logic := '0';
   signal ena_tb : std_logic := '0';
   signal bcd0_o : std_logic_vector(3 downto 0);
   signal bcd1_o : std_logic_vector(3 downto 0);
   signal bcd2_o : std_logic_vector(3 downto 0);
   signal bcd3_o : std_logic_vector(3 downto 0);
   signal bcd4_o : std_logic_vector(3 downto 0);
 
begin
        rst_tb <= '0' after 200 ns;
        ena_tb <= '1' after 300 ns;
        clk_tb <= not clk_tb after 50 ns;
 
   DUT: cont_BCD_5dig port map(
          rst_i => rst_tb,
          clk_i => clk_tb,
          ena_i => ena_tb,
          bcd0_o => bcd0_o,
          bcd1_o => bcd1_o,
          bcd2_o => bcd2_o,
          bcd3_o => bcd3_o,
          bcd4_o => bcd4_o
        );

end;