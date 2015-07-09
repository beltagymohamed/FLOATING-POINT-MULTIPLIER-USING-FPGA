add wave -position insertpoint  \
sim:/multiplier/clk
add wave -position insertpoint  \
sim:/multiplier/reset
add wave -position insertpoint  \
sim:/multiplier/addrA
add wave -position insertpoint  \
sim:/multiplier/addrB
add wave -position insertpoint  \
sim:/multiplier/showAB
add wave -position insertpoint  \
sim:/multiplier/start
add wave -position insertpoint  \
sim:/multiplier/outAB
add wave -position insertpoint  \
sim:/multiplier/romAOut
add wave -position insertpoint  \
sim:/multiplier/romBOut
force -freeze sim:/multiplier/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/multiplier/reset 1 0
force -freeze sim:/multiplier/addrA 111 0
force -freeze sim:/multiplier/addrB 111 0
force -freeze sim:/multiplier/showAB 1 0,0 {200ps}