----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2018 08:53:33 PM
-- Design Name: 
-- Module Name: psc - Behavioral

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity psc is
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        sample: in std_logic_vector(8 downto 0);
        
        s_out : out STD_LOGIC;
        s_sync : out STD_LOGIC);
end psc;

architecture Behavioral of psc is
    --type bus_state is (idle, setup, rdywait, read);
    --signal cstate, nstate: bus_state;

    --signal sample: std_logic_vector(8 downto 0);
    
    signal serial_buffer: std_logic_vector(8 downto 0);
    signal serial_cnt: unsigned(3 downto 0);
    signal clk_div_en: std_logic;
    signal clk_div_cnt: integer range 0 to 1000;
begin
 


    sync_clk_div: process(clk_in, rst_n)
    -- Creates an enable signal to sync the shift register
    -- with the sample rate for the transmission. The same process
    -- is implemented in the serial-parallel-converter on the receiving
    -- side.
    begin
        if rst_n = '0' then
            clk_div_en <= '0';
            clk_div_cnt <= 0;
            
        elsif rising_edge(clk_in) then
            if clk_div_cnt >= 399 then
                clk_div_en <= '1';
                clk_div_cnt <= 0;
            else
                clk_div_en <= '0';
                clk_div_cnt <= clk_div_cnt + 1;
            end if;
        end if;
    end process;

    shift_reg: process(clk_in, rst_n)
    -- Shift register for sending serialization
    begin
        if rst_n = '0' then
            serial_buffer <= (others => '0');
            serial_cnt <= (others => '0');

            s_out <= '0';
            s_sync <= '0';
            
        elsif rising_edge(clk_in) then
            if clk_div_en = '1' then
          
                if serial_cnt = 9 then
                    
                    serial_cnt <= (others => '0');
                    
                    -- load buffer
                    serial_buffer <= sample; --9x"100"; --<= sample;
                    s_out <= '1';
                    s_sync <= '1';

                else
                
                    s_out <= serial_buffer(8);
                    serial_buffer <= std_logic_vector(shift_left(unsigned(serial_buffer), 1));
                
                    serial_cnt <= serial_cnt + 1;
                    s_sync <= '0';
                end if;
                
--                if serial_cnt = 0 then
--                    s_sync <= '1';
--                else
--                    s_sync <= '0';
--                end if;
            end if;
        end if;
    end process;

   
end Behavioral;
