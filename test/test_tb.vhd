library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity test_tb is
end;

architecture bench of test_tb is

  component test
      Port ( x : in STD_LOGIC;
             y : in STD_LOGIC;
             O : out STD_LOGIC);
  end component;

  signal x: STD_LOGIC;
  signal y: STD_LOGIC;
  signal O: STD_LOGIC;

begin

  uut: test port map ( x => x,
                       y => y,
                       O => O );

  stimulus: process
  begin
  
    -- Put initialisation code here
    x<= '0';
    y<= '0';
    -- Put test bench stimulus code here
    wait for 10ns;
    x<='0'; 
    y<='0';
    wait for 10ns;
    x<= '0';
    y<= '1';
    wait for 10ns;
    x<='1';
    y<='0';
    wait for 10ns;
    x<='1';
    y<='1';
    
    wait;
  end process;


end;