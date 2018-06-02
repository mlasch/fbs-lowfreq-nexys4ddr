----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2018 20:42:28
-- Design Name: 
-- Module Name: main - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
    generic(
    Divider_2MHz: Integer:=24;
    Counter_2MHz_size: Integer := 8;
    Divider_250KHz: Integer:=399;
    Counter_250KHz_size : Integer := 16;
    
    Word_size : Integer := 15;
    ST: std_logic_vector := "0100110101010011";
    S0: std_logic_vector := "0100110100110011";
    S1: std_logic_vector := "0100110100110101";
    FF: std_logic_vector := "0000000000000000"                                       -- Ausgabe bei Fehler
);
   
    Port(
    CLK_100MHz: in std_logic;
    Data_in: in std_logic_vector(1 downto 0);
    Data_out: out std_logic:='0'
    );
    
end main; 

architecture Behavioral of main is
signal Word_ST: std_logic_vector(0 to Word_size):= ST;
signal Word_S0: std_logic_vector(0 to Word_size):= S0;
signal Word_S1: std_logic_vector(0 to Word_size):= S1;
signal Word_other: std_logic_vector(0 to Word_size):= FF;
signal Data_shift:  std_logic_vector(0 to Word_size):= ST; 

signal Clk4MHz : std_logic_vector(2 downto 0);

signal Count_2MHz: std_logic_vector((Counter_2MHz_size-1) downto 0):=conv_std_logic_vector(Divider_2MHz-9,Counter_2MHz_size);
signal Count_250KHz: std_logic_vector((Counter_250KHz_size-1) downto 0):=conv_std_logic_vector(Divider_250KHz-5,Counter_250KHz_size);

signal Startup_flag: std_logic:='0';
signal CLK_2MHz: std_logic:='0';

signal CLK_250MHz_enable : std_logic:='0';

begin

    Startup: Process(CLK_100MHz)
        begin
            if rising_edge(CLK_100MHz) then
              if Startup_flag = '0' and Data_in = "11" then
                  Startup_flag <= '1';
              end if; 
              Clk4MHz  <= Clk4MHz(1 downto 0) & CLK_2MHz;        
            end if;
        end process Startup;
    
    Takt_2MHz: Process(CLK_100MHz)
        begin
            if rising_edge(CLK_100MHz) then
                if Startup_flag = '1' then
                if Count_2MHz < conv_std_logic_vector(Divider_2MHz,Counter_2MHz_size) then
                    Count_2MHz <= Count_2MHz + 1;
                else 
                    Count_2MHz <= (others => '0');
                    CLK_2MHz <= not CLK_2MHz;
                end if;
                 end if;
            end if;
        end process Takt_2MHz; 
   
    Takt_250KHz: Process(CLK_100MHz)                                           
        begin
            if rising_edge(CLK_100MHz) then
                if Startup_flag = '1' then
                    if Count_250KHz < conv_std_logic_vector(Divider_250KHz,Counter_250KHz_size) then
                        Count_250KHz <= Count_250KHz + 1;
                        CLK_250MHz_enable <= '0';                                                
                    else 
                        Count_250KHz <= (others => '0');
                        CLK_250MHz_enable <= '1';  
                    end if;
                end if; 
            end if;
        end process Takt_250KHz;
    
    Takt_ausgabe: Process(CLK_100MHz)
         begin
             if rising_edge(CLK_100MHz) then
                 if Startup_flag = '1' then
                     if CLK_250MHz_enable = '1' then
                         if Data_in(1 downto 0)  = "11" then 
                             Data_shift <= Word_ST;
                         elsif Data_in(1 downto 0)  = "01" then
                               Data_shift <= Word_S1;
                         elsif Data_in(1 downto 0)  = "00" then
                               Data_shift <= Word_S0;
                         else
                               Data_shift <= Word_other;
                         end if;
                     end if;
                
                if (Clk4MHz(2 downto 1) = "10") then 
                     Data_out <= Data_shift(0);
                     Data_shift <= Data_shift(1 to 15) & '0';
                elsif (Clk4MHz(2 downto 1) = "01") then 
                     Data_out <= Data_shift(0);
                     Data_shift <= Data_shift(1 to 15) & '0';          
                 end if;
             end if;
        end if;
    end process Takt_ausgabe;
    
end Behavioral;
