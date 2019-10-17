----------------------------------------------------------------------------------
-- Company: 
-- Engineer: KIRISAN & RAHMAT
-- 
-- Create Date: 15.10.2019 22:38:16
-- Design Name: 
-- Module Name: rom - arch
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity rom is
   port(
      ab: in std_logic_vector(7 downto 0);
      db: out std_logic_vector(7 downto 0)
   );
end rom;

architecture arch of rom is
   constant ABW,DBW: integer:=8;
   type rom_type is array (0 to 2**ABW-1)
        of std_logic_vector(DBW-1 downto 0);
   -- ROM definition
   constant content: rom_type:=(  -- 2^8-by-8
      "10010000", --  90H
      "01100100", -- MOVE_FW 64H
      "11111111", -- FFH
      "01100100", -- MOVE_FW 64H
      "11111111", -- FFH
      "01100100", -- MOVE_FW 64H
      "11111111", --  FFH   
      "00110010", -- MOVE_BW - 32H
      "11111111", --  FFH
      "01100000", --60H 
      "00110010", -- MOVE_BW - 32H
      "11111111", --  FFH
      "00110010", -- MOVE_BW - 32H
      "11111111", --  FFH
      "10010000", --  90H
      "10010000", --  90H 
      "00010110", -- MOVE_L 16H
      "11111111", -- FFH
      "00010110", -- MOVE_L 16H
      "11111111", --  FFH
      "01100000", -- 60H 
      "01100000", -- 60H  
      "00001000", -- MOVE_R 8H
      "11111111", -- FFH
      "00001000", -- MMOVE_R 8H
      "11111111", -- FFH
      "00001000", -- MOVE_R 8H
      "11111111", --  FFH
      "10010000", --  90H
      "10010000", -- 90H
      "01100100", -- MOVE_FW 64H
      "11111111", --  FFH
      "01100100", -- MOVE_FW 64H
      "11111111", -- FFH
      "01100000", -- 60H 
      "01100000", -- 60H  
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000"  -- addr            
   );
begin
   db <= content(to_integer(unsigned(ab)));
end arch;
