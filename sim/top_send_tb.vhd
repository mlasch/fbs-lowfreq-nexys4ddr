----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2018 10:27:57 AM
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity top_send_tb is

end top_send_tb;

architecture rtl of top_send_tb is

    component signal_source is
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        vaux_p, vaux_n: in std_logic;
        s_out: out std_logic;
        s_sync: out std_logic
    );
    end component;
    
    component modulator is
    generic(
        Teiler_2MHz: Integer:=24;
        Teiler_250KHz: Integer:=199
    );
    port(
        CLK_100MHz: in std_logic;
        data_in: in std_logic_vector(1 downto 0);
        data_out: out std_logic
    );
    end component; 
   
    signal clk100mhz: std_logic := '0';
    signal rst_n: std_logic;
    signal s_data: std_logic;
    signal s_sync: std_logic;
    signal data_out: std_logic;
    
    begin
    
    clk100mhz <= not clk100mhz after 5 ns;
    rst_n <= '0', '1' after 30 ns;
        
    source_0: signal_source
    port map(
        clk_in => clk100mhz,
        rst_n => rst_n,
        vaux_p => '0',
        vaux_n => '0',
        s_out => s_data,
        s_sync => s_sync
    );
    
    modulator_inst: modulator
    port map (
        CLK_100MHZ => clk100mhz,
        data_in => s_sync & s_data,
        data_out => data_out
    );

end rtl;
