----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2018 10:27:57 AM
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity top_send is
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
        LED: out std_logic_vector(15 downto 0);
        data_out: out std_logic
    );

end top_send;

architecture rtl of top_send is

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
   
    signal dummy_reset: std_logic := '1';     -- dummy signal for reset
    signal s_data: std_logic;
    signal s_sync: std_logic;
    
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
        s_out => s_data,
        s_sync => s_sync
    );
    
    modulator_inst: modulator
    port map (
        CLK_100MHZ => CLK100MHZ,
        data_in => s_sync & s_data,
        data_out => data_out
    );

end rtl;
