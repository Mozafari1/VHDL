----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2019 15:22:12
-- Design Name: 
-- Module Name: dec2to4 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dec2to4 is
    Port ( in0 : in STD_LOGIC;
           in1 : in STD_LOGIC;
           en : in STD_LOGIC;
           out3 : out STD_LOGIC;
           out2 : out STD_LOGIC;
           out1 : out STD_LOGIC;
           out0 : out STD_LOGIC);
end dec2to4;

architecture Behavioral of dec2to4 is

begin
    out3 <= in1 and in0 and en;
    out2 <= in1 and not(in0) and en;
    out1 <= not(in1) and in0 and en;
    out0 <= not(in1) and not(in0) and en;

end Behavioral;
