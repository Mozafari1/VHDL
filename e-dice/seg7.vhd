----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari &  Kirisan Manivannan
-- 
-- Create Date: 11.09.2019 19:03:43
-- Design Name: 
-- Module Name: seg7 - Behavioral
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

entity seg7 is
    port(
            result: in std_logic_vector(2 downto 0);
            dot_leds: out std_logic_vector(6 downto 0);
            segments: out std_logic_vector(6 downto 0)
            );
end seg7;

architecture Behavioral of seg7 is

begin 


   process(result)
    begin
    case result is
 -- segments
    when "000" => segments <= "1111001"; --1
    when "001" => segments <= "0100100";
    when "010" => segments <= "0110000";
    when "011" => segments <= "0011001"; --4
    when "100" => segments <= "0010010"; 
    when "101" => segments <= "0000010"; --6
    when OTHERS=> segments <= "1111111"; --7,8,9

    end case;
    case result is
        -- leds
 
    when "000" => dot_leds <= "0000001"; 
    when "001" => dot_leds <= "0100100"; 
    when "010" => dot_leds <= "0011001"; 
    when "011" => dot_leds <= "1011010"; 
    when "100" => dot_leds <= "1011011"; 
    when "101" => dot_leds <= "1111110";
    when OTHERS=> dot_leds <= "0000000"; --7,8,9
    end case;
    
    end process;
    
end Behavioral;
