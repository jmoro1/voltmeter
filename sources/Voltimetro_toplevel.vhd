library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Voltimetro_toplevel is
	port(
		clk_i			: in std_logic;		-- Clock
		rst_i			: in std_logic;		-- Reset
		data_volt_in_i	: in std_logic;		-- Señal de entrada
		data_volt_out_o	: out std_logic;	-- Señal de realimentación
		hs_o 			: out std_logic;	-- Sincronismo horizontal
		vs_o 			: out std_logic;	-- Sincronismo vertical
		red_o 			: out std_logic;	-- Rojo
		grn_o 			: out std_logic;	-- Verde
		blu_o 			: out std_logic	-- Azul
		
	);

	
end Voltimetro_toplevel;

architecture Voltimetro_toplevel_arq of Voltimetro_toplevel is

	-- Declaracion del componente voltimetro
	component Voltimetro is
		port(
			clk_i: in std_logic;				-- Clock
			rst_i: in std_logic;				-- Reset
			data_volt_in_i: in std_logic;		-- Señal de entrada
			data_volt_out_o: out std_logic;		-- Señal de realimentación
			hs_o : out std_logic;				-- Sincronismo horizontal
			vs_o : out std_logic;				-- Sincronismo vertical
			red_o : out std_logic;				-- Rojo
			grn_o : out std_logic;				-- Verde
			blu_o : out std_logic				-- Azul
		);
	end component Voltimetro;


	component CLK_25MHz                        -- Declaro el conversor de frecuencia de clock
		  port(
          rst_i : in std_logic;                 -- Reset
          clk_i : in std_logic;                 -- Señal de entrada (100Mhz)
          ena_i : in std_logic;                 -- Enable
          Q_25MHZ : out std_logic               -- Señal de salida (25MHz)
          );
        end component;

  
	signal clk25MHz: std_logic;
	

begin
	
	clk25MHz_gen : CLK_25MHz                   -- Instancio el conversor de frecuencia de clock
   		port map (
   			rst_i=> rst_i,
   			clk_i=>clk_i,	    -- Clock del sistema (100 MHz)
   			ena_i=> '1',
   			Q_25MHZ	=> clk25MHz	-- Clock generado (25 MHz)
 		);

	-- Instancia del bloque voltimetro
	inst_voltimetro: Voltimetro
		port map(
            clk_i			=> clk25MHz,		-- Clock generado
            rst_i			=> rst_i,			-- Reset
            data_volt_in_i	=> data_volt_in_i,	-- Señal de entrada
            data_volt_out_o	=> data_volt_out_o,	-- Señal de realimentación
            hs_o			=> hs_o,			-- Sincronismo horizontal
            vs_o			=> vs_o,			-- Sincronismo vertical
            red_o			=> red_o,			-- Rojo
            grn_o			=> grn_o,			-- Verde
            blu_o			=> blu_o			-- Azul
        );

	
		
end Voltimetro_toplevel_arq;