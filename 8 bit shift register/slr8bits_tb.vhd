----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.09.2019 08:46:04
-- Design Name: 
-- Module Name: slr8bits_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

------------------------------------------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity slr8bits_tb is
end;

architecture bench of slr8bits_tb is

  component slr8bits
      Port ( clockpulse, reset, data_in, diraction, load: in std_logic;
             data_input: in std_logic_vector(7 downto 0);
             data_out: out std_logic_vector (7 downto 0)
  	 );
  end component;

  signal clockpulse, reset, data_in, diraction, load: std_logic;
  signal data_input: std_logic_vector(7 downto 0);
  signal data_out: std_logic_vector (7 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: slr8bits port map ( clockpulse => clockpulse,
                           reset      => reset,
                           data_in    => data_in,
                           diraction  => diraction, -- High priorit
                           load       => load,
                           data_input => data_input,
                           data_out   => data_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
  
     load <='1';
     data_input<="11111111";
     wait for clock_period*2;
     load<='0';
     
     reset<='1';
     wait for clock_period*2;
     reset<='0';
     
     -- Shift left when diraction and data_in is high
     diraction <='1';
     data_in <='1';
     wait for clock_period;
      
     data_in <='0';
     wait for clock_period;
     
     data_in <='1';
     wait for clock_period;
     
     data_in <='0';
     wait for clock_period;
     
     data_in <='1';
     wait for clock_period*4;
     
     reset<='1';
     wait for clock_period;
     reset <='0';
     
     -- Shift right when diraction is LOW and data_in is HIGH
     
     diraction <='0';
     data_in <= '1';
     wait for clock_period;
     
     data_in <='0';
     wait for clock_period;
     
     data_in <='1';
     wait for clock_period;
     
     data_in<='0';
     wait for clock_period;
     
     data_in <='1';
     wait for clock_period*4;
     
     
    reset <='1';
    wait;
    
    -- Put test bench stimulus code here

    stop_the_clock <= True;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clockpulse <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    
    
    wait;
  end process;

end;
  