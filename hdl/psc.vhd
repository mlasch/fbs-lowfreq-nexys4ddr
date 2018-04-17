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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

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
        daddr: out std_logic_vector(6 downto 0);
        dwe: out std_logic;
        dout: in std_logic_vector(15 downto 0);
        din: out std_logic_vector(15 downto 0);
        
        
        s_out : out STD_LOGIC;
        s_sync : out STD_LOGIC);
end psc;

architecture Behavioral of psc is
    type bus_state is (idle, setup, read);
    signal cstate, nstate: bus_state;

    signal sample: std_logic_vector(9 downto 0);
    --signal trigger: std_logic;
begin

    
--    trigger0: process (clk_in, rst_n)
--    begin
--        if rst_n = '0' then
--            trigger <= '0';
            
--        elsif rising_edge(clk_in) then
--            if cstate = idle then 
--                if eoc = '1' then
--                trigger <= '1';
--        end if;
--    end process;

    
    state_machine: process (clk_in, rst_n)
    begin
        if rst_n = '0' then
            cstate <= idle;
            
        elsif rising_edge(clk_in) then
            cstate <= nstate;
        end if;
    end process;

    next_state: process(cstate, eoc)
    begin
        case cstate is
            when idle =>
                if eoc = '1' then
                    nstate <= setup;
                end if;
            when setup =>
                nstate <= read;
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
           
        elsif rising_edge(clk_in) then
            case cstate is
                when idle =>
                    den <= '0';
                when setup =>
                    daddr <= 7x"10";
                    dwe <= '0';
                    den <= '1';
                when read =>
                    sample <= dout(15 downto 6);  -- read 12-bit sample from bus
                    
                when others =>
                    null;
           end case;
        end if;
    end process;
   
end Behavioral;
