----------------------------------------------------------------------------------
-- Company: 
-- Engineer: RAHMAT MOZAFARI
-- 
-- Create Date: 15.10.2019 22:38:16
-- Design Name: 
-- Module Name: top - arch
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
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port(
			clk, rst: in std_logic;
			ob: out std_logic_vector(7 downto 0)
		);
end top;

architecture arch of top is
	constant ABW,DBW: integer := 8; -- address & data bus width
    signal ab: std_logic_vector(ABW-1 downto 0);
	signal db: std_logic_vector(DBW-1 downto 0);	
	
component cpu
    port(
        clk, rst: in std_logic;
        db: in std_logic_vector(7 downto 0);
        ab: out std_logic_vector(7 downto 0);
        ob: out std_logic_vector(7 downto 0)
        );
end component;
        
component rom
    port(
      ab: in std_logic_vector(7 downto 0);
      db: out std_logic_vector(7 downto 0)
        );        
end component;

begin  
        
	  ctr_unit: cpu	
      port map ( clk => clk, rst => rst,
                 ab => ab, db => db, ob => ob
				);
					
      rom_unit: rom	
      port map( ab => ab, 
				db => db
				);	  
					
end  arch;

