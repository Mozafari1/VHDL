----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari
-- 
-- Create Date: 11.10.2019 14:55:18
-- Design Name: 
-- Module Name: simple_cpu - Behavioral
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
entity tb_simple_cpu is
end tb_simple_cpu;

architecture tb of tb_simple_cpu is
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
 constant ABW,DBW : integer:=8;
signal we: std_logic; -- write enable for RAM
    -- Time period
    constant clk_period : time := 10 ns; 
-- Inputs signal
    signal clk, rst: std_logic := '0';
-- Output signal 

 signal addr_bus: std_logic_vector(ABW-1 downto 0);
signal RAM_data_input_bus, RAM_data_output_bus,CPU_output_data_bus, CPU_input_data_bus: std_logic_vector(DBW-1 downto 0);
begin

 control_unit: simple_cpu
    port map(
            clk => clk,
            rst => rst,
            we  => we,
            addr_bus => addr_bus,
            CPU_input_data_bus =>CPU_input_data_bus,
            CPU_output_data_bus => CPU_output_data_bus
            );
  -- Control RAM unit
ram_unit: simple_ram
    port map(
             clk => clk, 
             rst => rst,
             addr_bus => addr_bus,
             we => we,
             RAM_data_input_bus =>RAM_data_input_bus,
             RAM_data_output_bus => RAM_data_output_bus
             );
    -- Clock generation
    clk_process :process
        begin
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
    end process;
    -- stim process
stim: process
    begin
        rst <= '1';
        wait for clk_period*2;
        rst <= '0';
        CPU_input_data_bus  <= "11100000"; --move
        wait for clk_period;
        CPU_input_data_bus  <= "00001000"; --8 moves
        wait for clk_period*600;
end process;
    
end ;
