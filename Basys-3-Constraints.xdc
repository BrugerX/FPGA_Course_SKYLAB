## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

set_property IOSTANDARD LVCMOS33 [get_ports *]

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clock]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock] 


set_property PACKAGE_PIN U16 [get_ports {io_sensor_measurement[0]}]
set_property PACKAGE_PIN E19 [get_ports {io_sensor_measurement[1]}]
set_property PACKAGE_PIN U19 [get_ports {io_sensor_measurement[2]}]
set_property PACKAGE_PIN V19 [get_ports {io_sensor_measurement[3]}]
set_property PACKAGE_PIN W18 [get_ports {io_sensor_measurement[4]}]
set_property PACKAGE_PIN U15 [get_ports {io_sensor_measurement[5]}]
set_property PACKAGE_PIN U14 [get_ports {io_sensor_measurement[6]}]
set_property PACKAGE_PIN V14 [get_ports {io_sensor_measurement[7]}]
set_property PACKAGE_PIN V13 [get_ports {io_sensor_measurement2[0]}]
set_property PACKAGE_PIN V3  [get_ports {io_sensor_measurement2[1]}]
set_property PACKAGE_PIN W3  [get_ports {io_sensor_measurement2[2]}]
set_property PACKAGE_PIN U3  [get_ports {io_sensor_measurement2[3]}]
set_property PACKAGE_PIN P3  [get_ports {io_sensor_measurement2[4]}]
set_property PACKAGE_PIN N3  [get_ports {io_sensor_measurement2[5]}]
set_property PACKAGE_PIN P1  [get_ports {io_sensor_measurement2[6]}]
set_property PACKAGE_PIN L1  [get_ports {io_sensor_measurement2[7]}]

set_property PACKAGE_PIN C15 [get_ports {io_sensor_trigger_pin}]
set_property PACKAGE_PIN C16 [get_ports {io_physical_echo_test}]
set_property PACKAGE_PIN A17 [get_ports {io_physical_echo_test2}]

set_property PACKAGE_PIN U17 [get_ports reset]

## 7 segment display
set_property PACKAGE_PIN W7 [get_ports {io_seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {io_seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {io_seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {io_seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {io_seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {io_seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {io_seg[6]}]
#set_property PACKAGE_PIN V7 [get_ports io_dp]
set_property PACKAGE_PIN U2 [get_ports {io_an[0]}]
set_property PACKAGE_PIN U4 [get_ports {io_an[1]}]
set_property PACKAGE_PIN V4 [get_ports {io_an[2]}]
set_property PACKAGE_PIN W4 [get_ports {io_an[3]}]