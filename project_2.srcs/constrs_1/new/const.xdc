# Clock signal (100 MHz onboard clock)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports clk]

# Reset signal (Button)
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PULLDOWN true [get_ports reset]

# Enable signal (Switch)
set_property PACKAGE_PIN T18 [get_ports enable]
set_property IOSTANDARD LVCMOS33 [get_ports enable]

# Manual clock button (added as requested)
set_property PACKAGE_PIN T17 [get_ports manual_clock]
set_property IOSTANDARD LVCMOS33 [get_ports manual_clock]
set_property PULLDOWN true [get_ports manual_clock]

# Clock mode switch
set_property PACKAGE_PIN R2 [get_ports clock_mode]
set_property IOSTANDARD LVCMOS33 [get_ports clock_mode]
set_property PULLDOWN true [get_ports clock_mode]

# Zero Flag Output (LED)
set_property PACKAGE_PIN P1 [get_ports debug_out[8]]
set_property IOSTANDARD LVCMOS33 [get_ports debug_out[8]]


# Program Counter Output / Debug output
set_property PACKAGE_PIN U16 [get_ports {debug_out[0]}]
set_property PACKAGE_PIN E19 [get_ports {debug_out[1]}]
set_property PACKAGE_PIN U19 [get_ports {debug_out[2]}]
set_property PACKAGE_PIN V19 [get_ports {debug_out[3]}]
set_property PACKAGE_PIN W18 [get_ports {debug_out[4]}]
set_property PACKAGE_PIN U15 [get_ports {debug_out[5]}]
set_property PACKAGE_PIN U14 [get_ports {debug_out[6]}]
set_property PACKAGE_PIN V14 [get_ports {debug_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports debug_out[*]]

# Seven-Segment Display Anodes (Digits)
set_property PACKAGE_PIN W4 [get_ports {anodes[3]}]
set_property PACKAGE_PIN V4 [get_ports {anodes[2]}]
set_property PACKAGE_PIN U4 [get_ports {anodes[1]}]
set_property PACKAGE_PIN U2 [get_ports {anodes[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[*]]

# Seven-Segment Display Segments (cathodes a-g + dp)
set_property PACKAGE_PIN W7 [get_ports {segments[0]}]
set_property PACKAGE_PIN W6 [get_ports {segments[1]}]
set_property PACKAGE_PIN U8 [get_ports {segments[2]}]
set_property PACKAGE_PIN V8 [get_ports {segments[3]}]
set_property PACKAGE_PIN U5 [get_ports {segments[4]}]
set_property PACKAGE_PIN V5 [get_ports {segments[5]}]
set_property PACKAGE_PIN U7 [get_ports {segments[6]}]
set_property PACKAGE_PIN V7 [get_ports {segments[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports segments[*]]

# Configuration Voltage Settings
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]