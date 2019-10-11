----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari &  Kirisan Manivannan
-- 
-- Create Date: 11.09.2019 19:52:06
-- Design Name: Counter
-- Module Name: counter - Behavioral
-- Project Name: 3 bit counter e-dice
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

entity counter is
    port(
            clk, rst, run, cheat: in std_logic;
            cheat_val: in std_logic_vector(2 downto 0);
            count_res: out std_logic_vector(2 downto 0)
          );
            
end counter;

architecture Behavioral of counter is

signal count: unsigned (2 downto 0) := "001";
signal ffout: unsigned(2 downto 0):= (others=>'0');
begin
    process (clk, rst)
    begin
        if(rst='1') then ffout<="001";
        elsif rising_edge(clk) and run ='1' then 
        count<=count + 1;
        ffout<=count;
        if (cheat ='0') and count ="110" then count<="001";
        elsif cheat ='1' and (count ="111" or count = "000") then
        ffout<= unsigned(cheat_val);
        end if;
        end if;
end process;

count_res<= std_logic_vector(unsigned(ffout)-1);


end Behavioral;
