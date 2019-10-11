----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari &  Kirisan Manivannan
-- 
-- Create Date: 11.09.2019 22:15:53
-- Design Name: 
-- Module Name: top_level_edice_tb - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level_edice_tb is
end;

architecture bench of top_level_edice_tb is

  component top_level_edice
      port(
              clk, rst, run, cheat: in std_logic;
              cheat_val: in std_logic_vector(2 downto 0);
              dot_leds: out std_logic_vector(6 downto 0);
              segments: out std_logic_vector(6 downto 0)
            );
  end component;

  signal clk, rst, run, cheat: std_logic;
  signal cheat_val: std_logic_vector(2 downto 0);
  signal dot_leds: std_logic_vector(6 downto 0);
  signal segments: std_logic_vector(6 downto 0) ;
  
  constant clock_period: time:=10ns;
  signal stop_the_clock: boolean;
   
begin

  uut: top_level_edice port map ( clk       => clk,
                                  rst       => rst,
                                  run       => run,
                                  cheat     => cheat,
                                  cheat_val => cheat_val,
                                  dot_leds  => dot_leds,
                                  segments  => segments );

  stimulus: process
  begin
  
    cheat<='0';
    cheat_val<="010";
    run<='1';
    rst<='1';
    wait for clock_period;
      
    -- Put initialisation code here
  
    rst<='0';
    wait for clock_period*8;
    
    cheat<='1';
    wait for clock_period*8;
    
    run <='0';
    wait for clock_period*4;
    
    run <='1';
    wait for clock_period*4;
    
    cheat<='1';
    wait for clock_period*8;
    
    cheat_val<="000";
    wait for clock_period*8;
    
    -- Put test bench stimulus code here
    
    stop_the_clock<=true;
    wait;
  end process;

clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;