LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY instr_voltimetro_testbench IS
END instr_voltimetro_testbench;
 
ARCHITECTURE behavior OF instr_voltimetro_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Voltimetro
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         data_volt_in_i : IN  std_logic;
         red_o : OUT  std_logic;
         grn_o : OUT  std_logic;
         blu_o : OUT  std_logic;
         hs_o : OUT  std_logic;
         vs_o : OUT  std_logic;
         data_volt_out_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal data_volt_in_i : std_logic := '0';

 	--Outputs
   signal red_o : std_logic;
   signal grn_o : std_logic;
   signal blu_o : std_logic;
   signal hs_o : std_logic;
   signal vs_o : std_logic;
   signal data_volt_out_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Voltimetro PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          data_volt_in_i => data_volt_in_i,
          red_o => red_o,
          grn_o => grn_o,
          blu_o => blu_o,
          hs_o => hs_o,
          vs_o => vs_o,
          data_volt_out_o => data_volt_out_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		rst_i <= '1'; --xx
      
		wait for 20 ns;	
		
		rst_i <= '0'; --xx
      
		wait for 20 ns;	
		
		rst_i <= '1'; --xx
      
		wait for 20 ns;	
		
		rst_i <= '0'; --xx

      wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

	data_volt_in_i <= data_volt_out_o; --xx

END;
