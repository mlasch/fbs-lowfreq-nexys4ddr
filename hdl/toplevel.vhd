----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2018 10:27:57 AM
-- Design Name: 
-- Module Name: toplevel - Behavioral
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

entity toplevel is
    port(
        CLK100MHZ: in std_logic;
        SW: in std_logic_vector(15 downto 0);
        vauxn3, vauxp3, vauxn10, vauxp10, vauxn2, vauxp2, vauxn11, vauxp11: in std_logic;
        
        aud_pwm: out std_logic;
        aud_sd: out std_logic;
        
        LED: out std_logic_vector(15 downto 0)
    );

end toplevel;

architecture Behavioral of toplevel is
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
    
    component pwm is
        port (
            clk_in: in std_logic;
            rst_n: in std_logic;
            sample_in: in std_logic_vector(8 downto 0);
            pwm_out: out std_logic
            
        );
    end component;
    
    signal rst_n: std_logic;
    
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
    
    signal sample_read, sample_write: std_logic_vector(8 downto 0);
    signal sample_rdy: std_logic;
    
    signal golden_sig: std_logic;
    signal golden_sync: std_logic;
    
    signal enable: std_logic;
    
    begin
    
    rst_n <= SW(0);
    led(8 downto 0) <= sample_write; --<= sample_read;
    
    aud_sd <= '1';
    led(15) <= '1';
    
    psc0: psc
    port map (
        clk_in => CLK100MHZ,
        rst_n => SW(0),
        sample => do(15 downto 7), --sample_read,
        s_out => golden_sig,
        s_sync => golden_sync
    );
    
    spc0: spc
    port map (
        clk_in => CLK100MHZ,
        rst_n => SW(0),
        s_in => golden_sig,
        s_sync => golden_sync,
        sample_out => sample_write,
        sample_rdy => sample_rdy
    );
    
    pwm0: pwm
    port map(
        clk_in => CLK100MHZ,
        rst_n => SW(0),
        sample_in => sample_write,
        pwm_out => aud_pwm
    );
    
    adc_interface0: adc_interface
    port map (
        clk_in => CLK100MHZ,
        rst_n => SW(0),
        eoc => eoc,
        den => den,
        drdy => drdy,
        daddr => daddr,
        dwe => dwe,
        dout => do,
        din => di,
        sample_out => sample_read
    );
    
    
    
    adc: xadc_wiz_0
    port map (
        daddr_in => daddr,       --: in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
        den_in => den,         --: in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
        di_in => di,          --: in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
        dwe_in => dwe,         --: in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
        do_out => do,         --: out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
        drdy_out => drdy,       --: out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
        dclk_in => CLK100MHZ,        --: in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
        reset_in => not SW(0),       --: in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
        vauxp3 => vauxp3,         --: in  STD_LOGIC;                         -- Auxiliary Channel 3
        vauxn3 => vauxn3,         --: in  STD_LOGIC;
        busy_out => busy,        --: out  STD_LOGIC;                        -- ADC Busy signal
        channel_out => ch_mux,    --: out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
        eoc_out => eoc,        --: out  STD_LOGIC;                        -- End of Conversion Signal
        eos_out => eos,        --: out  STD_LOGIC;                        -- End of Sequence Signal
        alarm_out => open,      --: out STD_LOGIC;                         -- OR'ed output of all the Alarms
        vp_in => '0',         --: in  STD_LOGIC;                         -- Dedicated Analog Input Pair
        vn_in => '0'         --: in  STD_LOGIC
    );

end Behavioral;
