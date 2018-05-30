----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2018 05:05:28 PM
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity fir_lowpass is
    generic(fir_order: integer := 43);
    port (
        clk_in: in std_logic;
        rst_n: in std_logic;
        h: in std_logic_vector(15 downto 0);
        x: in std_logic_vector(8 downto 0);
        p: out std_logic_vector(15 downto 0)
    );
end fir_lowpass;

architecture rtl of fir_lowpass is

    component xbip_dsp48_A is
    PORT (
        CLK : IN STD_LOGIC;
        A : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        ACOUT : OUT STD_LOGIC_VECTOR(29 DOWNTO 0);
        PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
        P : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
    );
    end component;
    
    component xbip_dsp48_B is
    PORT (
        CLK : IN STD_LOGIC;
        PCIN : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
        ACIN : IN STD_LOGIC_VECTOR(29 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
    );
    END component;
    
    signal p1: std_logic_vector(47 downto 0);
    
    signal pc: std_logic_vector(47 downto 0);
    signal ac: std_logic_vector(29 downto 0);
    
    type coeff_t is array(0 to fir_order) of signed(8 downto 0);
    type sample_t is array(0 to fir_order-1) of signed(8 downto 0);
    type result_stage1_t is array(0 to fir_order/2) of std_logic_vector(17 downto 0);
    
    signal coeff: coeff_t;
    signal sample: sample_t;
    signal result_stage1: result_stage1_t;
    
begin
    
    coeff(0) <= 9x"0";
    
    
    dsp_bank: for i in 0 to 22 generate
    
        --gerade
        xbip_dsp48_A_inst: xbip_dsp48_A
        port map (
            CLK => clk_in,
            A => std_logic_vector(sample(2*i)),    --input register
            B => std_logic_vector(coeff(2*i)),
            ACOUT => ac,
            PCOUT => pc,
            P => open
        );
        
        --ungerade
        xbip_dsp48_B_inst: xbip_dsp48_B
        port map (
            CLK => clk_in,
            PCIN => pc,
            ACIN => ac,
            B => std_logic_vector(coeff(2*i+1)),
            P => result_stage1(2*i+1)
        );
    
    end generate;

end rtl;
