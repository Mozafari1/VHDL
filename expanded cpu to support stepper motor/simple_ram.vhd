----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari
-- 
-- Create Date: 11.10.2019 20:17:41
-- Design Name: 
-- Module Name: simple_ram - Behavioral
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

entity simple_ram is
    -- asynchronous
    generic(
            address, data: integer := 8
            ); 
    -- PORT()
    PORT (
          clk, rst, we: in std_logic;
          addr_bus: in std_logic_vector(address-1 downto 0);
          RAM_data_input_bus: in std_logic_vector(data-1 downto 0);
          RAM_data_output_bus: out std_logic_vector(data-1 downto 0)
          );
end simple_ram;
    
architecture Behavioral of simple_ram is
    TYPE type_of_RAM is array(0 to 2**address-1) OF std_logic_vector(data-1 downto 0);
    signal RAM: type_of_RAM := (others => x"FF");

begin
    process (clk, rst)
        begin
            if(rst = '1') then 
                RAM(0) <= x"A0"; -- LDR M
                RAM(1) <= x"55"; --M's data
                RAM(2) <= x"B0"; -- INC R
                RAM(3) <= x"B0"; 
                RAM(4) <= x"A1"; -- LD M R
            elsif(clk'EVENT AND clk ='1') then
                if(we='1') then
                    RAM(TO_INTEGER(UNSIGNED(addr_bus))) <= RAM_data_input_bus;
                end if;
            end if;
   end process;
   
RAM_data_output_bus <= RAM(TO_INTEGER(UNSIGNED(addr_bus)));
end Behavioral;