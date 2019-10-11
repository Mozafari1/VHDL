----------------------------------------------------------------------------------

-- Engineer: Rahmat Mozafari
-- Design File
-- Create Date: 29.08.2019 16:48:51
-- Design Name: 
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
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder_1bit is
    Port(
        A,B, C_in: in std_logic;
        Sum, C_out: out std_logic
        );
end adder_1bit;

architecture Behavioral of adder_1bit is

begin
    Sum <= 
           ((not C_in) and (not B) and A)
         or((not C_in) and B and (not A ))
         or(C_in and (not B) and (not A))
         or(C_in and B and A);
         
     C_out <= 
             ((not c_in) and B and A)
           or(C_in and (not B) and A)
           or(C_in and B and (not A))
           or(c_in and B and A);
    
end Behavioral;
