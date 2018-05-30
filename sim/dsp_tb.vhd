----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2018 11:40:40 PM
-- Design Name: 
-- Module Name: dsp_tb - Behavioral
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

entity dsp_tb is
--  Port ( );
end dsp_tb;

architecture Behavioral of dsp_tb is
    component fir_lowpass is
        port (
            clk_in: in std_logic;
            rst_n: in std_logic;
            h: in std_logic_vector(3 downto 0);
            x: in std_logic_vector(3 downto 0);
            p: out std_logic_vector(15 downto 0)
        );
    end component;
    
    signal clk_in: std_logic := '0';
    signal rst_n: std_logic;
    signal p: std_logic_vector(15 downto 0);
    signal h: std_logic_vector(3 downto 0);
    signal x: std_logic_vector(3 downto 0);
    
begin
    clk_in <= not clk_in after 5 ns;
    rst_n <= '0', '1' after 10 ns;
    
    x <= x"0", x"2" after 60 ns, x"f" after 120 ns, x"3" after 180 ns;
    h <= x"2", x"0" after 60 ns, x"f" after 120 ns, x"9" after 180 ns;
    fir_lowpass0: fir_lowpass
    port map(
        clk_in => clk_in,
        rst_n => rst_n,
        h => h,
        x => x,
        p => p
    );
    

end Behavioral;
