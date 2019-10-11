----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari &  Kirisan Manivannan
-- 
-- Create Date: 11.09.2019 21:58:04
-- Design Name: 
-- Module Name: top_level_edice - Behavioral
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

entity top_level_edice is
    port(
            clk, rst, run, cheat: in std_logic;
            cheat_val: in std_logic_vector(2 downto 0);
            dot_leds: out std_logic_vector(6 downto 0);
            segments: out std_logic_vector(6 downto 0)
            
          );
end top_level_edice;

architecture Behavioral of top_level_edice is
signal outcome: std_logic_vector(2 downto 0);

  -- component from counter file
    component counter
      port(
              clk, rst, run, cheat: in std_logic;
              cheat_val: in std_logic_vector(2 downto 0);
              count_res: out std_logic_vector(2 downto 0)
            );
  end component;
  


-- component from segmenets file 
  component seg7
      port(
              result: in std_logic_vector(2 downto 0);
              dot_leds: out std_logic_vector(6 downto 0);
              segments: out std_logic_vector(6 downto 0)
              );
  end component;
  


begin

--unit under test

uut_counter: counter port map ( clk       => clk,
                          rst       => rst,
                          run       => run,
                          cheat     => cheat,
                          cheat_val => cheat_val,
                          count_res => outcome
                          );
uut_segments: seg7 port map ( result   => outcome,
                       dot_leds => dot_leds,
                       segments => segments 
                       );

end Behavioral;
