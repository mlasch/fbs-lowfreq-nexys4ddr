----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2018 10:27:57 AM
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity toplevel is
    port(
        -- clock
        CLK100MHZ: in std_logic;
        -- analog in
        vauxn3, vauxp3, vauxn10, vauxp10, vauxn2, vauxp2, vauxn11, vauxp11: in std_logic;
        -- audio out
        aud_pwm: out std_logic;
        aud_sd: out std_logic;
        -- in/out
        SW: in std_logic_vector(15 downto 0);
        LED: out std_logic_vector(15 downto 0)
    );

end toplevel;

architecture rtl of toplevel is

    component signal_source is
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        vaux_p, vaux_n: in std_logic;
        s_out: out std_logic;
        s_sync: out std_logic
    );
    end component;

    component signal_sink is
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        s_in: in std_logic;
        s_sync: in std_logic;
        pwm_out: out std_logic
    );
    end component;
   
    signal dummy_reset: std_logic := '1';     -- dummy signal for reset
    
    signal sample_read, sample_write: std_logic_vector(8 downto 0);
    signal sample_rdy: std_logic;
    
    signal golden_data: std_logic;
    signal golden_sync: std_logic;
    
    signal enable: std_logic;
    
    begin
    --led(8 downto 0) <= do(15 downto 7); --<= sample_read;
    
    aud_sd <= '1';      -- enable audio output
    led(15) <= '1';     -- alive indicator
    

    
    source_0: signal_source
    port map(
        clk_in => CLK100MHZ,
        rst_n => dummy_reset,
        vaux_p => vauxp3,
        vaux_n => vauxn3,
        s_out => golden_data,
        s_sync => golden_sync
    );
    
    sink_0: signal_sink
    port map(
        clk_in => CLK100MHZ,
        rst_n => dummy_reset,
        s_in => golden_data,
        s_sync => golden_sync,
        pwm_out => aud_pwm
    );

end rtl;
