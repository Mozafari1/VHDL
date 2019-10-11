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

    component simple_cpu
        port (data_bus   : in std_logic_vector (7 downto 0);
              addr_bus,output_bus   : out std_logic_vector (7 downto 0);
              clk, rst: in std_logic
              );
    end component;

    signal data_bus   : std_logic_vector (7 downto 0);
    signal addr_bus ,output_bus  : std_logic_vector (7 downto 0);
  

    constant clk_period : time := 10 ns; 
    signal clk, rst: std_logic := '0';


begin

    uut : simple_cpu
    port map (clk        => clk,
              rst        => rst,
              data_bus   => data_bus,
              addr_bus   => addr_bus,
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
   stim_process: process
    begin
        rst <= '1';
        data_bus <= "11111111"; -- set to HALT
        wait for clk_period*2;
            rst <= '0';
            data_bus <="10110000"; -- set to JMPM
            wait for clk_period*3;
            data_bus <= "11111111"; -- set agin to HALT
            wait for clk_period*40;
            
    end process;
    
    
end ;


