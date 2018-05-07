----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2018 10:36:07 PM
-- Design Name: 
-- Module Name: adc_tb - Behavioral
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

entity adc_tb is
--  Port ( );
end adc_tb;

architecture tb of adc_tb is
    component xadc_wiz_0 is
       port
       (
        daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
        den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
        di_in           : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
        dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
        do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
        drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
        dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
        reset_in        : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
        vauxp0          : in  STD_LOGIC;                         -- Auxiliary Channel 5
        vauxn0          : in  STD_LOGIC;
        busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
        channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
        eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
        eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
        alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
        vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
        vn_in           : in  STD_LOGIC
    );
    end component;
    
    component psc is
        port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        sample: in std_logic_vector(8 downto 0);     
        s_out : out STD_LOGIC;
        s_sync : out STD_LOGIC
    );
    end component;
    
    component adc_interface is
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
    end component;
    
    component spc is
    port ( 
            clk_in: in std_logic;
            rst_n: in std_logic;
            s_in: in std_logic;
            s_sync: in std_logic;
            sample_out: out std_logic_vector(8 downto 0);
            sample_rdy: out std_logic
    );
    end component;
    
     
    signal daddr: std_logic_vector(6 downto 0);
    signal den: std_logic := '0';
    signal di: std_logic_vector(15 downto 0);
    signal dwe: std_logic := '1';
    signal do: std_logic_vector(15 downto 0);
    signal drdy: std_logic;
    signal dclk: std_logic := '0';
    signal rst_n: std_logic;
    signal busy: std_logic;
    signal ch_mux: std_logic_vector(4 downto 0);
    signal eoc: std_logic;
    signal eos: std_logic;
    
    signal sample_read, sample_write: std_logic_vector(8 downto 0);
    signal sample_rdy: std_logic;
    
    signal golden_sig: std_logic;
    signal golden_sync: std_logic;
    
begin
    

    dclk <= not dclk after 5 ns;
    rst_n <= '0', '1' after 30 ns;
    
    psc0: psc
    port map (
        clk_in => dclk,
        rst_n => rst_n,
        sample => sample_read,
        s_out => golden_sig,
        s_sync => golden_sync
    );
   
    adc_interface0: adc_interface
    port map (
        clk_in => dclk,
        rst_n => rst_n,
        eoc => eoc,
        den => den,
        drdy => drdy,
        daddr => daddr,
        dwe => dwe,
        dout => do,
        din => di,
        sample_out => sample_read
    );
    
    spc0: spc
    port map (
        clk_in => dclk,
        rst_n => rst_n,
        s_in => golden_sig,
        s_sync => golden_sync,
        sample_out => sample_write,
        sample_rdy => sample_rdy
    );
    
    adc: xadc_wiz_0
    port map (
        daddr_in => daddr,       --: in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
        den_in => den,         --: in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
        di_in => di,          --: in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
        dwe_in => dwe,         --: in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
        do_out => do,         --: out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
        drdy_out => drdy,       --: out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
        dclk_in => dclk,        --: in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
        reset_in => not rst_n,       --: in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
        vauxp0 => '0',         --: in  STD_LOGIC;                         -- Auxiliary Channel 5
        vauxn0 => '0',         --: in  STD_LOGIC;
        busy_out => busy,        --: out  STD_LOGIC;                        -- ADC Busy signal
        channel_out => ch_mux,    --: out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
        eoc_out => eoc,        --: out  STD_LOGIC;                        -- End of Conversion Signal
        eos_out => eos,        --: out  STD_LOGIC;                        -- End of Sequence Signal
        alarm_out => open,      --: out STD_LOGIC;                         -- OR'ed output of all the Alarms
        vp_in => '0',         --: in  STD_LOGIC;                         -- Dedicated Analog Input Pair
        vn_in => '0'         --: in  STD_LOGIC
    );
end;

