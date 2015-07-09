restart -f 
add wave -position insertpoint  \
sim:/mul_int/in1
add wave -position insertpoint  \
sim:/mul_int/in2
add wave -position insertpoint  \
sim:/mul_int/clk
add wave -position insertpoint  \
sim:/mul_int/rst
add wave -position insertpoint  \
sim:/mul_int/done
add wave -position insertpoint  \
sim:/mul_int/res
force -freeze sim:/mul_int/in1 000000000000000000000011 0
force -freeze sim:/mul_int/in2 000000000000000000000010 0
force -freeze sim:/mul_int/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/mul_int/rst 1 0 
run 400ps