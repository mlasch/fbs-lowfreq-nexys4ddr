----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2018 12:42:44 PM
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
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

entity pwm_tb is
--  Port ( );
end pwm_tb;

architecture Behavioral of pwm_tb is
component pwm is
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        
        sample_in: in std_logic_vector(8 downto 0);
        
        pwm_out: out std_logic
        
    );
end component;
    signal clk100mhz: std_logic := '0';
    signal rst_n: std_logic;
    signal sample: std_logic_vector(8 downto 0);
    signal pwm_out: std_logic;
    
begin
    clk100mhz <= not clk100mhz after 5 ns;
    rst_n <= '0', '1' after 30 ns;
    sample <= 9x"c8"; -- c8 -> 200
    pwm0: pwm
    port map(
        clk_in => clk100mhz,
        rst_n => rst_n,
        sample_in => sample,
        pwm_out => pwm_out
    );

end Behavioral;
