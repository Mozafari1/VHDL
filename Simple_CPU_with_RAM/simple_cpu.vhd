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
        constant LDMR: unsigned := "10100001"; -- A1
        constant HALT: unsigned := "11111111"; -- FF
        
        TYPE state_type is (
                            all_0, all_1 --This is common to all instructions
                            
                            );
        -- state_previus = st_pre, state_next = st_nxt
        -- program_counter_previus = pc_pre, pc_nxt
        -- instruction_register_next = ir_nxt, ir_pre 
        -- reload_previus = r_pre, reload_next = r_nxt
        signal st_pre, st_nxt: state_type;
        signal pc_pre, pc_nxt: unsigned(ABW-1 downto 0);
        signal ir_pre, ir_nxt, r_pre, r_nxt: unsigned(DBW-1 downto 0);
       
begin
    process(clk, rst)
        -- State register section 
        begin
                if(rst = '1') then 
                    st_pre <= all_0;
                    pc_pre <= (OTHERS => '0'); -- rst addr is all_0
                    ir_pre <= (OTHERS => '1'); -- default setting HALT all_1
                    r_pre  <= (OTHERS => '0'); -- set data register to 0
                elsif( clk 'event and clk ='1') then 
                    st_pre <= st_nxt;
                    pc_pre <= pc_nxt;
                    ir_pre <= ir_nxt;
                    r_pre  <= r_nxt;
                    
                end if;
                
   end process;
   
-- next state and moore outputs
   process(CPU_input_data_bus,st_pre, pc_pre, r_pre)
        begin
            we     <= '0';
            st_nxt <= st_pre;
            pc_nxt <= pc_pre;
            ir_nxt <= ir_pre;
            r_nxt  <= r_pre;
           
            -- Condition check
        if (st_pre = all_0)then 
    --  case st_pre is 
      --      when all_0 =>      
                    ir_nxt <= unsigned(CPU_input_data_bus);
                    pc_nxt <= pc_pre+1;
                    st_nxt <= all_1;
        else
     --    when all_1 =>
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
                else
                    st_nxt <= all_0;
                end if;
       end if;
     --   end case;
   end process;
addr_bus <= std_logic_vector(pc_pre);
CPU_output_data_bus <=std_logic_vector(r_pre);

end Behavioral;
