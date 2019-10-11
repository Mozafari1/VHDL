library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity dec2to4_tb is
end;

architecture bench of dec2to4_tb is

  component dec2to4
      Port ( in0 : in STD_LOGIC;
             in1 : in STD_LOGIC;
             en : in STD_LOGIC;
             out3 : out STD_LOGIC;
             out2 : out STD_LOGIC;
             out1 : out STD_LOGIC;
             out0 : out STD_LOGIC);
  end component;

  signal in0: STD_LOGIC;
  signal in1: STD_LOGIC;
  signal en: STD_LOGIC;
  signal out3: STD_LOGIC;
  signal out2: STD_LOGIC;
  signal out1: STD_LOGIC;
  signal out0: STD_LOGIC;

begin

  uut: dec2to4 port map ( in0  => in0,
                          in1  => in1,
                          en   => en,
                          out3 => out3,
                          out2 => out2,
                          out1 => out1,
                          out0 => out0 );

  stimulus: process
  begin
  
    -- Put initialisation code here
    in0<='0';
    in1<='0';
    en<='0';
    wait for 20ns;
    
    
    -- Put test bench stimulus code here
    en<='1';
    wait for 20ns;
    
    in0 <='0';
    in1<='1';
    wait for 20ns;
    
    in0 <='1';
    in1<='0';
    wait for 20ns;
    
    in0<= '1';
    in1<='1';
    wait for 20ns;
    wait;
  end process;


end;
  