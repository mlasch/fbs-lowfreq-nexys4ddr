----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2018 11:44:47 AM
-- Design Name: 
-- Module Name: pwm - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
    generic(n: integer := 8);
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        sample_in: in std_logic_vector(n downto 0);
        pwm_out: out std_logic
        
    );
end pwm;

architecture Behavioral of pwm is
    signal pwm_counter: unsigned(10 downto 0);
    signal sample_buf: std_logic_vector(n downto 0);
    
begin
    process(clk_in, rst_n)
    begin
        if rst_n = '0' then
            pwm_out <= '0';
            pwm_counter <= (others => '0');
            sample_buf <= (others => '0');
            
        elsif rising_edge(clk_in) then
            if pwm_counter = 2047 then
                pwm_counter <= (others => '0');
                sample_buf <= sample_in;
            else
                pwm_counter <= pwm_counter + 1;
            end if;
            
            if pwm_counter(n+2 downto 2) < unsigned(sample_buf) then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;

end Behavioral;
