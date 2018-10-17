----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2018 07:18:57 PM
-- Design Name: 
-- Module Name: FGDATopLevel - Behavioral
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

entity FGDATopLevel is
  Port ( 
   CLK100MHz :   IN STD_LOGIC;
   PUSHBTN : IN STD_LOGIC;
   PS2_CLK : IN STD_LOGIC;
   PS2_DATA: IN STD_LOGIC;
   VGA_HS: OUT STD_LOGIC;
   VGA_VS: OUT STD_LOGIC;
   VGA_RED: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
   VGA_GRN: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
   VGA_BLU: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
   LED: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
  
end FGDATopLevel;

architecture Behavioral of FGDATopLevel is
component MMCM is
  Port ( 
      CLK_OUT_25 : out STD_LOGIC;
      CLK_OUT_100 : out STD_LOGIC;
      reset : in STD_LOGIC;
      locked : out STD_LOGIC;
      CLK_IN_100 : in STD_LOGIC
    );
end component;
component ps2_keyboard is 
GENERIC(
  clk_freq              : INTEGER ; --system clock frequency in Hz
  debounce_counter_size : INTEGER );         --set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
PORT(
  clk          : IN  STD_LOGIC;                     --system clock
  ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
  ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
  ps2_code_new : OUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
  ps2_code     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) );
  end component;
 component vga_controller IS
      GENERIC(
          h_pulse     :    INTEGER;        --horiztonal sync pulse width in pixels
          h_bp         :    INTEGER;        --horiztonal back porch width in pixels
          h_pixels    :    INTEGER;        --horiztonal display width in pixels
          h_fp         :    INTEGER;        --horiztonal front porch width in pixels
          h_pol        :    STD_LOGIC;        --horizontal sync pulse polarity (1 = positive, 0 = negative)
          v_pulse     :    INTEGER;            --vertical sync pulse width in rows
          v_bp         :    INTEGER;            --vertical back porch width in rows
          v_pixels    :    INTEGER;        --vertical display width in rows
          v_fp         :    INTEGER;            --vertical front porch width in rows
          v_pol        :    STD_LOGIC);    --vertical sync pulse polarity (1 = positive, 0 = negative)
          
      PORT(
          pixel_clk    :    IN        STD_LOGIC;    --pixel clock at frequency of VGA mode being used
          reset_n        :    IN        STD_LOGIC;    --active low asycnchronous reset
          keyInput    :   IN STD_LOGIC_VECTOR(7 DOWNTO 0);
          VGA_HS        :    OUT    STD_LOGIC;    --horiztonal sync pulse
          VGA_VS        :    OUT    STD_LOGIC;    --vertical sync pulse
          --disp_ena    :    OUT    STD_LOGIC;    --display enable ('1' = display time, '0' = blanking time)
          --column        :    OUT    INTEGER;        --horizontal pixel coordinate
          --row            :    OUT    INTEGER);        --vertical pixel coordinate
          --n_blank        :    OUT    STD_LOGIC;    --direct blacking output to DAC
          --n_sync        :    OUT    STD_LOGIC); --sync-on-green output to DAC
          VGA_RED      :   OUT STD_LOGIC_VECTOR(3 downto 0);
          VGA_GRN       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          VGA_BLU       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
  END component;
  
component x3 is
      port(
      x1: in STD_LOGIC_VECTOR(7 downto 0);
      x2: out STD_LOGIC_VECTOR(7 downto 0)
      );
      end component;


  

SIGNAL LockedOut : STD_LOGIC;
SIGNAL CLKOut25 : STD_LOGIC;
SIGNAL CLKOut100 : STD_LOGIC;
SIGNAL VSColorBarOut: STD_LOGIC;
SIGNAL HSColorBarOut: STD_LOGIC;
SIGNAL KeyData: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL TEMPRED: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN 


MMCM1: MMCM PORT MAP(CLKOut25, CLKOut100,'0',LockedOut,CLK100MHZ);
PS2_KEYBOARD1: ps2_keyboard GENERIC MAP(clk_freq => 50_000_000, 
                                     debounce_counter_size => 8) 
                                     PORT MAP(CLKOut100, 
                                     PS2_CLK, 
                                     PS2_DATA, 
                                     OPEN, 
                                     KeyData);
VGAColorBar: vga_controller GENERIC MAP(h_pulse => 96, h_bp => 48, h_pixels => 639, h_fp => 16, h_pol => '1', v_pulse => 2, 
                                        v_bp => 33, v_pixels => 479, v_fp =>10, v_pol => '1') PORT MAP(CLKOut25, LockedOut, KeyData, VGA_HS, VGA_VS, VGA_RED, VGA_GRN, VGA_BLU);
u1: x3 PORT MAP(KeyData,LED);
end Behavioral;
