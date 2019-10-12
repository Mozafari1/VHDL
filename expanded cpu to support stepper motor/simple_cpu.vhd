----------------------------------------------------------------------------------
-- This simple CPU with RAM are expanded to support MOVE for stepper motors 
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

entity simple_cpu is
--  Port ( );
    PORT 
        (
         clk, rst: in std_logic;
         we: out std_logic;
         CPU_input_data_bus: in std_logic_vector(7 downto 0);
         CPU_output_data_bus, addr_bus: out std_logic_vector(7 downto 0)
         
         );

end simple_cpu;

architecture Behavioral of simple_cpu is
        constant ABW,DBW: integer:=8;
        constant LDRM: unsigned := "10100000"; -- A0 HEX 
        constant INCR: unsigned := "10110000"; -- B0
        constant JMPM: unsigned := "11000000"; -- C0 
        constant TOGR: unsigned := "11010000"; -- D0
        constant MOVE: unsigned := "11100000"; -- E0 
        constant LDMR: unsigned := "10100001"; -- A1
        constant HALT: unsigned := "11111111"; -- FF
        
        TYPE state_type is (
                            all_0, all_1, move_2, move_3, move_4, move_5, move_6,move_7,move_8  --This is common to all instructions
                            );
        -- state_previus = st_pre, state_next = st_nxt
        -- program_counter_previus = pc_pre, pc_nxt
        -- instruction_register_next = ir_nxt, ir_pre 
        -- reload_previus = r_pre, reload_next = r_nxt
        -- stepper motor data register = smdr
        -- numbers steps count previous = nsc_pre and nxt = next
        -- step duration count previous = sdc_pre and nxt = next
        signal st_pre, st_nxt: state_type;
        signal pc_pre, pc_nxt: unsigned(ABW-1 downto 0);
        signal ir_pre, ir_nxt, r_pre, r_nxt: unsigned(DBW-1 downto 0);
        signal smdr_pre, smdr_nxt: std_logic_vector(7 downto 0);
        signal sdc_pre, sdc_nxt: unsigned(23 downto 0);
        signal nsc_pre, nsc_nxt: unsigned(7 downto 0);
