----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2018 09:49:46 PM
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity spc is
    port ( 
        clk_in: in std_logic;
        rst_n: in std_logic;
        s_in: in std_logic;
        s_sync: in std_logic;
        sample_out: out std_logic_vector(8 downto 0)
    );
end spc;

architecture rtl of spc is
    -- shift register signals
    signal serial_buffer: std_logic_vector(8 downto 0);
    signal out_buffer: std_logic_vector(8 downto 0);
    signal serial_cnt: unsigned(3 downto 0) := (others => '0');
    
    type state_t is (sync, shiftin, outbuf);
    signal nstate: state_t := sync;
    
    -- signals for clock divider
    signal clk_div_en: std_logic;
    signal clk_div_cnt: integer range 0 to 1000;
    
begin
    
    sample_out <= out_buffer;

    sync_clk_div: process(clk_in, rst_n)
    -- Creates an enable signal to sync the shift register
    -- with the sample rate of the transmission. The same process
    -- is implemented in the parallel-serial-converter on the sending
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
    
    shift_in: process(clk_in, rst_n)
    begin
        if rst_n = '0' then
            nstate <= sync;
            serial_cnt <= (others => '0');
            serial_buffer <= (others => '0');
            out_buffer <= (others => '0');
            
            
        elsif rising_edge(clk_in) then
            case nstate is
                when sync =>
                    if s_sync = '1' then
                        nstate <= shiftin;
                    end if;
                    
                    serial_buffer <= (others => '0');
    
                when shiftin =>
                    if s_sync = '0' then
                        if clk_div_en = '1' then
                            serial_buffer(0) <= s_in;
                            
                            for i in 0 to 7 loop
                                serial_buffer(i+1) <= serial_buffer(i);
                            end loop;
                            
                            if serial_cnt > 7 then
                                serial_cnt <= (others => '0');
                                nstate <= outbuf;
                            else
                                serial_cnt <= serial_cnt + 1;
                            end if;
        
                        end if;
                        
                    --else
                        --nstate <= sync;
                        
                    end if;
                
                when outbuf =>
                    out_buffer <= serial_buffer;
                    
                    nstate <= sync;
                when others =>
                    null;
                    
            end case;
        end if;
    end process;

end;
