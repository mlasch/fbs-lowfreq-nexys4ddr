----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2018 20:42:28
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modulator is
    generic(
    Teiler_2MHz: Integer:=24;
    Teiler_250KHz: Integer:=399
);
    Port(
    CLK_100MHz: in std_logic;
    Data_in: in std_logic_vector(1 downto 0);
    Data_out: out std_logic
    --startup_flag_out: out std_logic;
    --debug: out std_logic_vector(15 downto 0)
--    CLK_4_MHZ: out std_logic;
--    CLK_250KHz: out std_logic;
--    data_shift_1: out std_logic_vector ( 15 downto 0)
    );
end modulator; 



architecture Behavioral of modulator is
signal Bitmuster_ST: std_logic_vector(15 downto 0):= "1100101010110010";
signal Bitmuster_S0: std_logic_vector(15 downto 0):="1100110010110010";
signal Bitmuster_S1: std_logic_vector(15 downto 0):="1010110010110010";
signal Bitmuster_other: std_logic_vector(15 downto 0):="0000000000000000";

signal Takt_4MHz_zaehler: std_logic_vector(7 downto 0);
signal Takt_250KHz_zaehler: std_logic_vector(15 downto 0);
signal Takt_4MHz_sig: std_logic:='0';
signal Takt_250KHz_sig: std_logic:='0';

signal out_ready: std_logic;

signal data_shift:  std_logic_vector(15 downto 0);

begin
    
    Data_out <= data_shift(0);
    
    
    takt_ausgabe: process(all)
    begin
        if rising_edge(CLK_100MHZ) then
            if Takt_4MHz_sig = '1' then
                
                data_shift <= '0' & data_shift( 15 downto 1);
                
                if Takt_250KHz_sig = '1' then
                    
                    if Data_in(1 downto 0)  = "11" then 
                        data_shift <= Bitmuster_ST;
            
                    elsif Data_in(1 downto 0)  = "01" then
            
                        data_shift <= Bitmuster_S1;
                    elsif Data_in(1 downto 0)  = "00" then
            
                        data_shift <= Bitmuster_S0;
                    else
                        data_shift <= Bitmuster_other;
                    end if;
                end if;
            end if;
        end if;

    end process takt_ausgabe;
    
    Takt_4MHz: Process(CLK_100MHz)
    begin
        if rising_edge(CLK_100MHz) then
            if Takt_4MHz_zaehler < conv_std_logic_vector(Teiler_2MHz,8) then
                Takt_4MHz_zaehler <= Takt_4MHz_zaehler + 1;
                Takt_4MHz_sig <= '0';
            else 
                Takt_4MHz_zaehler <= (others => '0');
                Takt_4MHz_sig <= '1';
            end if;
        end if;
    end process Takt_4MHz;    
    
    Takt_250KHz: Process(CLK_100MHz)
    begin
        if rising_edge(CLK_100MHz) then
            if Takt_250KHz_zaehler < conv_std_logic_vector(Teiler_250KHz,16) then
                Takt_250KHz_zaehler <= Takt_250KHz_zaehler + 1;
                Takt_250KHz_sig <= '0';
            else 
                Takt_250KHz_zaehler <= (others => '0');
                Takt_250KHz_sig <= '1';
            end if;
        end if;
    end process Takt_250KHz; 
end Behavioral;
