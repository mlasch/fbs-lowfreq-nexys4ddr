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
        
        CA, CB, CC, CD, CE, CF, CG, DP: out std_logic;
        AN: out std_logic_vector(7 downto 0);
        
        sync_in, data_in: in std_logic;
        sync_out, data_out: out std_logic
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
    
    component main is
        generic(
        Divider_2MHz: Integer:=24;
        Counter_2MHz_size: Integer := 8;
        Divider_250KHz: Integer:=399;
        Counter_250KHz_size : Integer := 16;
        
        Word_size : Integer := 15;
        ST: std_logic_vector := "0100110101010011";
        S0: std_logic_vector := "0100110100110011";
        S1: std_logic_vector := "0100110100110101";
        FF: std_logic_vector := "0000000000000000"                                       -- Ausgabe bei Fehler
    );
       
        Port(
        CLK_100MHz: in std_logic;
        Data_in: in std_logic_vector(1 downto 0);
        Data_out: out std_logic:='0'
        );
        
    end component; 

    component Demod is
        Port ( CLK : in STD_LOGIC;
               Data_in : in STD_LOGIC;
               Data_out_clk : out STD_LOGIC;
               Data_out : out STD_LOGIC;
               SYNC_out : out STD_LOGIC);
    end component;

    component signal_sink is
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        s_in: in std_logic;
        s_sync: in std_logic;
        sw: in std_logic_vector(2 downto 0);
        pwm_out: out std_logic;
        debug_out: out std_logic_vector(15 downto 0)
    );
    end component;
   
    --signal dummy_reset: std_logic := '1';     -- dummy signal for reset
    signal send_data, send_sync: std_logic;
    signal recv_data, recv_sync: std_logic;
    
    signal pout: std_logic_vector(15 downto 0);
    signal debug_out: std_logic_vector(15 downto 0);

    
    begin

    aud_sd <= '1';      -- enable audio output
   
    led <= debug_out;
   
    source_0: signal_source
    port map(
        clk_in => CLK100MHZ,
        rst_n => SW(15), --dummy_reset,
        vaux_p => vauxp3,
        vaux_n => vauxn3,
        s_out => send_data,
        s_sync => send_sync
    );
    
    modulator: main
    port map(
        CLK_100MHz => CLK100MHZ,
        Data_in => send_sync & send_data,
        data_out => data_out
    );
    
    demodulator: Demod
    port map(
        CLK => CLK100MHZ,
        Data_in => data_in,
        Data_out_clk => open,
        Data_out => recv_data,
        SYNC_out => recv_sync
    );
        
    sink_0: signal_sink
    port map(
        clk_in => CLK100MHZ,
        rst_n => SW(15), --dummy_reset,
        s_in => recv_data,
        s_sync => recv_sync,
        sw => SW(2 downto 0),
        pwm_out => aud_pwm,
        debug_out => debug_out
    );
    
    -- force the 7-segment lines to GND
    CA <= '0';
    CB <= '0';
    CC <= '0';
    CD <= '0';
    CE <= '0';
    CF <= '0';
    CG <= '0';
    DP <= '0';
    AN <= 8x"ff";
     
end rtl;
