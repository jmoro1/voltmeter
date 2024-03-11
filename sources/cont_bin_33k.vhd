library IEEE;
use IEEE.std_logic_1164.all;

entity cont_bin_33k is
    generic ( N : natural := 16);    
        port(
            rst_i : in std_logic;
            clk_i : in std_logic;
            ena_i : in std_logic;
            Q_BCD : out std_logic;    -- reset al contador de BCD
            Q_reg: out std_logic      -- enable al Registro
        );
end entity;

architecture cont_bin_33k_arq of cont_bin_33k is

component cont_bin_nb
 	generic (N: natural := 16);
    port(
		rst_i: in std_logic;
		clk_i: in std_logic;
		ena_i: in std_logic;
		q_o: out std_logic_vector(N-1 downto 0)
	);
end component;

component comp_nb
 	generic (N: natural := 16);
    port(
		a: in std_logic_vector(N-1 downto 0); 	-- Primer numero a comparar
		b: in std_logic_vector(N-1 downto 0); 	-- Segundo numero a comparar
		s: out std_logic 						-- Si ambos numeros son iguales, obtengo un uno
	);
end component;

signal q_aux_cont: std_logic_vector (N-1 downto 0);
signal Q_BCD_aux, Q_reg_aux: std_logic;
signal rst_aux: std_logic;


begin
    contador: cont_bin_nb
        port map (
            rst_i => rst_aux,
            clk_i => clk_i,
            ena_i => ena_i,
            q_o => q_aux_cont 
        );
    
    comparador0: comp_nb port map(a=>q_aux_cont, b=> "1000000011100111",s=>Q_reg_aux);
    comparador1: comp_nb port map(a=>q_aux_cont, b=> "1000000011101000",s=>Q_BCD_aux);
    

    Q_BCD <= Q_BCD_aux;
    Q_reg <= Q_reg_aux;

    rst_aux <= Q_BCD_aux or rst_i ; -- se retea (rst =1) si alguno de los dos es 1
end;
