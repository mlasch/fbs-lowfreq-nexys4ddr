----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2018 04:09:18 PM
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity source_sim_tb is

end source_sim_tb;

architecture Behv of source_sim_tb is

    -- Xilinx IP for ADC 
    component xadc_wiz_0 is
    port (
        daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
        den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
        di_in           : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
        dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
        do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
        drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
        dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
        reset_in        : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
        vauxp3          : in  STD_LOGIC;                         -- Auxiliary Channel 5
        vauxn3          : in  STD_LOGIC;
        busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
        channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
        eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
        eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
        alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
        vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
        vn_in           : in  STD_LOGIC
    );
    end component;
    
    -- Interface to access the ADC registers
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
    
    -- Convert the ADC sample to a serial bitstream
    component psc is
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        sample: in std_logic_vector(8 downto 0);     
        s_out : out std_logic;
        s_sync : out std_logic
    );
    end component;
    
    signal daddr: std_logic_vector(6 downto 0);
    signal den: std_logic := '0';
    signal di: std_logic_vector(15 downto 0);
    signal dwe: std_logic := '1';
    signal do: std_logic_vector(15 downto 0);
    signal drdy: std_logic;
    signal busy: std_logic;
    signal ch_mux: std_logic_vector(4 downto 0);
    signal eoc: std_logic;
    signal eos: std_logic;
    
    signal sample_read: std_logic_vector(8 downto 0);
    
    signal clk_in: std_logic := '0';
    signal rst_n: std_logic;
    
    signal s_out: std_logic;
    signal s_sync: std_logic;
    
begin

    clk_in <= not clk_in after 5 ns;
    rst_n <= '0', '1' after 1 us;


    adc_inst: xadc_wiz_0
    port map (
        daddr_in => daddr,       --: in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
        den_in => den,         --: in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
        di_in => di,          --: in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
        dwe_in => dwe,         --: in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
        do_out => do,         --: out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
        drdy_out => drdy,       --: out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
        dclk_in => clk_in,        --: in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
        reset_in => not rst_n,       --: in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
        vauxp3 => '0',         --: in  STD_LOGIC;                         -- Auxiliary Channel 3
        vauxn3 => '0',         --: in  STD_LOGIC;
        busy_out => busy,        --: out  STD_LOGIC;                        -- ADC Busy signal
        channel_out => ch_mux,    --: out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
        eoc_out => eoc,        --: out  STD_LOGIC;                        -- End of Conversion Signal
        eos_out => eos,        --: out  STD_LOGIC;                        -- End of Sequence Signal
        alarm_out => open,      --: out STD_LOGIC;                         -- OR'ed output of all the Alarms
        vp_in => '0',         --: in  STD_LOGIC;                         -- Dedicated Analog Input Pair
        vn_in => '0'         --: in  STD_LOGIC
    );
    
    adc_interface_inst: adc_interface
    port map (
        clk_in => clk_in,
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
    
    psc_inst: psc
    port map (
        clk_in => clk_in,
        rst_n => rst_n,
        sample => do(15 downto 7), --sample_read, --do(15 downto 7),
        s_out => s_out,
        s_sync => s_sync
    );

end Behv;
