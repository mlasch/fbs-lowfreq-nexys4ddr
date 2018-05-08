----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2018 08:41:41 PM
-- Design Name: 
-- Module Name: adc_interface - Behavioral
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

entity adc_interface is
    port ( 
    clk_in: in std_logic;
    rst_n: in std_logic;
    eoc: in std_logic;
    den: out std_logic;
    drdy: in std_logic;
    daddr: out std_logic_vector(6 downto 0);
    dwe: out std_logic;
    dout: in std_logic_vector(15 downto 0);
    din: out std_logic_vector(15 downto 0);
    
    sample_out: out std_logic_vector(8 downto 0)
    );
    
end adc_interface;

architecture rtl of adc_interface is
    type bus_state is (idle, setup, rdywait, read);
    signal cstate, nstate: bus_state;
    
    signal sample_buffer: std_logic_vector(8 downto 0);
    
begin
    
    sample_out <= sample_buffer;

    state_machine: process (clk_in, rst_n)
    begin
        if rst_n = '0' then
            cstate <= idle;
            
        elsif rising_edge(clk_in) then
            cstate <= nstate;
        end if;
    end process;
    
    next_state: process(cstate, eoc, drdy)
    begin
        case cstate is
            when idle =>
                if eoc = '1' then
                    nstate <= setup;
                end if;
            when setup =>
                nstate <= rdywait;
            when rdywait =>
                if drdy = '1' then
                    nstate <= read;
                end if;
            when read =>
                nstate <= idle;
        end case;
    end process;
    
    outputs: process(clk_in, rst_n)
    begin
        if rst_n = '0' then
           sample_buffer <= (others => '0');
           daddr <= (others => '0');
           dwe <= '0';
           den <= '0';
           
        elsif rising_edge(clk_in) then
            case cstate is
                when idle =>
                    den <= '0';
                when setup =>
                    daddr <= 7x"12";
                    dwe <= '0';
                    den <= '1';
                when rdywait =>
                    den <= '0';
                when read =>
                    sample_buffer <= dout(15 downto 7);  -- read 12-bit sample from bus
                when others =>
                    null;
           end case;
        end if;
    end process;

end;