begin
    process(clk, rst)
        -- State register section 
        begin
                if(rst = '1') then 
                    st_pre <= all_0;
                    pc_pre <= (OTHERS => '0'); -- rst addr is all_0
                    ir_pre <= (OTHERS => '1'); -- default setting HALT all_1
                    r_pre  <= (OTHERS => '0'); -- set data register to 0
                    smdr_pre <= (OTHERS => '0'); -- break stppper motors
                    sdc_pre <= (OTHERS => '0'); -- set step duration counter
                    nsc_pre <= (OTHERS => '0'); -- set number of steps counter
                elsif( clk 'event and clk ='1') then 
                    st_pre <= st_nxt;
                    pc_pre <= pc_nxt;
                    ir_pre <= ir_nxt;
                    r_pre  <= r_nxt;
                    smdr_pre <= smdr_nxt;
                    sdc_pre <= sdc_nxt;
                    nsc_pre <= nsc_nxt;
                    
                end if;
                
   end process;
   
-- next state and moore outputs
   process(CPU_input_data_bus,st_pre, pc_pre, r_pre,ir_pre, sdc_pre, nsc_pre)
        begin
            we     <= '0';
            st_nxt <= st_pre;
            pc_nxt <= pc_pre;
            ir_nxt <= ir_pre;
            r_nxt  <= r_pre;
            sdc_nxt <= sdc_pre;
            nsc_nxt <= nsc_pre;
            -- Condition check
      if (st_pre = all_0)then 
   
                    ir_nxt <= unsigned(CPU_input_data_bus);
                    pc_nxt <= pc_pre+1;
                    st_nxt <= all_1;
      elsif(st_pre = all_1) then

                if(ir_pre = LDRM) then
                    r_nxt  <= unsigned(CPU_input_data_bus);
                    pc_nxt <= pc_pre+1;
                    st_nxt <= all_0;
                 elsif(ir_pre = INCR) then
                    r_nxt <= r_pre+1;
                    st_nxt <= all_0;     
                elsif(ir_pre =JMPM) then
                    pc_nxt <= unsigned(CPU_input_data_bus);
                    st_nxt <= all_0;
                elsif( ir_pre = TOGR) then
                    r_nxt <= NOT(r_pre);
                    st_nxt <= all_0;
                elsif(ir_pre = LDMR) then 
                    we <= '1';
                    pc_nxt <= pc_pre+1;
                    st_nxt <= all_0;    
                elsif(ir_pre = HALT) then 
                    st_nxt <= all_1;
                elsif(ir_pre = MOVE) then
                    nsc_nxt <= unsigned(CPU_input_data_bus);
                    sdc_nxt <= "000000000000000000001101"; -- D hex 14 dec
                    pc_nxt <= pc_pre+1;
                    st_nxt <= move_2;
                else
                    st_nxt <= all_0;
                end if;
          -- when move n

          elsif(st_pre = move_2) then
                if(nsc_pre =0) then
                    st_nxt <= all_0;
                else
                    st_nxt <= move_3;
                end if;
  
         elsif(st_pre = move_3) then
                if(nsc_pre =0) then
                    smdr_nxt <= "00000000"; -- set step motor register next to 0 ( break/ stop)
                    st_nxt <= all_0;
                else
                    smdr_nxt <= "00110011"; -- 33 hex 51 dec
                    sdc_nxt <= sdc_pre-1;
                    if(sdc_pre =0) then
                        nsc_nxt <= nsc_pre-1;
                        sdc_nxt <= "000000000000000000001101"; 
                        st_nxt <= move_4;
                     end if;
                 end if;
 
          elsif(st_pre = move_4) then
                if(nsc_pre=0) then
                    smdr_nxt <= "00000000"; -- stop motor
                    st_nxt <= all_0;
                 else
                    smdr_nxt <= "10011001"; --99 hex
                    sdc_nxt <= sdc_pre-1;
                    if(sdc_pre=0) then
                        nsc_nxt <= nsc_pre-1;
                        sdc_nxt <= "000000000000000000001101"; 
                        st_nxt <= move_5;
                    end if;
                 end if;

          elsif(st_pre = move_5) then
                if(nsc_pre=0) then
                    smdr_nxt <= "00000000"; -- stop motor
                    st_nxt <= all_0;
                 else
                    smdr_nxt <= "11001100"; --CC hex
                    sdc_nxt <= sdc_pre-1;
                    if(sdc_pre=0) then
                        nsc_nxt <= nsc_pre-1;
                        sdc_nxt <= "000000000000000000001101"; 
                        st_nxt <= move_6;
                    end if;
                 end if;

         elsif(st_pre = move_6) then
                if(nsc_pre=0) then
                    smdr_nxt <= "00000000"; -- stop motor
                    st_nxt <= all_0;
                 else
                    smdr_nxt <= "01100110"; --66 hex
                    sdc_nxt <= sdc_pre-1;
                    if(sdc_pre=0) then
                        nsc_nxt <= nsc_pre-1;
                        sdc_nxt <= "000000000000000000001101"; 
                        st_nxt <= move_7;
                    end if;
                 end if;

       elsif(st_pre = move_7) then
                if(nsc_pre=0) then
                    smdr_nxt <= "00000000"; -- stop motor
                    st_nxt <= all_0;
                 else
                    smdr_nxt <= "01101011"; --6B hex
                    sdc_nxt <= sdc_pre-1;
                    if(sdc_pre=0) then
                        nsc_nxt <= nsc_pre-1;
                        sdc_nxt <= "000000000000000000001101"; 
                        st_nxt <= move_8;
                    end if;
                 end if;
       elsif(st_pre = move_8) then
                if(nsc_pre=0) then
                    smdr_nxt <= "00000000"; -- stop motor
                    st_nxt <= all_0;
                 else
                    smdr_nxt <= "01100111"; --67 hex
                    sdc_nxt <= sdc_pre-1;
                    if(sdc_pre=0) then
                        nsc_nxt <= nsc_pre-1;
                        sdc_nxt <= "000000000000000000001101"; 
                        st_nxt <= move_2;
                    end if;
                 end if;
       end if;
   end process;
addr_bus <= std_logic_vector(pc_pre);
CPU_output_data_bus <=std_logic_vector(smdr_pre);

end Behavioral;
