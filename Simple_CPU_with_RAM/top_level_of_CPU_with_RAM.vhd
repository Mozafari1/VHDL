----------------------------------------------------------------------------------
-- Company: 
-- Engineer: RAHMAT MOZAFARI
-- 
-- Create Date: 11.10.2019 21:02:38
-- Design Name: 
-- Module Name: top_level_of_CPU_with_RAM - Behavioral
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

entity top_level_of_CPU_with_RAM is
--  Port ( );
    PORT(
        clk, rst: in std_logic;
        output_bus: out std_logic_vector(7 downto 0)
        );
end top_level_of_CPU_with_RAM;


architecture Behavioral of top_level_of_CPU_with_RAM is
constant ABW,DBW : integer:=8;
signal we: std_logic; -- write enable for RAM
signal addr_bus: std_logic_vector(ABW-1 downto 0);
signal data_bus_1, data_bus_2: std_logic_vector(DBW-1 downto 0);

--data_bus_1 connecting CPU_output_data_bus to CPU_input_data_bus 
-- data_bus_2 connecting CPU_input_data_bus to CPU_output_data_bus 

-- Component from simple_cpu file 
COMPONENT simple_cpu
    PORT 
        (
         clk, rst: in std_logic;
         we: out std_logic;
         CPU_input_data_bus: in std_logic_vector(7 downto 0);
         CPU_output_data_bus, addr_bus: out std_logic_vector(7 downto 0)
         );
end COMPONENT;
 -- component from simple_ram file
 component simple_ram
  generic(
            address, data: integer := 8
            );
    PORT (
          clk, rst, we: in std_logic;
          addr_bus: in std_logic_vector(address-1 downto 0);
          RAM_data_input_bus: in std_logic_vector(data-1 downto 0);
          RAM_data_output_bus: out std_logic_vector(data-1 downto 0)
          );
          
 end component;
begin
    -- Control unit CPU
 control_unit: simple_cpu
    port map(
            clk => clk,
            rst => rst,
            we  => we,
            addr_bus => addr_bus,
            CPU_input_data_bus =>data_bus_2,
            CPU_output_data_bus => data_bus_1
            );
  -- Control RAM unit
ram_unit: simple_ram
    port map(
             clk => clk, 
             rst => rst,
             addr_bus => addr_bus,
             we => we,
             RAM_data_input_bus =>data_bus_1,
             RAM_data_output_bus => data_bus_2
             );
output_bus <= data_bus_1;
end Behavioral;
