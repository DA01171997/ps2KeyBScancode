
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_str IS
END tb_str;
 
ARCHITECTURE behavior OF tb_str IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
component FGDATopLevel is
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
      
    end component;

    

   --Inputs
   signal CLK100MHz : std_logic := '0';
   signal PS2CLK : std_logic := '0';
   signal KeyboardData : std_logic := '0';
--   signal Start : std_logic := '0';
 --  signal Din : INTEGER := 0;

    --Outputs
  -- signal Done : std_logic;
  -- signal Dout : INTEGER;
  signal HS : Std_logic;
  signal VS : Std_logic;
  signal VGAR : std_logic_vector(3 downto 0);
  signal VGAG : std_logic_vector(3 downto 0);
  signal VGAB : std_logic_vector(3 downto 0);
  signal LEDs : std_logic_vector(7 downto 0);

   -- Clock period definitions
   -- Adjust to your actual clock cycle!
   constant Clk_period : time := 10 ns;
   constant PS2CLK_period : time := 40 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: FGDATopLevel PORT MAP (
          CLK100MHz => CLK100MHz,
          PUSHBTN => '0',
          PS2_CLK => PS2CLK,
          PS2_DATA => keyboarddata,
          VGA_HS => HS,
          VGA_VS => VS,
          VGA_RED => VGAR,
          VGA_GRN => VGAG,
          VGA_BLU => VGAB,
          LED => LEDs
        );

   -- Clock process definitions
   Clk_process :process
   begin
        CLK100MHz <= '0' after Clk_period/2, '1' after 2*Clk_period/2;
        wait for 2*clk_period/2;
   end process;
   
 PS2Clk_process :process
   begin
        PS2CLK <= '0';
        wait for PS2CLK_period/2;
        PS2CLK <= '1';
        wait for PS2CLK_period/2;
   end process;
   
  tb : PROCESS
  BEGIN

     -- keyboarddata <= '1';

    wait;
    END PROCESS;
    END;
