----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2018 04:51:57 PM
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity signal_sink is
port (
    clk_in: in std_logic;
    rst_n: in std_logic;
    s_in: in std_logic;
    s_sync: in std_logic;
    
    pwm_out: out std_logic
);
end signal_sink;

architecture rtl of signal_sink is
    component spc is
    port ( 
        clk_in: in std_logic;
        rst_n: in std_logic;
        s_in: in std_logic;
        s_sync: in std_logic;
        sample_out: out std_logic_vector(8 downto 0);
        sample_rdy: out std_logic
    );
    end component;
    
    component pwm is
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        sample_in: in std_logic_vector(8 downto 0);
        pwm_out: out std_logic
        
    );
    end component;
    
    signal sample: std_logic_vector(8 downto 0);
    
    
begin
    spc_inst: spc
    port map (
        clk_in => clk_in,
        rst_n => rst_n,
        s_in => s_in,
        s_sync => s_sync,
        sample_out => sample
    );

    pwm_inst: pwm
    port map(
        clk_in => clk_in,
        rst_n => rst_n,
        sample_in => sample,
        pwm_out => pwm_out
    );

end rtl;
