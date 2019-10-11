----------------------------------------------------------------------------------

-- Engineer: Rahmat Mozafari
-- Simulation File
-- Create Date: 29.08.2019 16:48:51
-- Module Name: adder_1bit - Behavioral
-- Project Name: VHDL
-- Target Devices: 
-- Tool Versions: 

-- Task 3: 
-- Build a VHDL design file to describe the 1-bit adder that you have just created.
-- To understand this you must have to look at the task 1 and 2

-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity adder_1bit_tb is
end;

architecture bench of adder_1bit_tb is

  component adder_1bit
      Port(
          A,B, C_in: in std_logic;
          Sum, C_out: out std_logic
          );
  end component;

  signal A,B, C_in: std_logic;
  signal Sum, C_out: std_logic ;

begin

  uut: adder_1bit port map ( A     => A,
                             B     => B,
                             C_in  => C_in,
                             Sum   => Sum,
                             C_out => C_out );

  stimulus: process
  begin
        A<='0';
        B<='0';
        C_in<='0';
        wait for 10ns;
        
    -- Put initialisation code here
        A<='1';
        B<='0';
        C_in<='0';
        wait for 10ns;
        
        A<='0';
        B<='1';
        C_in<='0';
        wait for 10ns;
        
        A<='1';
        B<='1';
        C_in<='0';
        wait for 10ns;
        
        A<='0';
        B<='0';
        C_in<='1';
        wait for 10ns;
        
        A<='1';
        B<='0';
        C_in<='1';
        wait for 10ns;
        
        A<='0';
        B<='1';
        C_in<='1';
        wait for 10ns;
        
        A<='1';
        B<='1';
        C_in<='1';
        wait for 10ns;
    -- Put test bench stimulus code here

    wait;
  end process;


end;