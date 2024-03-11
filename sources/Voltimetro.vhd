library IEEE;
use IEEE.std_logic_1164.all;

entity Voltimetro is
	port(
		--Entradas
		clk_i			: in std_logic;		-- Clock
		rst_i			: in std_logic;		-- Reset
		data_volt_in_i  : in std_logic;		-- Ingreso de 1´s provenientes del ffd de entrada. Habilita el contador BCD

		--Salidas
		red_o			: out std_logic;	-- Salida Color rojo del VGA
		grn_o			: out std_logic;	-- Salida Color verde del VGA
		blu_o			: out std_logic;	-- Salida Color azul del VGA
		hs_o			: out std_logic;	-- Sicronismo horizontal para VGA
		vs_o			: out std_logic;	-- Sincronismo vertical para VGA
		data_volt_out_o	: out std_logic		-- Realimentacion
		);
end;

architecture Voltimetro_arq of Voltimetro is

   	type signal_vect_Type is array (4 downto 0) of std_logic_vector(3 downto 0); --Es un array de 5 vectores de 4 bits

	signal s_adc_bcd5: std_logic;                   	-- Señal entre ADC y contBCD_5dig
	signal s_cont33_reg: std_logic;                 	-- Señal entre cont33k y Registro
	signal s_cont33_bcd5: std_logic;                	-- Señal entre cont33k y contBCD_5
	signal s_bcd5_reg: signal_vect_Type;	        	-- Señal entre contBCD_5 y Registro
	signal s_reg_mux: signal_vect_Type;  	       		-- Señal entre Reg y Mux
	signal s_mux_rom: std_logic_vector(3 downto 0);  	-- Señal entre Mux y ROM
	signal s_vga_xmux: std_logic_vector(9 downto 0);  	-- Señal entre VGA y MUX (pixel x)
	signal s_vga_ymux: std_logic_vector(9 downto 0);  	-- Señal entre VGA y MUX (pixel y)
	signal s_rom_vga: std_logic;                     	-- Señal entre ROM y VGA
	signal ena_i: std_logic := '1';						-- Señal entra al Enable en 1
														

begin
	-- ADC
	adc: entity work.ADC					--Instanciación del componente ADC
		port map(
			clk_i   => clk_i,				-- Clock
			rst_i   => rst_i,				-- Reset
			ena_i   => ena_i,				-- Enable
			D_vi    => data_volt_in_i,				-- Entrada de señal
			Q_fb	=> data_volt_out_o,				-- Realimentación
			Q_proc	=> s_adc_bcd5			-- Bloque de procesamiento
		);

	-- CONTADOR DE 5 BCDs
	contbcd5: entity work.cont_BCD_5dig			--Instanciación del componente contBCD_5
		port map(
			clk_i => clk_i, 				-- Clock
			rst_i => s_cont33_bcd5, 		-- Reset controlado por contador binario
			ena_i => s_adc_bcd5, 			-- Entrada del bloque de procesamiento y control
			bcd0_o => s_bcd5_reg(0), 		-- Salida (entrada de registro)
			bcd1_o => s_bcd5_reg(1), 		-- Salida (entrada de registro)
			bcd2_o => s_bcd5_reg(2), 		-- Salida (entrada de registro)
			bcd3_o => s_bcd5_reg(3), 		-- Salida (entrada de registro)
			bcd4_o => s_bcd5_reg(4) 		-- Salida (entrada de registro)
		);

	-- CONTADOR BINARIO
	contbin: entity work.cont_bin_33k			--Instanciación del componente cont33k
		generic map(
			N => 16 						-- Bits del contador
		)
		port map(
			clk_i => clk_i,					-- Clock
			rst_i => rst_i, 				-- Reset
			ena_i => ena_i, 				-- Enable
			Q_BCD => s_cont33_bcd5, 		-- Reset de contBCD_5
			Q_reg => s_cont33_reg 			-- Enable de Registro
		);

	-- REGISTRO
	reg: for x in 0 to 4 generate
		regNx: entity work.reg_Nb			--Instanciación del componente reg_nb
			generic map(
				N => 4 						-- Bits de de c/entrada del registro
			)
			port map(
				clk_i => clk_i, 			-- Clock
				rst_i => rst_i, 			-- Reset
				ena_i => s_cont33_reg, 		-- Enable controlado por contador binario
				D_reg => s_bcd5_reg(x), 	-- Entradas del registro
				Q_reg => s_reg_mux(x) 		-- Salida hacia Mux
			);
	end generate reg;

	-- MULTIPLEXOR
	mux: entity work.mux					--Instanciación del componente mux
		port map(
			BCD0  => s_reg_mux(2), 			-- Valor más significativo
			point => "1010",				-- Punto
			BCD1  => s_reg_mux(3),			-- Primer Decimal
			BCD2  => s_reg_mux(4),			-- Segundo Decimal
			volt  => "1011", 				-- V
			sel   => s_vga_xmux(9 downto 7),-- Pixel x de VGA
			F_o   => s_mux_rom 				-- Salida hacia ROM
		);

	-- ROM
	ROM: entity work.ROM					--Instanciación del componente ROM
		port map(
			fHor    => s_vga_xmux(6 downto 4), 	-- Posicion X controlada por VGA
			fVer    => s_vga_ymux(6 downto 4), 	-- Posicion Y controlada por VGA
			Addr    => s_mux_rom, 				-- Datos entrantes de MUX
			sROM_o  => s_rom_vga 				-- Salida hacia VGA
		);

	-- VGA
	vga: entity work.VGA		--Instanciación del componente VGA
		port map(
			clk_i   => clk_i,		-- Clock
			rst_i   => rst_i,		-- Reset
			red_i   => s_rom_vga,	-- Entrada rojo
			grn_i   => s_rom_vga,	-- Entrada verde
			blu_i   => '1',			-- Entrada azul
			hsync   => hs_o,		-- Sincronismo horizontal
			vsync   => vs_o,		-- Sincronismo vertical
			red_o   => red_o,		-- Salida rojo
			grn_o   => grn_o,		-- Salida verde
			blu_o   => blu_o,		-- Salida azul
			pixel_x => s_vga_xmux,	-- Pixel x
			pixel_y => s_vga_ymux	-- Pixel y
		);
end;
