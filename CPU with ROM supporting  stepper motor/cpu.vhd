----------------------------------------------------------------------------------
-- Company: 
-- Engineer: RAHMAT MOZAFARI
-- 
-- Create Date: 15.10.2019 22:38:16
-- Design Name: 
-- Module Name: cpu - arch
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
library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity	cpu is
	port(
		clk, rst: in std_logic;
		db: in std_logic_vector(7 downto 0);  -- data bus
		ab,ob: out std_logic_vector(7 downto 0) -- address bus
        );
end cpu;

architecture arch of cpu is
-- CPU instructions
    constant ABW,DBW: integer:=8;
    constant LDRM: unsigned := "10100000"; -- A0H	
	constant INCR: unsigned := "10110000"; -- B0H
	constant DECR: unsigned := "11010000"; -- D0H
	constant JMPM: unsigned := "11000000"; -- C0H
	constant JRNZ: unsigned := "00110000"; -- 30H  -- Toggle
	constant MOVE_FW: unsigned := "10000000"; -- 80H
	constant MOVE_BW: unsigned := "01000000"; -- 40H
	constant MOVE_L: unsigned := "00100000"; -- 20H
	constant MOVE_R: unsigned := "00010000"; -- 10H
	constant HALT: unsigned := "11111111"; -- FFH
	
	---------------------------------------
	-- state machine states
	type	state_type is (
		  all_0, all_1,   -- common to all instructions
		  move_2, move_3, move_4, move_5, move_6 -- specific for move instruction
		 );
    
    -- internal signals
        -- state_previus = st_pre, state_next = st_nxt
        -- program_counter_previus = pc_pre, pc_nxt
        -- instruction_register_next = ir_nxt, ir_pre 
        -- reload_previus = r_pre, reload_next = r_nxt
        -- stepper motor data register = smdr
        -- numbers steps count previous = nsc_pre and nxt = next
        -- step duration count previous = sdc_pre and nxt = next
	signal	st_pre, st_nxt:	state_type; -- state register
	signal	pc_pre, pc_nxt: unsigned(ABW-1 downto 0);
	signal	ir_pre, ir_nxt,r_pre, r_nxt: unsigned(DBW-1 downto 0);
	signal  smdr_pre, smdr_nxt: std_logic_vector(7 downto 0);
	signal sdc_pre, sdc_nxt: unsigned(23 downto 0);
    signal nsc_pre, nsc_nxt: unsigned(7 downto 0);


begin

