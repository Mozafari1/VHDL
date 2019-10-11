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

    component top_level_of_CPU_with_RAM
         PORT(
            clk, rst: in std_logic;
            output_bus: out std_logic_vector(7 downto 0)
            );
        
    end component;
    -- Time period
    constant clk_period : time := 10 ns; 
-- Inputs signal
    signal clk, rst: std_logic := '0';
-- Output signal 
    signal output_bus: std_logic_vector (7 downto 0);

begin

    uut : top_level_of_CPU_with_RAM
         port map (
              clk        => clk,
              rst        => rst,
              output_bus => output_bus
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
        wait for clk_period*40;
end process;
    
end ;


