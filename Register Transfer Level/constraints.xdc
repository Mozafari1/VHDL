# This file is general xdc
# Constraints file for 1 bit adder
# Run this file and check it with your logic table/truth table for 1 bit adder
# Switches
set_property PACKAGE_PIN V17 [get_ports {A}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A}]
set_property PACKAGE_PIN V16 [get_ports {B}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B}]
set_property PACKAGE_PIN W16 [get_ports {C_in}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {C_in}]

 

# LEDs
set_property PACKAGE_PIN U16 [get_ports {Sum}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sum}]
set_property PACKAGE_PIN E19 [get_ports {C_out}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {C_out}]