process(clk,rst)						-- state register code section
begin
	if (rst='1') then
		st_pre <= all_0;
		pc_pre <= (others => '0');	-- reset address is all-0
		ir_pre <= (others => '1'); 	-- default opcode is HALT (all '1')
		r_pre  <= (others => '0');	-- initialize data register to 0
		smdr_pre <= (others => '0');	-- stop stepper motors
	     sdc_pre <= (OTHERS => '0'); -- set step duration counter
         nsc_pre <= (OTHERS => '0'); -- set number of steps counter

	elsif (clk'event and clk='1') then -- equivalent to rising edge(clk)
		st_pre <= st_nxt;
		pc_pre <= pc_nxt;
		ir_pre <= ir_nxt;
		r_pre <= r_nxt;
		smdr_pre <= smdr_nxt;
        sdc_pre <= sdc_nxt;
        nsc_pre <= nsc_nxt;

	end if;
end process;

process(st_pre,db,pc_pre,r_pre,sdc_pre, nsc_pre)
begin
    -- default values
	st_nxt <= st_pre;
	pc_nxt <= pc_pre;	
	ir_nxt <= ir_pre;
	r_nxt <= r_pre; -- DR 

    sdc_nxt <= sdc_pre;
    nsc_nxt <= nsc_pre;
	
-- condition
	if(st_pre =all_0) then
			ir_nxt <= unsigned(db);  
			pc_nxt <= pc_pre+1;
			st_nxt <= all_1;
	elsif(st_pre= all_1) then
			if (ir_pre = LDRM) then	  -- Load DR
			    r_nxt <= unsigned(db);
                pc_nxt <= pc_pre+1;
				st_nxt <= all_0;
			
			elsif (ir_pre = INCR) then -- INC DR
                 r_nxt <= r_pre+1;            
                 st_nxt <= all_0;
            
            elsif (ir_pre = DECR) then -- DEC DR
                 r_nxt <= r_pre-1;            
                 st_nxt <= all_0;
                 
			elsif (ir_pre = JMPM) then -- JMP to memory address
			    pc_nxt <= unsigned(db);		    
                st_nxt <= all_0;
                
            elsif (ir_pre = JRNZ) then -- JMP if not zero
			    if (r_pre = "00000000") then -- if zero increment PC
			         pc_nxt <= pc_pre + 1;
			         st_nxt <= all_1; 
			    else                         -- if not zero jump
                    pc_nxt <= unsigned(db);		    
                    st_nxt <= all_0;
               end if;
               
            elsif (ir_pre = MOVE_FW) then -- Move forward
			    nsc_nxt  <= unsigned(db);
			        sdc_nxt <= "000010011100010000000000"; --640000
                pc_nxt <= pc_pre+1;
				st_nxt <= move_2;
                
            elsif (ir_pre = MOVE_BW) then -- Move backward
			    nsc_nxt  <= unsigned(db);
			        sdc_nxt <= "000010011100010000000000"; --640000
                pc_nxt <= pc_pre+1;
				st_nxt <= move_2;
                
            elsif (ir_pre = MOVE_R) then -- Move right
			    nsc_nxt  <= unsigned(db);
			        sdc_nxt <= "000010011100010000000000"; --640000
                pc_nxt <= pc_pre+1;
				st_nxt <= move_2;
                
            elsif (ir_pre = MOVE_L) then -- Move left
			    nsc_nxt  <= unsigned(db);
			        sdc_nxt <= "000010011100010000000000"; --640000
                pc_nxt <= pc_pre+1;
				st_nxt <= move_2;

			elsif (ir_pre = HALT) then -- HALT
				st_nxt <= all_1;
			
			else 
				st_nxt <= all_0;
			end if;

	elsif(st_pre=move_2) then
		  if(nsc_pre  = 0) then
		      st_nxt <= all_0;
			else
				st_nxt <= move_3;
			end if;
	elsif(st_pre = move_3) then
		  if (nsc_pre =0) then
				smdr_nxt <= "00000000"; 
				st_nxt <= all_0;
			else
				if (ir_pre = MOVE_FW) then
				    smdr_nxt <= "00110011";
				elsif (ir_pre = MOVE_BW) then 
				    smdr_nxt <= "00110011";
				elsif (ir_pre = MOVE_L) then
				    smdr_nxt <= "00111100";
				elsif (ir_pre = MOVE_R) then 
				    smdr_nxt <= "00111100";
				end if;  
				sdc_nxt  <= sdc_pre-1;
				if (sdc_pre =0) then
					nsc_nxt <= nsc_pre-1;
			        sdc_nxt <= "000010011100010000000000"; --640000
					st_nxt <= move_4;
				end if;
			end if;
	elsif(st_pre = move_4) then
		  if (nsc_pre=0) then
				smdr_nxt <= "00000000";
				st_nxt <= all_0;
			else
				if (ir_pre = MOVE_FW) then 
				    smdr_nxt <= "10011001";
				elsif (ir_pre = MOVE_BW) then
				    smdr_nxt <= "01100110";
				elsif (ir_pre = MOVE_L) then 
				    smdr_nxt <= "10010110";
				elsif (ir_pre = MOVE_R) then 
				    smdr_nxt <= "01101001";
				end if;
				sdc_nxt <= sdc_pre-1;
				if (sdc_pre=0) then
					nsc_nxt <= nsc_pre-1;
			        sdc_nxt <= "000010011100010000000000"; --640000
					st_nxt <= move_5;
				end if;
			end if;
	elsif(st_pre = move_5)then
		  if (nsc_pre=0) then
				smdr_nxt <= "00000000";
				st_nxt <= all_0;
			else
				if (ir_pre = MOVE_FW) then 
				    smdr_nxt <= "11001100";
				elsif (ir_pre = MOVE_BW) then 
				    smdr_nxt <= "11001100";
				elsif (ir_pre = MOVE_L) then 
				    smdr_nxt <= "11001100";
				elsif (ir_pre = MOVE_R) then
				    smdr_nxt <= "11001100";
				end if;
				
				sdc_nxt <= sdc_pre-1;
				if (sdc_pre=0) then
					nsc_nxt <= nsc_pre-1;
			        sdc_nxt <= "000010011100010000000000"; --640000
					st_nxt <= move_6;
				end if;
			end if;
	elsif(st_pre = move_6) then
		  if (nsc_pre=0) then
				smdr_nxt <= "00000000"; 
				st_nxt <= all_0;
			else
				if (ir_pre = MOVE_FW) then 
				    smdr_nxt <= "01100110"; 
				elsif (ir_pre = MOVE_BW) then 
				    smdr_nxt <= "10011001"; 
				elsif (ir_pre = MOVE_L) then 
				    smdr_nxt <= "01101001"; 
				elsif (ir_pre = MOVE_R) then 
				    smdr_nxt <= "10010110";
				end if;
				
				sdc_nxt <= sdc_pre-1;
				if (sdc_pre=0) then
					nsc_nxt <= nsc_pre-1;
               --     sdc_nxt <= "000001111010000100011111"; -- 499999Decimal
			        sdc_nxt <= "000010011100010000000000"; --640000
					st_nxt <= move_2;
				end if;
			end if;
		
	end if;		
end process;

ab <= std_logic_vector(pc_pre);
ob <= std_logic_vector(smdr_pre);

end arch;


