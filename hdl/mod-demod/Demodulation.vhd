----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2018 13:54:50
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Demod is
    Port ( CLK : in STD_LOGIC;
           Data_in : in STD_LOGIC;
           Data_out_clk : out STD_LOGIC := '0';
           Data_out : out STD_LOGIC := '0';
           SYNC_out : out STD_LOGIC:='0');
end Demod;

architecture Behavioral of Demod is
SIGNAL counter : STD_LOGIC_VECTOR(4 downto 0) := "01100";        --12
SIGNAL clk_abtast : STD_LOGIC := '0';
SIGNAL Data_in_buf,Data_buf,SYNC_buf : STD_LOGIC:='0';
SIGNAL compare_buf : STD_LOGIC_VECTOR (15 downto 0):= "0000000000000000";
SIGNAL Data_out_clk_buf : STD_LOGIC := '0';
begin

Process(CLK,Data_in)
begin   
    if CLK'event AND CLK = '1' then
        counter <= std_logic_vector(unsigned(counter) - 1);     -- Zähler verringern
        clk_abtast <= '0';
        if counter = "00000" then                                -- wenn Zähler 0 dann Abtasten und zurück setzten
            clk_abtast <= '1';
            counter <= "11000";                                  -- auf Zählwert 24 zurück setzten
        end if;
        
        if Data_in = not Data_in_buf then
            counter <= "01100";                                      --Zählwert auf 12
        end if;
    end if;
    
    Data_in_buf <= Data_in;
    
end Process;

Process(clk, clk_abtast)
BEGIN
    if rising_edge(clk) then
    
        if clk_abtast = '1' then
            --Data_buf <= Data_in;
            compare_buf(15 downto 0) <= compare_buf(14 downto 0) & Data_in;    --Daten nach links schieben und neue 
            if compare_buf = "0100110100110011" then
                Data_buf <= '0';
                Sync_buf <= '0';
                compare_buf <= "0000000000000000";
                Data_out_clk_buf <= not Data_out_clk_buf;
            elsif compare_buf = "0100110100110101" then
                Data_buf <= '1';
                Sync_buf <= '0';
                compare_buf <= "0000000000000000";
                Data_out_clk_buf <= not Data_out_clk_buf;
            elsif compare_buf = "0100110101010011" then
                Data_buf <= '1';
                Sync_buf <= '1';
                compare_buf <= "0000000000000000";
                Data_out_clk_buf <= not Data_out_clk_buf;
            end if;
        end if;
    end if;
END PROCESS;
Data_out_clk <= Data_out_clk_buf;
Data_out <= Data_buf;
Sync_out <= Sync_buf;

end Behavioral;
