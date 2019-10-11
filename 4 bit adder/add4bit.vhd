----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2019 18:17:54
-- Design Name: 
-- Module Name: add4bit - arch
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
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity add4bit is
  Port (
         opA, opB: in std_logic_vector(3 downto 0);
         resC: out std_logic_vector(4 downto 0)
         );
end add4bit;

architecture arch of add4bit is
signal valA, valB: unsigned (4 downto 0);
signal valC: unsigned (4 downto 0);
begin
    valA<= unsigned('0' & opA);
    valB<= unsigned('0' & opB);
    valC<=opA+opB;
    resC<= std_logic_vector(valC);
end arch;
