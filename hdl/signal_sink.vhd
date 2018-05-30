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
    sw: in std_logic_vector(2 downto 0);
    
    pwm_out: out std_logic;
    debug_out: out std_logic_vector(15 downto 0)
);
end signal_sink;

architecture rtl of signal_sink is
    component spc is
    port ( 
        clk_in: in std_logic;
        rst_n: in std_logic;
        s_in: in std_logic;
        s_sync: in std_logic;
        sample_out: out std_logic_vector(8 downto 0)
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
    
    signal sample_in, sample_out: std_logic_vector(8 downto 0);
    
begin
    spc_inst: spc
    port map (
        clk_in => clk_in,
        rst_n => rst_n,
        s_in => s_in,
        s_sync => s_sync,
        sample_out => sample_in
    );

    pwm_inst: pwm
    port map(
        clk_in => clk_in,
        rst_n => rst_n,
        sample_in => sample_out,
        pwm_out => pwm_out
    );
    
    volume: process(all)
    begin
        case sw is
            when 3x"0" => sample_out <= sample_in(8 downto 0);
            when 3x"1" => sample_out <= b"0" & sample_in(8 downto 1);
            when 3x"2" => sample_out <= b"00" & sample_in(8 downto 2);
            when 3x"3" => sample_out <= b"000" & sample_in(8 downto 3);
            when 3x"4" => sample_out <= b"0000" & sample_in(8 downto 4);
            when others => sample_out <= 9x"190";
            
        end case; 
    end process;
    
    debug_out(8 downto 0) <= sample_out;

end rtl;
