restart -f
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
sim:/multiplier/result
add wave -position insertpoint  \
sim:/multiplier/outAB
add wave -position insertpoint  \
sim:/multiplier/res_mult
force clk 0 0ns,1 10ns -r 20ns
force -freeze sim:/multiplier/addrB 111 0
force -freeze sim:/multiplier/showAB 1 0
force -freeze sim:/multiplier/start 0 0


force -freeze sim:/multiplier/reset 1 0
force -freeze sim:/multiplier/addrA 111 0



run 500ns
