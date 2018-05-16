----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2018 11:31:22 AM
-- Design Name: 
-- Module Name: spc_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spc_tb is
--  Port ( );
end spc_tb;

architecture tb of spc_tb is
    component spc is
    port ( 
        clk_in:in std_logic;
        rst_n: in std_logic;
        
        s_in: in std_logic;
        s_sync: in std_logic;
        
        sample_out: out std_logic_vector(8 downto 0)
    );
    
    end component;
    
    signal dclk: std_logic := '0';
    signal rst_n: std_logic;
    signal s_in: std_logic;
    signal s_sync: std_logic;
    signal sample_out: std_logic_vector(8 downto 0);
    
    constant DELAY: time := 5 us;
    constant SAMPLE_TIME: time := 400*10 ns;    -- 4us -> 250 kHz
begin

    dclk <= not dclk after 5 ns;
    rst_n <= '0', '1' after 13 ns;
    
    s_sync <= '0', '1' after DELAY + SAMPLE_TIME, '0' after DELAY + 2*SAMPLE_TIME ;
    s_in <= '0', '1' after DELAY + SAMPLE_TIME, '0' after DELAY + 3 * SAMPLE_TIME, '1' after DELAY + 4 * SAMPLE_TIME;

    spc0: spc
    port map(
        clk_in => dclk,
        rst_n => rst_n,
        s_in => s_in,
        s_sync => s_sync,
        sample_out => sample_out
    );

end;
