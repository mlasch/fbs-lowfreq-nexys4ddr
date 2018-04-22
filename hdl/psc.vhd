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
        eoc: in std_logic;
        den: out std_logic;
        drdy: in std_logic;
        daddr: out std_logic_vector(6 downto 0);
        dwe: out std_logic;
        dout: in std_logic_vector(15 downto 0);
        din: out std_logic_vector(15 downto 0);
        
        
        s_out : out STD_LOGIC;
        s_sync : out STD_LOGIC);
end psc;

architecture Behavioral of psc is
    type bus_state is (idle, setup, rdywait, read);
    signal cstate, nstate: bus_state;

    signal sample: std_logic_vector(8 downto 0);
    
    signal serial_buffer: std_logic_vector(8 downto 0);
    signal serial_cnt: unsigned(3 downto 0);
    signal clk_div_en: std_logic;
    signal clk_div_cnt: integer range 0 to 1000;
begin
 
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
           sample <= (others => '0');
           daddr <= (others => '0');
           dwe <= '0';
           den <= '0';
           
        elsif rising_edge(clk_in) then
            case cstate is
                when idle =>
                    den <= '0';
                when setup =>
                    daddr <= 7x"10";
                    dwe <= '0';
                    den <= '1';
                when rdywait =>
                    den <= '0';
                when read =>
                    sample <= dout(15 downto 7);  -- read 12-bit sample from bus
                when others =>
                    null;
           end case;
        end if;
    end process;
    
    -- bla
    sync_clk_div: process(clk_in, rst_n)
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
                    serial_buffer <= 9x"100"; --<= sample;
                    s_out <= '0';

                else
                
                    s_out <= serial_buffer(8);
                    serial_buffer <= std_logic_vector(shift_left(unsigned(serial_buffer), 1));
                
                    serial_cnt <= serial_cnt + 1;
                    s_sync <= '0';
                end if;
                
                if serial_cnt = 0 then
                    s_sync <= '1';
                else
                    s_sync <= '0';
                end if;
            end if;
        end if;
    end process;

   
end Behavioral;
