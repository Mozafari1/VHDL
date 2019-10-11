library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity and_gate_tb is
end;

architecture bench of and_gate_tb is

  component and_gate
      Port ( a : in STD_LOGIC;
             b : in STD_LOGIC;
             X : out STD_LOGIC);
  end component;

  signal a: STD_LOGIC;
  signal b: STD_LOGIC;
  signal X: STD_LOGIC;

begin

  uut: and_gate port map ( a => a,
                           b => b,
                           X => X );

  stimulus: process
  begin
  
    -- Put initialisation code here
    a <= '0';
    b <= '0';
    

    -- Put test bench stimulus code here
    wait for 10ns;
    a <= '0';
    b <= '0';
    wait for 10ns;
    a <= '0';
    b <= '1';
    wait for 10ns;
    a <= '1';
    b <= '0';
    wait for 10ns;
    a <= '1';
    b <= '1';
    
    wait;
  end process;


end;
  