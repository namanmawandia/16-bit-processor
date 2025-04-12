## Clock signal (100 MHz onboard clock)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

## Reset signal (Button)
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Enable signal (Switch)
set_property PACKAGE_PIN T18 [get_ports enable]
set_property IOSTANDARD LVCMOS33 [get_ports enable]

## Zero Flag Output (LED)
set_property PACKAGE_PIN U17 [get_ports zero_flag]
set_property IOSTANDARD LVCMOS33 [get_ports zero_flag]

## Seven-Segment Display Anodes (Digits)
set_property PACKAGE_PIN W4 [get_ports {anode[3]}]
set_property PACKAGE_PIN V4 [get_ports {anode[2]}]
set_property PACKAGE_PIN U4 [get_ports {anode[1]}]
set_property PACKAGE_PIN U2 [get_ports {anode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports anode[*]]

## Seven-Segment Display Cathodes (Segments a-g)
set_property PACKAGE_PIN W7 [get_ports {cathode[6]}]
set_property PACKAGE_PIN W6 [get_ports {cathode[5]}]
set_property PACKAGE_PIN U8 [get_ports {cathode[4]}]
set_property PACKAGE_PIN V8 [get_ports {cathode[3]}]
set_property PACKAGE_PIN U5 [get_ports {cathode[2]}]
set_property PACKAGE_PIN V5 [get_ports {cathode[1]}]
set_property PACKAGE_PIN U7 [get_ports {cathode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports cathode[*]]

## Program Counter Output (pc_out_addr)
set_property PACKAGE_PIN U16 [get_ports {pc_out_addr[0]}]
set_property PACKAGE_PIN E19 [get_ports {pc_out_addr[1]}]
set_property PACKAGE_PIN U19 [get_ports {pc_out_addr[2]}]
set_property PACKAGE_PIN V19 [get_ports {pc_out_addr[3]}]
set_property PACKAGE_PIN W18 [get_ports {pc_out_addr[4]}]
set_property PACKAGE_PIN U15 [get_ports {pc_out_addr[5]}]
set_property PACKAGE_PIN U14 [get_ports {pc_out_addr[6]}]
set_property PACKAGE_PIN V14 [get_ports {pc_out_addr[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports pc_out_addr[*]]