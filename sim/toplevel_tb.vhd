----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2018 05:35:55 PM
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity toplevel_tb is

end toplevel_tb;

architecture tb of toplevel_tb is
    component toplevel is
    port(
        CLK100MHZ: in std_logic;
        vauxn3, vauxp3, vauxn10, vauxp10, vauxn2, vauxp2, vauxn11, vauxp11: in std_logic;
        aud_pwm: out std_logic;
        aud_sd: out std_logic;
        SW: in std_logic_vector(15 downto 0);
        LED: out std_logic_vector(15 downto 0);
        
        CA, CB, CC, CD, CE, CF, CG, DP: out std_logic;
        AN: out std_logic_vector(7 downto 0);
        sync_in, data_in: in std_logic;
        sync_out, data_out: out std_logic
    );
    end component;
    
    signal clk100mhz: std_logic := '0';
    signal rst_n: std_logic;
    signal sw: std_logic_vector(15 downto 0) := x"0000";
    signal led: std_logic_vector(15 downto 0);
    
    signal golden_sync, golden_data: std_logic := '0';
    
begin

    clk100mhz <= not clk100mhz after 5 ns;
    rst_n <= '0', '1' after 1 us;
    
    sw(15) <= rst_n;
    sw(0) <= '0', '1' after 1000 us;

    toplevel_test: toplevel
    port map(
        CLK100MHZ => clk100mhz,
        vauxn2 => '0',
        vauxp2 => '0',
        vauxn3 => '0',
        vauxp3 => '0',
        vauxn10 => '0',
        vauxp10 => '0',
        vauxn11 => '0',
        vauxp11 => '0',
        aud_pwm => open,
        aud_sd => open,
        SW => sw,
        LED => led,
        sync_in => golden_sync,
        data_in => golden_data,
        sync_out => golden_sync,
        data_out => golden_data
    );

end tb;
